extends SceneTree

func _initialize() -> void:
	call_deferred("capture")

func capture() -> void:
	var args = OS.get_cmdline_user_args()
	var pass_name = args[0]
	var stage = load("res://" + pass_name + ".tscn").instantiate()
	root.add_child(stage)
	root.size = Vector2i(1600, 1000)
	var out = ProjectSettings.globalize_path("res://captures/" + pass_name)
	DirAccess.make_dir_recursive_absolute(out)
	for camera_name in ["overall", "detail", "transition"]:
		stage.get_node(camera_name).make_current()
		for i in range(6):
			await process_frame
		RenderingServer.force_draw()
		var result = root.get_texture().get_image().save_png(out + "/" + camera_name + ".png")
		assert(result == OK)
	quit()
