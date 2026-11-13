extends SceneTree
func _initialize():call_deferred("run")
func run():
 var scene=load("res://sunlit_ruins.tscn").instantiate();root.add_child(scene)
 var round_name="round-01"
 for arg in OS.get_cmdline_user_args():
  if arg.begins_with("round-"):round_name=arg
 var folder="res://captures/"+round_name
 DirAccess.make_dir_recursive_absolute(folder)
 for item in [["Overall","overall"],["Detail","detail"],["Transition","transition"]]:
  scene.get_node(item[0]).make_current()
  for i in range(12):await process_frame
  RenderingServer.force_draw()
  root.get_texture().get_image().save_png(folder+"/"+item[1]+".png")
  print("CAPTURE ",folder,"/",item[1],".png")
 scene.queue_free()
 for i in range(4):await process_frame
 quit()
