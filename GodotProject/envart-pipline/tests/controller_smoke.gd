extends SceneTree
## Integration checks against the actual Jolt world, not a mocked controller.
## Run: Godot --headless --path <project> --script res://tests/controller_smoke.gd

var failures: Array[String] = []
var lab: Node3D
var player: EAPlayerMotor
var cameras: EACameraRig


func _initialize() -> void:
	call_deferred("run_checks")


func check(condition: bool, message: String) -> void:
	if condition:
		print("PASS: ", message)
	else:
		failures.append(message)
		push_error("FAIL: " + message)


func step(frames: int) -> void:
	for _i in frames:
		await physics_frame
		await process_frame


func place(at: Vector3) -> void:
	player.teleport_to(Transform3D(Basis.IDENTITY, at))
	await step(15)


func run_checks() -> void:
	lab = load("res://demo/controller_lab.tscn").instantiate()
	root.add_child(lab)
	player = lab.get_node("Player")
	cameras = lab.get_node("CameraRig")
	lab.get_node("PlayerInput").set_physics_process(false)
	await step(30)
	check(player.is_on_floor(), "Spawn settles on the test floor")
	check(is_equal_approx(player.body_shape.shape.height, 1.8), "Profile sets capsule height")
	check(is_equal_approx(player.eye.position.y, 1.65), "Profile sets eye height")

	await place(Vector3(-12, 0.05, 10))
	player.set_motion(Vector3.FORWARD, false, false)
	await step(60)
	check(player.position.z < 6.5, "Walk moves forward through physics")
	check(absf(Vector2(player.velocity.x, player.velocity.z).length() - 4.5) < 0.05, "Walk reaches configured speed")
	player.set_motion(Vector3(1, 0, -1), false, false)
	await step(30)
	check(absf(Vector2(player.velocity.x, player.velocity.z).length() - 4.5) < 0.05, "Diagonal movement is normalized")

	await place(Vector3(-12, 0.05, 10))
	player.set_motion(Vector3.FORWARD, true, false)
	await step(30)
	check(absf(-player.velocity.z - 7.5) < 0.05, "Sprint reaches configured speed")

	await place(Vector3(-12, 0.05, 10))
	var floor_y := player.position.y
	var highest := floor_y
	player.set_motion(Vector3.ZERO, false, true)
	for _i in 65:
		await step(1)
		highest = maxf(highest, player.position.y)
	check(highest - floor_y > 1.05 and highest - floor_y < 1.35, "Jump height matches 1.2 m profile")
	check(player.is_on_floor(), "Jump lands on floor")

	await place(Vector3(0, 0.05, -8))
	player.set_motion(Vector3.FORWARD, true, false)
	await step(60)
	check(player.position.z > -11.5 and player.position.z < -11.3, "Wall blocks player without tunnelling")

	await place(Vector3(0, 0.05, -2.5))
	player.set_motion(Vector3.FORWARD, false, false)
	await step(45)
	check(player.position.z < -5.0, "Player fits through the 1.2 m doorway")

	await place(Vector3(-6, 0.05, 1.5))
	player.set_motion(Vector3.FORWARD, false, false)
	await step(120)
	check(player.position.y > 1.9 and player.position.z < -6.0, "Player climbs the full 18.4 degree ramp onto the landing")

	await place(Vector3(0, 0.05, 8))
	cameras.set_mode(EACameraRig.Mode.FIRST_PERSON)
	await step(3)
	check(cameras.first_camera.is_current() and not player.visual.visible, "First person owns camera and hides proxy")
	check(cameras.first_camera.global_position.distance_to(player.eye.global_position) < 0.001, "First person uses actual eye marker")
	cameras.look(Vector2(100000, 100000))
	check(absf(cameras.pitch) <= deg_to_rad(80), "Mouse pitch clamps before flipping")
	cameras.reset_view(0.0)
	cameras.set_mode(EACameraRig.Mode.THIRD_PERSON)
	await step(3)
	check(cameras.third_camera.is_current() and player.visual.visible, "Third person owns camera and shows proxy")

	var original_pose := cameras.active_camera().global_transform
	var original_player := player.global_position
	cameras.toggle_free_view()
	check(cameras.free_camera.global_transform.is_equal_approx(original_pose), "Free observer begins at current camera pose")
	cameras.set_free_motion(Vector3(0, 1, -1), false)
	await step(30)
	check(cameras.free_camera.global_position.distance_to(original_pose.origin) > 2.0, "Free observer moves independently")
	check(player.global_position.distance_to(original_player) < 0.01, "Free observer does not move grounded player")
	cameras.toggle_free_view()
	check(cameras.mode == EACameraRig.Mode.THIRD_PERSON and cameras.third_camera.is_current(), "Observer returns to previous perspective")
	cameras.set_mode(EACameraRig.Mode.FIRST_PERSON)
	cameras.toggle_free_view()
	cameras.toggle_free_view()
	check(cameras.mode == EACameraRig.Mode.FIRST_PERSON, "Observer remembers first person too")

	# Put a wall directly behind a stationary player; arm must retract and recover.
	await place(Vector3(0, 0.05, -10.5))
	cameras.set_mode(EACameraRig.Mode.THIRD_PERSON)
	cameras.yaw = PI
	cameras.pitch = 0.0
	await step(10)
	check(cameras.arm.get_hit_length() < 1.5, "Third person camera retracts before back wall")
	cameras.yaw = 0.0
	await step(10)
	check(absf(cameras.arm.get_hit_length() - cameras.third_person_distance) < 0.1, "Camera arm restores distance when clear")

	cameras.set_mode(EACameraRig.Mode.FREE_LOOK)
	player.position.y = -20.0
	await step(5)
	check(player.position.distance_to(lab.get_node("Spawn").position) < 0.2, "Fall recovery respawns player")
	check(cameras.mode == EACameraRig.Mode.THIRD_PERSON, "Respawn exits free observer")
	for action: String in ["ea_forward", "ea_back", "ea_left", "ea_right", "ea_jump", "ea_sprint", "ea_first_person", "ea_third_person", "ea_free_look", "ea_toggle_view", "ea_up", "ea_down", "ea_reset", "ea_release_mouse", "ea_zoom_in", "ea_zoom_out"]:
		check(InputMap.has_action(action) and not InputMap.action_get_events(action).is_empty(), "Input binding exists: " + action)
	print("RESULT: ", "PASS" if failures.is_empty() else "FAIL", " (", failures.size(), " failures)")
	lab.queue_free()
	await process_frame
	quit(0 if failures.is_empty() else 1)
