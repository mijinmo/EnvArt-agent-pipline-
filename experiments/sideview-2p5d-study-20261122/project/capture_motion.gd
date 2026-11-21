extends SceneTree
func _initialize() -> void: call_deferred("run")
func run() -> void:
	var args:=OS.get_cmdline_user_args()
	if args.size()!=1 or DirAccess.dir_exists_absolute(args[0]):
		push_error("Supply a fresh evidence directory")
		quit(2)
		return
	var output:=args[0]
	DirAccess.make_dir_recursive_absolute(output)
	root.size=Vector2i(1280,720)
	var scene=load("res://waystation.tscn").instantiate()
	root.add_child(scene)
	scene.set_physics_process(false)
	var player=scene.get_node("Player")
	var camera:Camera3D=scene.get_node("SideCamera")
	for i in range(35): await process_frame
	player.teleport_to(Transform3D(Basis.IDENTITY,Vector3(-7,0.08,3.05)))
	camera.position.x=-7
	var evidence:Array=[]
	for i in range(211):
		player.set_motion(Vector3.RIGHT,false,false)
		await physics_frame
		if i in [0,105,210]:
			RenderingServer.force_draw()
			var name: String="left" if i==0 else ("middle" if i==105 else "right")
			assert(root.get_texture().get_image().save_png(output.path_join(name+".png"))==OK)
			evidence.append({"frame":i,"name":name,"player_x":player.position.x,"camera_x":camera.position.x,"height":player.position.y})
	var ok:bool=player.position.x>4 and absf(player.position.y)<0.12 and camera.position.x>3
	var f:=FileAccess.open(output.path_join("motion.json"),FileAccess.WRITE)
	f.store_string(JSON.stringify({"passed":ok,"evidence":evidence},"  ")+"\n")
	print("MOTION ",JSON.stringify({"passed":ok,"evidence":evidence}))
	scene.free()
	quit(0 if ok else 2)
