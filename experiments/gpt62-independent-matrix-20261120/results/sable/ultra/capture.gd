extends SceneTree
# Capture a saved scene; never builds or edits the art.
func _initialize() -> void:
	call_deferred("capture")
func capture() -> void:
	var args = OS.get_cmdline_user_args()
	if args.size() != 2:
		push_error("Usage: --script res://capture.gd -- scene.tscn output-directory")
		quit(2)
		return
	var scene_path = args[0] if args[0].begins_with("res://") else "res://" + args[0]
	var output = args[1]
	if DirAccess.dir_exists_absolute(output):
		push_error("Refusing to overwrite an existing evidence directory: " + output)
		quit(2)
		return
	DirAccess.make_dir_recursive_absolute(output)
	var packed = load(scene_path) as PackedScene
	if packed == null:
		quit(2)
		return
	var scene = packed.instantiate()
	root.add_child(scene)
	root.size = Vector2i(1280, 800)
	await process_frame
	var lab = scene.get_node("BaseLab")
	lab.get_node("HUD").hide()
	lab.get_node("Player/Visual").hide()
	var camera = Camera3D.new()
	root.add_child(camera)
	camera.make_current()
	var views = JSON.parse_string(FileAccess.get_file_as_string("res://views.json"))
	for view in views:
		camera.position = Vector3(view.position[0], view.position[1], view.position[2])
		camera.look_at(Vector3(view.target[0], view.target[1], view.target[2]))
		camera.fov = view.fov
		for i in range(24): await process_frame
		RenderingServer.force_draw()
		var result = root.get_texture().get_image().save_png(output.path_join(view.name + ".png"))
		if result != OK:
			push_error("Capture write failed")
			quit(2)
			return
		print("CAPTURE ", view.name)
	quit()
