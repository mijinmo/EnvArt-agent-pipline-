class_name EACameraRig
extends Node3D
## Camera ownership lives here. Future rail cameras can use an external director.

enum Mode { FIRST_PERSON, THIRD_PERSON, FREE_LOOK, RAIL }
signal mode_changed(mode: Mode)

@export var target: EAPlayerMotor
@export var rail_camera: EARailCamera
@export var initial_mode: Mode = Mode.THIRD_PERSON
@export_range(0.0001, 0.02, 0.0001) var mouse_sensitivity: float = 0.0025
@export_range(30.0, 110.0, 1.0) var field_of_view: float = 75.0
@export_range(1.0, 10.0, 0.1) var third_person_distance: float = 4.0
@export_range(0.1, 50.0, 0.1) var free_speed: float = 6.0
@export_flags_3d_physics var camera_collision_mask: int = 1

@onready var first_pivot: Node3D = $FirstPivot
@onready var first_camera: Camera3D = $FirstPivot/Camera3D
@onready var third_pivot: Node3D = $ThirdPivot
@onready var arm: SpringArm3D = $ThirdPivot/SpringArm3D
@onready var third_camera: Camera3D = $ThirdPivot/SpringArm3D/Camera3D
@onready var free_camera: Camera3D = $FreeCamera

var mode: Mode = Mode.THIRD_PERSON
var yaw: float = 0.0
var pitch: float = -0.12
var _return_mode: Mode = Mode.THIRD_PERSON
var _rail_return_mode: Mode = Mode.THIRD_PERSON
var _free_yaw: float = 0.0
var _free_pitch: float = 0.0
var _free_motion := Vector3.ZERO
var _free_fast := false


func _ready() -> void:
	assert(target != null, "Camera rig needs an explicit player target.")
	process_physics_priority = 10
	# Cast after the motor and follow pivots have updated this physics frame.
	arm.process_physics_priority = 20
	arm.add_excluded_object(target.get_rid())
	arm.collision_mask = camera_collision_mask
	arm.spring_length = third_person_distance
	for camera: Camera3D in [first_camera, third_camera, free_camera]:
		camera.fov = field_of_view
	yaw = target.global_rotation.y
	_sync_follow()
	# Give the initial free view a valid origin even before the first arm cast.
	third_camera.position.z = third_person_distance
	if not set_mode(initial_mode):
		set_mode(Mode.THIRD_PERSON)


func active_camera() -> Camera3D:
	match mode:
		Mode.FIRST_PERSON: return first_camera
		Mode.FREE_LOOK: return free_camera
		Mode.RAIL: return rail_camera.camera
	return third_camera


func set_mode(next_mode: Mode, restore_free_pose: bool = false) -> bool:
	if next_mode == Mode.RAIL and (not is_instance_valid(rail_camera) or not rail_camera.is_usable()):
		return false
	if next_mode == Mode.RAIL and mode != Mode.RAIL:
		_rail_return_mode = mode
	if next_mode == Mode.FREE_LOOK and mode != Mode.FREE_LOOK:
		if mode != Mode.RAIL:
			_return_mode = mode
		elif _rail_return_mode != Mode.FREE_LOOK:
			_return_mode = _rail_return_mode
		if not restore_free_pose:
			var source := active_camera()
			free_camera.global_transform = source.global_transform
			free_camera.fov = source.fov
			_free_yaw = free_camera.global_rotation.y
			_free_pitch = free_camera.global_rotation.x
	if mode == Mode.RAIL and next_mode != Mode.RAIL:
		rail_camera.deactivate()
	mode = next_mode
	_free_motion = Vector3.ZERO
	target.clear_motion()
	_sync_follow()
	if mode == Mode.RAIL:
		rail_camera.activate()
	else:
		active_camera().make_current()
	target.visual.visible = mode != Mode.FIRST_PERSON
	mode_changed.emit(mode)
	return true


func toggle_rail_view() -> void:
	if mode == Mode.RAIL:
		set_mode(_rail_return_mode, true)
	else:
		set_mode(Mode.RAIL)


func toggle_person_view() -> void:
	var previous := _return_mode if mode in [Mode.FREE_LOOK, Mode.RAIL] else mode
	if mode == Mode.RAIL and _rail_return_mode != Mode.FREE_LOOK:
		previous = _rail_return_mode
	set_mode(Mode.THIRD_PERSON if previous == Mode.FIRST_PERSON else Mode.FIRST_PERSON)


func toggle_free_view() -> void:
	set_mode(_return_mode if mode == Mode.FREE_LOOK else Mode.FREE_LOOK)


func look(relative_pixels: Vector2) -> void:
	if mode == Mode.RAIL:
		return
	var change := relative_pixels * mouse_sensitivity
	if mode == Mode.FREE_LOOK:
		_free_yaw = wrapf(_free_yaw - change.x, -PI, PI)
		_free_pitch = clampf(_free_pitch - change.y, deg_to_rad(-85.0), deg_to_rad(85.0))
		free_camera.global_rotation = Vector3(_free_pitch, _free_yaw, 0.0)
	else:
		yaw = wrapf(yaw - change.x, -PI, PI)
		pitch = clampf(pitch - change.y, deg_to_rad(-80.0), deg_to_rad(80.0))


func movement_direction(input_axis: Vector2) -> Vector3:
	return Basis(Vector3.UP, yaw) * Vector3(input_axis.x, 0.0, input_axis.y)


func set_free_motion(direction: Vector3, fast: bool) -> void:
	_free_motion = direction.limit_length()
	_free_fast = fast


func adjust_distance_or_speed(steps: float) -> void:
	if mode == Mode.FREE_LOOK:
		free_speed = clampf(free_speed * pow(1.2, steps), 0.5, 40.0)
	elif mode == Mode.THIRD_PERSON:
		third_person_distance = clampf(third_person_distance - steps * 0.4, 1.2, 8.0)
		arm.spring_length = third_person_distance


func reset_view(heading: float) -> void:
	yaw = heading
	pitch = -0.12
	if mode == Mode.RAIL:
		set_mode(_rail_return_mode if _rail_return_mode != Mode.FREE_LOOK else _return_mode)
	elif mode == Mode.FREE_LOOK:
		set_mode(_return_mode)
	_sync_follow()


func _sync_follow() -> void:
	first_pivot.global_position = target.eye.global_position
	first_pivot.global_rotation = Vector3(pitch, yaw, 0.0)
	third_pivot.global_position = target.eye.global_position
	third_pivot.global_rotation = Vector3(pitch, yaw, 0.0)


func _physics_process(delta: float) -> void:
	_sync_follow()
	if mode == Mode.FREE_LOOK:
		var travel := free_camera.global_basis * Vector3(_free_motion.x, 0.0, _free_motion.z)
		travel += Vector3.UP * _free_motion.y
		free_camera.global_position += travel.limit_length() * free_speed * (3.0 if _free_fast else 1.0) * delta
	elif mode == Mode.THIRD_PERSON:
		# Hide the proxy if the arm retracts inside it in a confined space.
		target.visual.visible = third_camera.global_position.distance_to(target.eye.global_position) > target.profile.radius + 0.3
