extends SceneTree
## Rail transport, authored animation, transform safety and mode ownership checks.

var failures: int = 0


func _initialize() -> void:
	call_deferred("run_checks")


func check(condition: bool, message: String) -> void:
	if condition:
		print("PASS: ", message)
	else:
		failures += 1
		push_error("FAIL: " + message)


func frames(count: int) -> void:
	for _i in count:
		await physics_frame
		await process_frame


func run_checks() -> void:
	var lab: Node3D = load("res://demo/controller_lab.tscn").instantiate()
	root.add_child(lab)
	await frames(10)
	var director: EACameraRig = lab.get_node("CameraRig")
	var rail: EARailCamera = lab.get_node("RailCamera")
	var player: EAPlayerMotor = lab.get_node("Player")
	check(rail.is_usable(), "Authored rail is usable")
	check(not rail.active and not rail.is_playing(), "Rail does not steal camera or autoplay at startup")
	check(director.set_mode(EACameraRig.Mode.RAIL), "Director can select rail")
	check(rail.camera.is_current() and rail.active, "Rail owns the active camera")
	director.set_mode(EACameraRig.Mode.FIRST_PERSON)
	director.set_mode(EACameraRig.Mode.RAIL)
	director.toggle_person_view()
	check(director.mode == EACameraRig.Mode.THIRD_PERSON, "V from rail toggles relative to previous player view")
	director.set_mode(EACameraRig.Mode.RAIL)
	check(not rail.is_playing(), "Entering inspection is paused")
	var before := rail.camera.global_position
	rail.play()
	await frames(15)
	check(rail.playhead() > 0.1 and rail.camera.global_position.distance_to(before) > 0.1, "AnimationPlayer advances camera along path")
	rail.pause()
	var paused := rail.playhead()
	await frames(5)
	check(is_equal_approx(paused, rail.playhead()), "Pause preserves time")
	rail.play()
	await frames(5)
	check(rail.playhead() > paused, "Play resumes paused time")
	rail.scrub(8.0)
	check(not rail.is_playing() and is_equal_approx(rail.follower.progress_ratio, 0.35), "Scrub samples authored path progress")
	check(is_equal_approx(rail.camera.fov, 60.0), "Scrub samples FOV track")
	var stop_pose := rail.camera.global_transform
	rail.scrub(9.0)
	check(stop_pose.is_equal_approx(rail.camera.global_transform), "Equal progress keys hold the shot between 8 and 10 seconds")
	rail.scrub(24.0)
	check(is_equal_approx(rail.follower.progress_ratio, 1.0), "Endpoint stays at path end rather than wrapping to start")
	rail.play()
	check(rail.playhead() < 0.1, "Play at end restarts inspection")
	rail.rewind()
	check(not rail.is_playing() and is_zero_approx(rail.playhead()), "Rewind stops at start")

	# Move/rotate entire rig: path and aim target remain in the correct space.
	rail.position = Vector3(2,3,1)
	rail.rotation.y = 0.7
	rail.scrub(14.0)
	var expected := rail.path.to_global(rail.path.curve.sample_baked(rail.follower.progress, true))
	check(rail.camera.global_position.distance_to(expected) < 0.001, "Translated and rotated rail samples in world space")
	var to_target := rail.camera.global_position.direction_to(rail.aim_target.global_position)
	check((-rail.camera.global_basis.z).dot(to_target) > 0.999, "Look At aims at target after rig transform")
	rail.aim_mode = EARailCamera.AimMode.PATH_DIRECTION
	rail.update_aim()
	check(rail.follower.rotation_mode == PathFollow3D.ROTATION_XY and rail.aim.rotation.is_zero_approx(), "Path Direction delegates orientation to native follower")
	rail.aim_mode = EARailCamera.AimMode.LOOK_AT_TARGET
	var target := rail.aim_target
	rail.aim_target = null
	rail.update_aim()
	check(rail.follower.rotation_mode == PathFollow3D.ROTATION_XY, "Missing target falls back to path direction")
	rail.aim_target = target
	var old_target_position := target.global_position
	target.global_position = rail.aim.global_position
	rail.update_aim()
	check(rail.camera.global_basis.is_finite(), "Coincident aim target does not produce invalid rotation")
	target.global_position = rail.aim.global_position + Vector3.UP * 3
	rail.update_aim()
	check(rail.camera.global_basis.is_finite(), "Vertical aim target has a valid fallback up vector")
	target.global_position = old_target_position
	rail.position = Vector3.ZERO
	rail.rotation = Vector3.ZERO

	# Leaving every mode preserves the relevant transport and spectator state.
	for mode in [EACameraRig.Mode.FIRST_PERSON, EACameraRig.Mode.THIRD_PERSON, EACameraRig.Mode.FREE_LOOK]:
		director.set_mode(mode)
		var free_pose := director.free_camera.global_transform
		director.toggle_rail_view()
		rail.play()
		await frames(2)
		var return_time := rail.playhead()
		director.toggle_rail_view()
		check(director.mode == mode and director.active_camera().is_current(), "Rail toggle restores mode " + str(mode))
		check(not rail.is_playing(), "Leaving rail pauses playback")
		await frames(2)
		check(is_equal_approx(return_time, rail.playhead()), "Inactive rail holds time")
		if mode == EACameraRig.Mode.FREE_LOOK:
			check(director.free_camera.global_transform.is_equal_approx(free_pose), "Returning to previous free view preserves its pose")
	director.set_mode(EACameraRig.Mode.RAIL)
	rail.scrub(12.0)
	var rail_pose := rail.camera.global_transform
	director.toggle_free_view()
	check(director.free_camera.global_transform.is_equal_approx(rail_pose), "F detaches observer from current rail shot")
	check(is_equal_approx(director.free_camera.fov, rail.camera.fov), "Observer preserves rail framing")
	director.set_mode(EACameraRig.Mode.RAIL)
	var player_position := player.position
	Input.action_press("ea_forward")
	await frames(5)
	Input.action_release("ea_forward")
	check(player.position.distance_to(player_position) < 0.01, "Rail mode does not steer player")

	# Natural completion and looping use the native AnimationPlayer timeline.
	rail.set_looping(false)
	var completed := [false]
	rail.playback_finished.connect(func(): completed[0] = true)
	rail.scrub(23.95)
	rail.play()
	await frames(10)
	check(completed[0] and not rail.is_playing(), "Natural completion emits signal and holds last shot")
	rail.set_looping(true)
	rail.scrub(23.95)
	rail.play()
	await frames(10)
	check(rail.is_playing() and rail.playhead() < 1.0, "Loop mode wraps animation time")
	rail.pause()
	var other: EARailCamera = load("res://controllers/rail_camera.tscn").instantiate()
	lab.add_child(other)
	check(not other.is_looping(), "Loop configuration is local to each scene instance")
	var original_curve := rail.path.curve
	director.set_mode(EACameraRig.Mode.THIRD_PERSON)
	rail.path.curve = Curve3D.new()
	check(not director.set_mode(EACameraRig.Mode.RAIL) and director.third_camera.is_current(), "Empty path cannot steal active camera")
	rail.path.curve = original_curve
	rail.rewind()
	for action: String in ["ea_rail_view", "ea_rail_play", "ea_rail_rewind", "ea_rail_previous", "ea_rail_next", "ea_rail_loop"]:
		check(InputMap.has_action(action), "Input binding exists: " + action)
	print("RAIL RESULT: ", "PASS" if failures == 0 else "FAIL", " (", failures, " failures)")
	lab.queue_free()
	await process_frame
	quit(0 if failures == 0 else 1)
