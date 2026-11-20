class_name EAPlayerMotor
extends CharacterBody3D
## Physics only: callers submit world-space movement. No Input or camera dependency.

@export var profile: EAPlayerProfile
@onready var body_shape: CollisionShape3D = $BodyShape
@onready var visual: Node3D = $Visual
@onready var body_mesh: MeshInstance3D = $Visual/Body
@onready var facing_marker: MeshInstance3D = $Visual/Facing
@onready var eye: Marker3D = $Eye

var _move := Vector3.ZERO
var _sprint := false
var _jump_requested := false
var _jump_buffer: float = 0.0
var _coyote: float = 0.0


func _ready() -> void:
	if profile == null:
		profile = EAPlayerProfile.new()
	apply_profile()


func apply_profile() -> void:
	var body_height := maxf(profile.height, profile.radius * 2.0)
	var capsule := CapsuleShape3D.new()
	capsule.radius = profile.radius
	capsule.height = body_height
	body_shape.shape = capsule
	body_shape.position.y = body_height * 0.5
	var mesh := CapsuleMesh.new()
	mesh.radius = profile.radius
	mesh.height = body_height
	body_mesh.mesh = mesh
	body_mesh.position.y = body_height * 0.5
	facing_marker.position = Vector3(0.0, body_height * 0.78, -profile.radius)
	eye.position.y = clampf(profile.eye_height, profile.radius, body_height)
	floor_max_angle = deg_to_rad(profile.max_slope_degrees)
	floor_snap_length = profile.floor_snap


func set_motion(world_direction: Vector3, sprint: bool, jump: bool) -> void:
	_move = Vector3(world_direction.x, 0.0, world_direction.z).limit_length()
	_sprint = sprint
	_jump_requested = _jump_requested or jump


func clear_motion() -> void:
	_move = Vector3.ZERO
	_sprint = false
	_jump_requested = false
	_jump_buffer = 0.0


func teleport_to(destination: Transform3D) -> void:
	global_transform = destination
	velocity = Vector3.ZERO
	_coyote = 0.0
	clear_motion()
	reset_physics_interpolation()


func _physics_process(delta: float) -> void:
	_coyote = profile.coyote_time if is_on_floor() else maxf(0.0, _coyote - delta)
	_jump_buffer = maxf(0.0, _jump_buffer - delta)
	if _jump_requested:
		_jump_buffer = profile.jump_buffer_time
	var wants_jump := _jump_requested or _jump_buffer > 0.0
	_jump_requested = false
	if not is_on_floor():
		velocity.y -= profile.gravity * delta
	if wants_jump and (is_on_floor() or _coyote > 0.0):
		velocity.y = sqrt(2.0 * profile.gravity * profile.jump_height)
		_jump_buffer = 0.0
		_coyote = 0.0
	var speed := profile.sprint_speed if _sprint else profile.walk_speed
	var rate := profile.acceleration if is_on_floor() else profile.air_acceleration
	var horizontal := Vector2(velocity.x, velocity.z).move_toward(
		Vector2(_move.x, _move.z) * speed, rate * delta)
	velocity.x = horizontal.x
	velocity.z = horizontal.y
	move_and_slide()
	if _move.length_squared() > 0.01:
		var heading := atan2(-_move.x, -_move.z) - global_rotation.y
		visual.rotation.y = lerp_angle(visual.rotation.y, heading, 1.0 - exp(-14.0 * delta))
