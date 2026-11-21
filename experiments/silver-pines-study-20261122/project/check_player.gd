extends SceneTree
# One scoped runtime check of actual input actions and collision; no art score.
var scene: Node3D
var player: CharacterBody3D
var out: String
var results := {}
func _initialize() -> void: call_deferred("run")
func frames(count: int) -> void:
	for i in range(count): await physics_frame
func shot(label: String) -> void:
	await process_frame
	await RenderingServer.frame_post_draw
	assert(root.get_texture().get_image().save_png(out.path_join(label+".png"))==OK)
func check(label: String, condition: bool, observed: Variant) -> void:
	results[label]={"pass":condition,"observed":observed}
	print(label,": ",condition," ",observed)
func run() -> void:
	var args=OS.get_cmdline_user_args()
	if args.size()!=1 or DirAccess.dir_exists_absolute(args[0]): quit(2); return
	out=args[0]
	DirAccess.make_dir_recursive_absolute(out)
	root.size=Vector2i(1280,720)
	scene=load("res://ferry_office.tscn").instantiate()
	root.add_child(scene)
	player=scene.get_node("Player")
	await frames(45)
	check("lands_on_boardwalk",player.is_on_floor() and absf(player.position.y-0.99)<0.06,player.position.y)
	await shot("idle")
	var start_x=player.position.x
	Input.action_press("right")
	await frames(85)
	check("right_input_moves",player.position.x>start_x+3.0,player.position.x-start_x)
	check("walk_animation",player.get_node("InkSprite").frame in [1,2,3,4],player.get_node("InkSprite").frame)
	await shot("walk")
	await frames(70)
	Input.action_release("right")
	await frames(12)
	check("crate_blocks_walking",player.position.x>5.15 and player.position.x<5.35,player.position.x)
	var base_y=player.position.y
	Input.action_press("jump")
	Input.action_press("right")
	await frames(1)
	Input.action_release("jump")
	var max_y=player.position.y
	for i in range(25):
		await physics_frame
		max_y=maxf(max_y,player.position.y)
	check("jump_lifts_player",max_y>base_y+0.65,max_y-base_y)
	await shot("jump")
	await frames(50)
	Input.action_release("right")
	await frames(20)
	check("lands_beyond_crate",player.is_on_floor() and player.position.x>6.5,player.position)
	check("depth_locked",absf(player.position.z-1.4)<0.001,player.position.z)
	var camera=scene.get_node("SideCamera")
	check("camera_tracks_player",camera.position.x>2.5 and camera.position.x<=4.8,camera.position.x)
	await shot("land")
	var end_x=player.position.x
	Input.action_press("left")
	await frames(20)
	Input.action_release("left")
	check("left_input_and_facing",player.position.x<end_x-0.6 and player.get_node("InkSprite").flip_h,player.position.x-end_x)
	var all_pass=true
	for v in results.values(): all_pass=all_pass and v.pass
	var f=FileAccess.open(out.path_join("checks.json"),FileAccess.WRITE)
	f.store_string(JSON.stringify({"all_pass":all_pass,"engine":Engine.get_version_info().string,"checks":results},"  ")+"\n")
	f.close()
	scene.queue_free()
	scene=null
	player=null
	await frames(5)
	quit(0 if all_pass else 1)
