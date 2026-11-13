extends SceneTree
func _initialize():call_deferred("go")
func go():
 var s=load("res://study.tscn").instantiate();root.add_child(s)
 var folder="res://captures/preflight"
 var args=OS.get_cmdline_user_args()
 if args.size()>0:folder="res://captures/"+args[0]
 DirAccess.make_dir_recursive_absolute(folder)
 for pair in [["Overall","overall"],["Detail","detail"],["Transition","transition"]]:
  s.get_node(pair[0]).make_current()
  for i in 12:await process_frame
  RenderingServer.force_draw()
  root.get_texture().get_image().save_png(folder+"/"+pair[1]+".png")
  print("CAPTURE ",folder+"/"+pair[1]+".png")
 quit()
