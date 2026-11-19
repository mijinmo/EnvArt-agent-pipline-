extends SceneTree

func _initialize() -> void:
	call_deferred("capture")

func capture() -> void:
	var args := OS.get_cmdline_user_args()
	if args.is_empty():
		push_error("Pass an output directory after --")
		quit(1)
		return
	var output := ProjectSettings.globalize_path(args[0]) if args[0].begins_with("res://") else args[0]
	var directory_error := DirAccess.make_dir_recursive_absolute(output)
	if directory_error != OK:
		push_error("Cannot create capture directory: " + output)
		quit(1)
		return
	var scene_path := "res://round03.tscn"
	if "--first" in args:
		scene_path = "res://passes/first/harbor.tscn"
	elif "--round02" in args:
		scene_path = "res://harbor.tscn"
	var packed := load(scene_path) as PackedScene
	if packed == null:
		quit(1)
		return
	var scene := packed.instantiate()
	root.add_child(scene)
	root.content_scale_mode = Window.CONTENT_SCALE_MODE_DISABLED
	root.size = Vector2i(1600,1000)
	for camera_name in ["Overall","Detail","Transition"]:
		scene.get_node(camera_name).current = true
		for i in 5:
			await process_frame
			await RenderingServer.frame_post_draw
		var image := root.get_texture().get_image()
		var target := output.path_join(camera_name.to_lower() + ".png")
		if image.save_png(target) != OK:
			push_error("Cannot save " + target)
			quit(1)
			return
		print(target, " ",image.get_size())
	quit()
