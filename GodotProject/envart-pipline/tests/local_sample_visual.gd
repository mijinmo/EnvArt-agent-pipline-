extends SceneTree
## Real Forward+ captures plus playable-envelope regression checks.
const OUTPUT := "/tmp/envart-local-sample"
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
	check(root.get_texture().get_image().save_png(OUTPUT.path_join(label+".png"))==OK,"capture "+label)
func run() -> void:
	DirAccess.make_dir_recursive_absolute(OUTPUT)
	root.size = Vector2i(1600,1000)
	sample=load("res://envart/local_sample/local_sample.tscn").instantiate(); root.add_child(sample); await frames(20)
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
	var tree_count:=0
	var transforms_valid:=true
	for child in sample.get_node("Backdrop").get_children():
		if child is MultiMeshInstance3D:
			tree_count+=child.multimesh.instance_count
			for i in child.multimesh.instance_count:
				var pos: Vector3=child.multimesh.get_instance_transform(i).origin
				if maxf(absf(pos.x),absf(pos.z))<20: transforms_valid=false
	check(tree_count==460 and transforms_valid,"460 serialized trees outside lab (no zero transforms)")
	var vegetation_clear:=true
	for plant in sample.get_node("Art/GroundVegetation").get_children():
		if not plant is Node3D: continue
		var pos: Vector3=plant.position
		if absf(pos.x)<0.95 and pos.z>-5.6 and pos.z<-2.8: vegetation_clear=false
		if pos.x>-7.65 and pos.x<-4.35 and pos.z>-8.2 and pos.z<0.4: vegetation_clear=false
	check(vegetation_clear,"vegetation roots avoid door and ramp corridors")
	for expected in [false,true]:
		var event:=InputEventKey.new(); event.physical_keycode=KEY_B; event.pressed=true
		Input.parse_input_event(event); await frames(2)
		check(sample.get_node("Backdrop").visible==expected,"B toggles backdrop "+str(expected))
		event=InputEventKey.new(); event.physical_keycode=KEY_B; Input.parse_input_event(event); await frames(1)
	for child in sample.get_node("Backdrop").get_children():
		if str(child.name).begins_with("VillageHouse"):
			check(maxf(absf(child.position.x),absf(child.position.z))>24,"house outside protected lab "+str(child.name))
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
	# Four existing camera modes remain available.
	for mode in 4:
		rig.set_mode(mode); await frames(2); check(rig.active_camera()!=null and rig.active_camera().current,"camera mode "+str(mode))
	player.teleport_to(Transform3D(Basis.IDENTITY,Vector3(0,0.08,-1.8)))
	rig.set_mode(EACameraRig.Mode.THIRD_PERSON); await capture("player_third")
	rig.set_mode(EACameraRig.Mode.FIRST_PERSON); await capture("player_first")
	print("LOCAL SAMPLE RESULT: ","PASS" if failures==0 else "FAIL")
	sample.queue_free(); await frames(5); quit(0 if failures==0 else 1)
