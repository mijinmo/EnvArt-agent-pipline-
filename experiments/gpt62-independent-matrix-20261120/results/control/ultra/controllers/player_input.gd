class_name EAPlayerInput
extends Node
## Desktop input adapter; replace this node for replay, AI, or another input scheme.

signal reset_requested

@export var player: EAPlayerMotor
@export var cameras: EACameraRig
@export var capture_on_start: bool = false


func _ready() -> void:
	assert(player != null and cameras != null, "Input adapter needs player and camera references.")
	process_physics_priority = -10
	if capture_on_start:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _exit_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _notification(what: int) -> void:
	if what == NOTIFICATION_APPLICATION_FOCUS_OUT and is_node_ready():
		_release_pointer()
		if cameras.mode == EACameraRig.Mode.RAIL:
			cameras.rail_camera.pause()


func _release_pointer() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	player.clear_motion()
	cameras.set_free_motion(Vector3.ZERO, false)


func _unhandled_input(event: InputEvent) -> void:
	if _handle_rail_action(event):
		get_viewport().set_input_as_handled()
		return
	if event.is_action_pressed("ea_release_mouse"):
		_release_pointer()
		get_viewport().set_input_as_handled()
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		get_viewport().set_input_as_handled()
		return
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		return
	if event is InputEventMouseMotion:
		cameras.look(event.screen_relative)
	elif event.is_action_pressed("ea_first_person"):
		cameras.set_mode(EACameraRig.Mode.FIRST_PERSON)
	elif event.is_action_pressed("ea_third_person"):
		cameras.set_mode(EACameraRig.Mode.THIRD_PERSON)
	elif event.is_action_pressed("ea_free_look"):
		cameras.toggle_free_view()
	elif event.is_action_pressed("ea_toggle_view"):
		cameras.toggle_person_view()
	elif event.is_action_pressed("ea_reset"):
		reset_requested.emit()
	elif event.is_action_pressed("ea_zoom_in"):
		cameras.adjust_distance_or_speed(1.0)
	elif event.is_action_pressed("ea_zoom_out"):
		cameras.adjust_distance_or_speed(-1.0)
	elif event.is_action_pressed("ea_jump") and cameras.mode in [EACameraRig.Mode.FIRST_PERSON, EACameraRig.Mode.THIRD_PERSON]:
		player.set_motion(cameras.movement_direction(_move_axis()), Input.is_action_pressed("ea_sprint"), true)
	else:
		return
	get_viewport().set_input_as_handled()


func _move_axis() -> Vector2:
	return Input.get_vector("ea_left", "ea_right", "ea_forward", "ea_back")


func _handle_rail_action(event: InputEvent) -> bool:
	# Inspection shortcuts also work with a released cursor beside the timeline UI.
	if event.is_action_pressed("ea_rail_view"):
		cameras.toggle_rail_view()
		return true
	if cameras.mode != EACameraRig.Mode.RAIL:
		return false
	var rail := cameras.rail_camera
	if event.is_action_pressed("ea_rail_play"):
		rail.toggle_playback()
	elif event.is_action_pressed("ea_rail_rewind"):
		rail.rewind()
	elif event.is_action_pressed("ea_rail_previous"):
		rail.scrub(rail.playhead() - 1.0)
	elif event.is_action_pressed("ea_rail_next"):
		rail.scrub(rail.playhead() + 1.0)
	elif event.is_action_pressed("ea_rail_loop"):
		rail.set_looping(not rail.is_looping())
	else:
		return false
	return true


func _physics_process(_delta: float) -> void:
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED or cameras.mode == EACameraRig.Mode.RAIL:
		player.set_motion(Vector3.ZERO, false, false)
		cameras.set_free_motion(Vector3.ZERO, false)
		return
	var axis := _move_axis()
	var fast := Input.is_action_pressed("ea_sprint")
	if cameras.mode == EACameraRig.Mode.FREE_LOOK:
		player.set_motion(Vector3.ZERO, false, false)
		cameras.set_free_motion(Vector3(axis.x, Input.get_axis("ea_down", "ea_up"), axis.y), fast)
	else:
		player.set_motion(cameras.movement_direction(axis), fast, false)
		cameras.set_free_motion(Vector3.ZERO, false)
