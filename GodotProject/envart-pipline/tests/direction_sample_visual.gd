extends SceneTree
## Real Forward+ captures plus playable-envelope regression checks.
var output := "/tmp/envart-ashen"
var direction := "ashen"
var failures := 0
var sample: Node3D
func _initialize() -> void:
	call_deferred("run")
func frames(count: int) -> void:
	for i in count: await process_frame
func check(ok: bool, message: String) -> void:
	if not ok: failures += 1; push_error(message)
	else: print("PASS: ",message)
func capture(label: String) -> void:
	await frames(25)
	# macOS may suspend presentation when another app covers the test window.
	# Explicit drawing keeps artifact capture independent of desktop focus.
	RenderingServer.force_draw()
	check(root.get_texture().get_image().save_png(output.path_join(label+".png"))==OK,"capture "+label)
func run() -> void:
	direction=OS.get_cmdline_user_args()[0] if OS.get_cmdline_user_args().size()>0 else "ashen"
	assert(direction in ["ashen","facility","realism","refined"])
	output="/tmp/envart-"+direction
	DirAccess.make_dir_recursive_absolute(output)
	root.size = Vector2i(1600,1000)
	var scene_path: String="res://envart/realism_trial/trial.tscn" if direction=="realism" else "res://envart/direction_studies/"+direction+".tscn"
	if direction=="refined": scene_path="res://envart/realism_refined/trial.tscn"
	sample=load(scene_path).instantiate(); root.add_child(sample); await frames(20)
	sample.get_node("BaseLab/PlayerInput").set_physics_process(false)
	sample.get_node("HUD").hide(); sample.get_node("BaseLab/HUD").hide()
	var rig: EACameraRig=sample.get_node("BaseLab/CameraRig")
	var player: EAPlayerMotor=sample.get_node("BaseLab/Player")
	player.teleport_to(Transform3D(Basis.IDENTITY,Vector3(0,0.08,8)))
	for i in 3:
		sample.inspect(i)
		var before: Basis = rig.free_camera.global_basis
		rig.look(Vector2.ZERO)
		check(rig.free_camera.global_basis.is_equal_approx(before),"bookmark mouse continuity "+str(i))
		await capture(["door","ramp","props"][i])
	rig.free_camera.global_position=Vector3(6.1,1.85,-7.6); rig.free_camera.look_at(Vector3(8.95,1.2,-6.3)); rig.free_camera.fov=55
	await capture("workbench_detail")
	rig.free_camera.global_position=Vector3(5.5,2.0,3.7); rig.free_camera.look_at(Vector3(8.05,1.25,-0.6)); rig.free_camera.fov=55
	await capture("shipment_detail")
	rig.free_camera.global_position=Vector3(8.1,1.15,3.6); rig.free_camera.look_at(Vector3(8.1,0.55,0.3)); rig.free_camera.fov=62
	await capture("vegetation_detail")
	sample.inspect(0); sample.set_whitebox(true); await capture("door_whitebox"); sample.set_whitebox(false)
	rig.free_camera.global_position=Vector3(13,10,12); rig.free_camera.look_at(Vector3(0,1,-4)); rig.free_camera.fov=60
	await capture("overview")
	sample.inspect(3); await capture("backdrop_vista")
	check(sample.get_node("Backdrop").find_children("*","CollisionObject3D",true,false).is_empty(),"backdrop has no gameplay collision")
	for expected in [false,true]:
		var event:=InputEventKey.new(); event.physical_keycode=KEY_B; event.pressed=true
		Input.parse_input_event(event); await frames(2)
		check(sample.get_node("Backdrop").visible==expected,"B toggles backdrop "+str(expected))
		event=InputEventKey.new(); event.physical_keycode=KEY_B; Input.parse_input_event(event); await frames(1)
	sample.set_whitebox(true); check(not sample.get_node("Backdrop").visible,"whitebox hides backdrop"); sample.set_whitebox(false)
	# Compare protected original bodies, not the added prop footprints.
	var reference=load("res://demo/controller_lab.tscn").instantiate()
	for body in reference.get_node("World").get_children():
		if body is StaticBody3D:
			var actual=sample.get_node("BaseLab/World/"+str(body.name))
			check(actual.transform==body.transform and actual.get_node("Collision").shape.size==body.get_node("Collision").shape.size,"unchanged collision "+str(body.name))
	reference.free()
	# Walk through each direction of the narrow door.
	for direction in [-1.0,1.0]:
		player.teleport_to(Transform3D(Basis.IDENTITY,Vector3(0,0.08,-4-direction*1.6)))
		for i in 55: player.set_motion(Vector3(0,0,direction),false,false); await physics_frame
		player.clear_motion(); check(player.position.z < -5.2 if direction<0 else player.position.z>-2.8,"door traversable "+str(direction))
	player.teleport_to(Transform3D(Basis.IDENTITY,Vector3(-6,0.08,0.6)))
	for i in 110: player.set_motion(Vector3.FORWARD,false,false); await physics_frame
	player.clear_motion(); check(player.position.y>1.85 and player.position.z < -6,"ramp reaches landing")
	if direction=="refined":
		check(sample.get_node("Art/PlayableCargoStacks").get_child_count()==10,"cargo repetition reduced to ten cases")
		var plants:=0
		for n in sample.get_node("Art").find_children("*","Node3D",true,false):
			var source_path: String=n.get_meta("asset_source","")
			if "fern_02" in source_path or "weed_plant_02" in source_path or "nettle_plant" in source_path:
				plants+=1
				var mesh: MeshInstance3D=n.get_node("SourceMesh")
				check(mesh.material_override is ShaderMaterial and mesh.material_override.get_shader_parameter("leaf_alpha") is Texture2D,"plant has separate alpha "+str(n.name))
			if not source_path.is_empty():check(not "quaternius_nature" in source_path and not "Prop_Vine" in source_path,"no stylized foliage "+str(n.name))
		check(plants>30,"PBR plant groups installed")
		for data in [[Vector3(1,1.2,1),0.4],[Vector3(1,1.7,-1),0.9],[Vector3(3,2.2,-3),1.4]]:
			player.teleport_to(Transform3D(Basis.IDENTITY,data[0]));player.clear_motion()
			for i in 70:await physics_frame
			check(absf(player.position.y-data[1])<0.1,"cargo landing height "+str(data[1]))
	# Four existing camera modes remain available.
	for mode in 4:
		rig.set_mode(mode); await frames(2); check(rig.active_camera()!=null and rig.active_camera().current,"camera mode "+str(mode))
	player.teleport_to(Transform3D(Basis.IDENTITY,Vector3(0,0.08,-1.8)))
	rig.set_mode(EACameraRig.Mode.THIRD_PERSON); await capture("player_third")
	rig.set_mode(EACameraRig.Mode.FIRST_PERSON); await capture("player_first")
	print(direction.to_upper()+" SAMPLE RESULT: ","PASS" if failures==0 else "FAIL")
	sample.queue_free(); await frames(5); quit(0 if failures==0 else 1)
