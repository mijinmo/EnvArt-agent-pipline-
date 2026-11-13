extends Node3D
var views=["Overall","Entrance","Activity","Transition"]
func _ready():
	if "--capture" in OS.get_cmdline_user_args():
		await get_tree().create_timer(2.0).timeout
		for v in views:
			get_node(v).make_current()
			await get_tree().create_timer(0.5).timeout
			RenderingServer.force_draw()
			get_viewport().get_texture().get_image().save_png("res://captures/"+v.to_lower()+".png")
		get_tree().quit()
func _unhandled_key_input(event):
	if event.pressed and event.keycode>=KEY_1 and event.keycode<=KEY_4:
		get_node(views[event.keycode-KEY_1]).make_current()
