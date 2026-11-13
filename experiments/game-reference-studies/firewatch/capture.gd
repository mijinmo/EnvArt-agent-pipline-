extends Node3D
func _ready():
 var args=OS.get_cmdline_user_args()
 if not "--capture" in args:return
 var out="res://captures/round-02"
 for a in args:
  if a.begins_with("--out="):out=a.trim_prefix("--out=")
 DirAccess.make_dir_recursive_absolute(out)
 for view in ["overall","detail","transition"]:
  get_node(view).make_current()
  await get_tree().create_timer(1.5).timeout
  RenderingServer.force_draw()
  await RenderingServer.frame_post_draw
  get_viewport().get_texture().get_image().save_png(out+"/"+view+".png")
  print("CAPTURE ",out+"/"+view+".png")
 get_tree().quit()
