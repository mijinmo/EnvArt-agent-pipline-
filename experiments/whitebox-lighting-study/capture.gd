extends SceneTree
func _initialize():call_deferred("run")
func run():
 var args=OS.get_cmdline_user_args()
 var mode=args[0] if args.size()>0 else "art_lit"
 var folder=args[1] if args.size()>1 else "art-lit-01"
 root.size=Vector2i(1600,1000)
 var scene=load("res://"+mode+".tscn").instantiate();root.add_child(scene)
 await process_frame
 for cam in scene.get_node("Cameras").get_children():
  if args.size()>2 and cam.name!=args[2]:continue
  cam.make_current()
  for i in range(16):await process_frame
  RenderingServer.force_draw()
  await process_frame
  var path="res://captures/"+folder+"/"+cam.name+".png"
  DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(path.get_base_dir()))
  root.get_texture().get_image().save_png(path)
  print("CAPTURE ",path)
 scene.queue_free()
 await process_frame
 await process_frame
 quit()
