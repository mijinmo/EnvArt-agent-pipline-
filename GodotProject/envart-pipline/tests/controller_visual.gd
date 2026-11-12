extends SceneTree
## Render all modes and exercise the input adapter using engine input events.
## Requires the graphical renderer. Images go to /tmp/envart-controller-preview.

const OUTPUT := "/tmp/envart-controller-preview"
var lab: Node3D
var failures: int = 0


func _initialize() -> void:
	call_deferred("run_checks")


func check(condition: bool, message: String) -> void:
	if not condition:
		failures += 1
		push_error(message)
	else:
		print("PASS: ", message)


func frames(count: int) -> void:
	for _i in count:
		await process_frame


func key(code: Key) -> void:
	var event := InputEventKey.new()
	event.physical_keycode = code
	event.pressed = true
	Input.parse_input_event(event)
	await frames(2)
	event = InputEventKey.new()
	event.physical_keycode = code
	event.pressed = false
	Input.parse_input_event(event)
	await frames(2)


func capture(file_name: String) -> void:
	await frames(12)
	await RenderingServer.frame_post_draw
	var result := root.get_texture().get_image().save_png(OUTPUT.path_join(file_name + ".png"))
	check(result == OK, "Rendered " + file_name)


func click_control(control: Control) -> void:
	var location := control.get_global_rect().get_center()
	var motion := InputEventMouseMotion.new()
	motion.position = location
	motion.global_position = location
	Input.parse_input_event(motion)
	await frames(2)
	for pressed: bool in [true, false]:
		var event := InputEventMouseButton.new()
		event.button_index = MOUSE_BUTTON_LEFT
		event.position = location
		event.global_position = location
		event.pressed = pressed
		Input.parse_input_event(event)
		await frames(2)


func run_checks() -> void:
	DirAccess.make_dir_recursive_absolute(OUTPUT)
	lab = load("res://demo/controller_lab.tscn").instantiate()
	root.add_child(lab)
	await frames(30)
	var rig: EACameraRig = lab.get_node("CameraRig")
	await capture("third_person")
	var click := InputEventMouseButton.new()
	click.button_index = MOUSE_BUTTON_LEFT
	click.pressed = true
	Input.parse_input_event(click)
	await frames(2)
	check(Input.mouse_mode == Input.MOUSE_MODE_CAPTURED, "Click captures pointer through input adapter")
	click = InputEventMouseButton.new()
	click.button_index = MOUSE_BUTTON_LEFT
	Input.parse_input_event(click)
	await key(KEY_1)
	check(rig.mode == EACameraRig.Mode.FIRST_PERSON, "1 key selects first person")
	await capture("first_person")
	await key(KEY_V)
	check(rig.mode == EACameraRig.Mode.THIRD_PERSON, "V key changes perspective")
	await key(KEY_F)
	check(rig.mode == EACameraRig.Mode.FREE_LOOK, "F key enters observer")
	rig.free_camera.global_position = Vector3(12, 11, 15)
	rig.free_camera.look_at(Vector3(0, 0, -2))
	await capture("free_observer")
	await key(KEY_F)
	check(rig.mode == EACameraRig.Mode.THIRD_PERSON, "F key returns from observer")
	await key(KEY_3)
	check(rig.mode == EACameraRig.Mode.FREE_LOOK, "3 key enters observer")
	await key(KEY_2)
	check(rig.mode == EACameraRig.Mode.THIRD_PERSON, "2 key returns to third person")
	await key(KEY_ESCAPE)
	check(Input.mouse_mode == Input.MOUSE_MODE_VISIBLE, "Escape releases pointer")
	await key(KEY_1)
	check(rig.mode == EACameraRig.Mode.THIRD_PERSON, "Released pointer blocks gameplay shortcuts")
	await key(KEY_4)
	check(rig.mode == EACameraRig.Mode.RAIL, "4 selects rail with cursor released")
	var rail: EARailCamera = lab.get_node("RailCamera")
	await capture("rail_start")
	await key(KEY_P)
	check(rail.is_playing(), "P starts native rail timeline")
	await key(KEY_P)
	check(not rail.is_playing(), "P pauses native rail timeline")
	await key(KEY_HOME)
	check(is_zero_approx(rail.playhead()), "Home rewinds")
	await key(KEY_BRACKETRIGHT)
	check(is_equal_approx(rail.playhead(), 1.0), "Right bracket scrubs one second")
	await key(KEY_BRACKETLEFT)
	check(is_zero_approx(rail.playhead()), "Left bracket scrubs back")
	await key(KEY_L)
	check(rail.is_looping(), "L enables looping")
	await key(KEY_L)
	check(not rail.is_looping(), "L disables looping")
	var slider: HSlider = lab.get_node("HUD/RailControls/Margin/Rows/Timeline/Slider")
	slider.value = 9.0
	await frames(2)
	check(is_equal_approx(rail.playhead(), 9.0) and not rail.is_playing(), "UI slider scrubs paused rail")
	await capture("rail_hold")
	var play_button: Button = lab.get_node("HUD/RailControls/Margin/Rows/Buttons/Play")
	await click_control(play_button)
	check(rail.is_playing(), "UI play button resumes rail")
	check(Input.mouse_mode == Input.MOUSE_MODE_VISIBLE, "UI click does not capture gameplay pointer")
	rail.scrub(18.0)
	await capture("rail_endward")
	await key(KEY_4)
	check(rig.mode == EACameraRig.Mode.THIRD_PERSON and not rail.is_playing(), "4 restores previous camera and pauses rail")
	print("VISUAL RESULT: ", "PASS" if failures == 0 else "FAIL")
	lab.queue_free()
	await process_frame
	quit(0 if failures == 0 else 1)
