extends SceneTree
## Render deterministic comparison shots and verify style switches preserve gameplay.
const OUTPUT := "/tmp/envart-studies"
var failures: int = 0
var lab: Node3D
func _initialize() -> void:
	call_deferred("run")
func check(ok: bool, message: String) -> void:
	if not ok:
		failures += 1
		push_error(message)
	else: print("PASS: ",message)
func frames(n: int) -> void:
	for i in n: await process_frame
func snapshot(name: String) -> void:
	await frames(20)
	await RenderingServer.frame_post_draw
	check(root.get_texture().get_image().save_png(OUTPUT.path_join(name+".png")) == OK,"capture "+name)
func run() -> void:
	DirAccess.make_dir_recursive_absolute(OUTPUT)
	lab = load("res://envart/envart_lab.tscn").instantiate()
	root.add_child(lab)
	await frames(20)
	lab.get_node("BaseLab/PlayerInput").set_physics_process(false)
	var world: Node3D = lab.get_node("BaseLab/World")
	var originals: Array[Transform3D] = []
	var shapes: Array[Vector3] = []
	for b in world.get_children():
		if b is StaticBody3D:
			originals.append(b.transform)
			shapes.append(b.get_node("Collision").shape.size)
	var rig: EACameraRig = lab.get_node("BaseLab/CameraRig")
	var rail: EARailCamera = lab.get_node("BaseLab/RailCamera")
	var player: EAPlayerMotor = lab.get_node("BaseLab/Player")
	for code in [KEY_6, KEY_7, KEY_0]:
		var event := InputEventKey.new()
		event.physical_keycode = code
		event.pressed = true
		Input.parse_input_event(event)
		await frames(2)
		event = InputEventKey.new()
		event.physical_keycode = code
		Input.parse_input_event(event)
		await frames(2)
		check(lab.current_style == (2 if code==KEY_6 else (3 if code==KEY_7 else 0)), "style keyboard shortcut %d" % code)
	lab.get_node("HUD").hide()
	lab.get_node("BaseLab/HUD").hide()
	for index in 4:
		lab.get_node("BaseLab").reset_player()
		lab.select_style(index)
		var j := 0
		for b in world.get_children():
			if b is StaticBody3D:
				check(b.transform == originals[j] and b.get_node("Collision").shape.size == shapes[j],"style %d preserves %s" % [index,b.name])
				j += 1
		for node in lab.get_node("Styles").find_children("*","CollisionObject3D",true,false):
			check(false,"Art layer unexpectedly owns collision: "+str(node.get_path()))
		rig.set_mode(EACameraRig.Mode.RAIL)
		rail.scrub(0)
		await snapshot("style%d_rail" % index)
		rail.scrub(9)
		await snapshot("style%d_hold" % index)
		rig.set_mode(EACameraRig.Mode.FREE_LOOK)
		rig.free_camera.global_position = Vector3(15,12,17)
		rig.free_camera.look_at(Vector3(0,1,-3))
		await snapshot("style%d_overview" % index)
		player.teleport_to(Transform3D(Basis.IDENTITY,Vector3(0,0.08,-2)))
		for frame in 60:
			player.set_motion(Vector3.FORWARD,false,false)
			await physics_frame
		check(player.position.z < -5,"style %d door stays passable" % index)
		player.clear_motion()
	lab.get_node("BaseLab").reset_player()
	lab.select_style(1)
	rig.set_mode(EACameraRig.Mode.THIRD_PERSON)
	await snapshot("character_third")
	print("ENVART VISUAL RESULT: ","PASS" if failures==0 else "FAIL")
	lab.queue_free()
	await frames(5)
	Node.print_orphan_nodes()
	quit(0 if failures==0 else 1)
