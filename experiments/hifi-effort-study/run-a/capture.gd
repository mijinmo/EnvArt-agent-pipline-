extends SceneTree
func _initialize():
    call_deferred("shoot")
func shoot():
    var args = OS.get_cmdline_user_args()
    var scene = load("res://scenes/" + args[0] + ".tscn").instantiate()
    root.add_child(scene)
    root.content_scale_size = Vector2i(1600,1000)
    for view in ["overall","detail","transition"]:
        scene.get_node("Views/"+view).make_current()
        for i in 8:
            await process_frame
            RenderingServer.force_draw()
        var im = root.get_texture().get_image()
        var path = "res://evidence/" + args[0] + "_" + view + ".png"
        im.save_png(ProjectSettings.globalize_path(path))
    quit()
