extends SceneTree
func _initialize() -> void:
 call_deferred("capture")
func collect(n: Node, result: Dictionary) -> void:
 if n is StaticBody3D:
  var item = {"transform": str(n.transform), "layer": n.collision_layer, "mask": n.collision_mask, "children": []}
  for ch in n.get_children():
   if ch is CollisionShape3D:
    item.children.append({"name": str(ch.name), "transform": str(ch.transform), "shape": ch.shape.get_class() if ch.shape else "null", "size": str(ch.shape.size) if ch.shape is BoxShape3D else ""})
   elif ch is MeshInstance3D:
    item.children.append({"name": str(ch.name), "transform": str(ch.transform), "mesh": ch.mesh.get_class() if ch.mesh else "null", "size": str(ch.mesh.size) if ch.mesh is BoxMesh else ""})
  result.bodies[str(root.get_child(root.get_child_count()-1).get_path_to(n))] = item
 for ch in n.get_children(): collect(ch,result)
func capture() -> void:
 var args=OS.get_cmdline_user_args()
 var pass_name=args[0] if args.size()>0 else "start"
 var label=args[1] if args.size()>1 else pass_name
 var packed=load("res://"+pass_name+".tscn") as PackedScene
 if packed == null:
  quit(1)
  return
 var scene=packed.instantiate()
 root.add_child(scene)
 root.content_scale_mode=Window.CONTENT_SCALE_MODE_DISABLED
 root.size=Vector2i(1600,1000)
 var output="res://evidence/"+label+"_"
 var result={"bodies":{},"cameras":{}}
 collect(scene,result)
 var paths=["Overall", "Detail", "Transition"]
 var names=["overall","detail","transition"]
 for i in range(paths.size()):
  var cam=scene.get_node(paths[i]) as Camera3D
  result.cameras[paths[i]]={"transform":str(cam.global_transform),"fov":cam.fov,"projection":cam.projection,"size":cam.size}
  cam.make_current()
  for frame in range(16):
   await process_frame
   await RenderingServer.frame_post_draw
  var im=root.get_texture().get_image()
  var target=output+names[i]+".png"
  if im.save_png(target)!=OK:
   quit(1)
   return
  print("CAPTURE ",target," ",im.get_size())
 var f=FileAccess.open(output+"constraints.json",FileAccess.WRITE)
 f.store_string(JSON.stringify(result,"  ")+"\n")
 quit()
