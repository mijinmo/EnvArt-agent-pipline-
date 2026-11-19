@tool
class_name EARailCamera
extends Node3D
## Native, editor-authored rail. AnimationPlayer owns progress and lens tracks.
## Camera activation is explicit; this component never reads player input.

enum AimMode { PATH_DIRECTION, LOOK_AT_TARGET }
signal playback_finished

@export var animation_name: StringName = &"inspection"
@export var aim_mode: AimMode = AimMode.LOOK_AT_TARGET
@export var aim_target: Node3D

@onready var path: Path3D = $Path3D
@onready var follower: PathFollow3D = $Path3D/PathFollow3D
@onready var aim: Node3D = $Path3D/PathFollow3D/Aim
@onready var camera: Camera3D = $Path3D/PathFollow3D/Aim/Camera3D
@onready var animation: AnimationPlayer = $AnimationPlayer

var active: bool = false


func _ready() -> void:
	# Aim after AnimationPlayer has sampled the current frame, including editor scrubs.
	process_priority = 100
	path.curve_changed.connect(_on_curve_changed)
	if not Engine.is_editor_hint():
		animation.animation_finished.connect(_on_finished)
		if is_usable():
			seek_seconds(0.0)
	update_aim()


func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray()
	var rail_path := get_node_or_null("Path3D") as Path3D
	if rail_path == null or rail_path.curve == null or rail_path.curve.point_count < 2 or rail_path.curve.get_baked_length() < 0.001:
		warnings.append("Create a Curve3D with at least two distinct points before playing the rail.")
	var player := get_node_or_null("AnimationPlayer") as AnimationPlayer
	if player == null or not player.has_animation(animation_name):
		warnings.append("AnimationPlayer must contain the animation named by Animation Name.")
	if aim_mode == AimMode.LOOK_AT_TARGET and not is_instance_valid(aim_target):
		warnings.append("Assign Aim Target or choose Path Direction. Missing targets fall back to path direction.")
	return warnings


func is_usable() -> bool:
	return is_node_ready() and path.curve != null and path.curve.point_count >= 2 and path.curve.get_baked_length() > 0.001 and animation.has_animation(animation_name)


func activate() -> bool:
	if not is_usable():
		return false
	active = true
	update_aim()
	camera.make_current()
	return true


func deactivate() -> void:
	pause()
	active = false
	# The caller selects the replacement camera; clear_current would pick arbitrarily.


func duration() -> float:
	return animation.get_animation(animation_name).length if animation.has_animation(animation_name) else 0.0


func playhead() -> float:
	return animation.current_animation_position if animation.assigned_animation == animation_name else 0.0


func is_playing() -> bool:
	return animation.is_playing()


func play() -> void:
	if not active or not is_usable():
		return
	if playhead() >= duration() - 0.0001:
		seek_seconds(0.0)
	animation.play(animation_name)
	animation.advance(0.0)


func pause() -> void:
	animation.pause()


func toggle_playback() -> void:
	if is_playing():
		pause()
	else:
		play()


func rewind() -> void:
	pause()
	seek_seconds(0.0)


func seek_seconds(seconds: float) -> void:
	if not is_usable():
		return
	var was_playing := animation.is_playing()
	if animation.assigned_animation != animation_name:
		animation.assigned_animation = animation_name
	animation.seek(clampf(seconds, 0.0, duration()), true, true)
	if not was_playing:
		animation.pause()
	update_aim()


func scrub(seconds: float) -> void:
	pause()
	seek_seconds(seconds)


func set_looping(enabled: bool) -> void:
	if animation.has_animation(animation_name):
		animation.get_animation(animation_name).loop_mode = Animation.LOOP_LINEAR if enabled else Animation.LOOP_NONE


func is_looping() -> bool:
	return animation.has_animation(animation_name) and animation.get_animation(animation_name).loop_mode != Animation.LOOP_NONE


func update_aim() -> void:
	if not is_node_ready() or path.curve == null or path.curve.get_baked_length() < 0.001:
		return
	var use_target := aim_mode == AimMode.LOOK_AT_TARGET and is_instance_valid(aim_target)
	var rotation_mode := PathFollow3D.ROTATION_NONE if use_target else PathFollow3D.ROTATION_XY
	if follower.rotation_mode != rotation_mode:
		follower.rotation_mode = rotation_mode
	if use_target:
		var direction := aim_target.global_position - aim.global_position
		if direction.length_squared() > 0.000001:
			var up := Vector3.UP
			if absf(direction.normalized().dot(up)) > 0.999:
				up = Vector3.FORWARD
			aim.look_at(aim_target.global_position, up)
	else:
		aim.rotation = Vector3.ZERO


func _process(_delta: float) -> void:
	if not Engine.is_editor_hint() and active and not is_usable():
		pause()
	update_aim()


func _on_curve_changed() -> void:
	update_configuration_warnings()


func _on_finished(name: StringName) -> void:
	if name == animation_name:
		update_aim()
		playback_finished.emit()
