extends SceneTree
func _initialize() -> void: call_deferred("capture")
func capture() -> void:
	var args := OS.get_cmdline_user_args()
	if args.size() < 2:
		quit(2)
		return
	var output := args[1]
	if DirAccess.dir_exists_absolute(output):
		push_error("Evidence folder already exists: " + output)
		quit(2)
		return
	DirAccess.make_dir_recursive_absolute(output)
	root.size = Vector2i(1280,720)
	var scene = load("res://" + args[0]).instantiate()
	root.add_child(scene)
	await process_frame
	scene.set_process(false)
	scene.set_physics_process(false)
	var camera := Camera3D.new()
	root.add_child(camera)
	camera.make_current()
	var views = JSON.parse_string(FileAccess.get_file_as_string("res://views.json"))
	if args.size() > 2 and args[2] == "audition":
		views = [{"name":"audition","position":[0,4,17],"target":[0,2,0],"fov":40}]
	for view in views:
		camera.position = Vector3(view.position[0],view.position[1],view.position[2])
		camera.look_at(Vector3(view.target[0],view.target[1],view.target[2]))
		camera.fov = view.fov
		for i in range(35): await process_frame
		RenderingServer.force_draw()
		assert(root.get_texture().get_image().save_png(output.path_join(view.name+".png")) == OK)
		print("CAPTURE ", view.name)
	quit()
