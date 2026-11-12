extends SceneTree
## Requires local Mixamo installation: fail visibly if source setup is absent.
var failures: int = 0
var lab: Node3D
func _initialize() -> void:
	call_deferred("run")
func check(ok: bool, message: String) -> void:
	if ok: print("PASS: ",message)
	else:
		failures += 1
		push_error(message)
func frames(n: int) -> void:
	for i in n: await physics_frame
func run() -> void:
	lab = load("res://demo/controller_lab.tscn").instantiate()
	root.add_child(lab)
	lab.get_node("PlayerInput").set_physics_process(false)
	await frames(20)
	var player: EAPlayerMotor = lab.get_node("Player")
	var visual: EAHumanoidVisual = player.get_node("Visual/Humanoid")
	check(visual.available,"local Mixamo character is installed")
	if not visual.available:
		lab.queue_free()
		await process_frame
		quit(1)
		return
	var skel: Skeleton3D = visual.model.get_node("Skeleton3D")
	check(skel.get_bone_count()==65,"Mannequin contains 65 skeletal bones")
	check(not player.body_mesh.visible and not player.facing_marker.visible,"capsule visuals replaced")
	check(visual.state==&"idle","grounded stationary body uses idle")
	for name in ["idle","walking","running","jump"]:
		var clip: Animation = visual.animation.get_animation(name)
		check(clip != null and clip.get_track_count()>40,"skeletal animation exists: "+name)
		for track in clip.get_track_count():
			if clip.track_get_type(track)==Animation.TYPE_POSITION_3D and str(clip.track_get_path(track)).ends_with("_Hips"):
				var first: Vector3 = clip.track_get_key_value(track,0)
				var fixed := true
				for key in clip.track_get_key_count(track):
					var value: Vector3 = clip.track_get_key_value(track,key)
					fixed = fixed and is_equal_approx(value.x,first.x) and is_equal_approx(value.z,first.z)
					if name=="jump": fixed = fixed and is_equal_approx(value.y,first.y)
				check(fixed,"root travel removed: "+name)
	var arm := skel.find_bone("mixamorig1_LeftArm")
	var idle_pose := skel.get_bone_pose_rotation(arm)
	player.set_motion(Vector3.FORWARD*0.4,false,false)
	await frames(20)
	check(visual.state==&"walking","low actual speed selects walk")
	check(not skel.get_bone_pose_rotation(arm).is_equal_approx(idle_pose),"walk changes skeletal pose")
	player.set_motion(Vector3.FORWARD,true,false)
	await frames(24)
	check(visual.state==&"running","high actual speed selects run")
	player.teleport_to(Transform3D(Basis.IDENTITY,Vector3(-10,0.08,8)))
	await frames(20)
	player.set_motion(Vector3.ZERO,false,true)
	await frames(8)
	check(visual.state==&"jump" and player.velocity.y>0,"physics jump selects Mixamo airborne pose")
	await frames(80)
	check(player.is_on_floor() and visual.state==&"idle","landing returns to grounded animation")
	var rig: EACameraRig = lab.get_node("CameraRig")
	rig.set_mode(EACameraRig.Mode.FIRST_PERSON)
	await frames(2)
	check(not player.visual.visible,"first-person hides humanoid")
	rig.set_mode(EACameraRig.Mode.THIRD_PERSON)
	await frames(2)
	check(player.visual.visible,"third-person restores humanoid")
	rig.set_mode(EACameraRig.Mode.RAIL)
	await frames(2)
	check(player.visual.visible,"rail inspection keeps humanoid visible")
	lab.queue_free()
	await frames(3)
	var fallback: EAPlayerMotor = load("res://controllers/player.tscn").instantiate()
	fallback.get_node("Visual/Humanoid").model_path = "res://characters/missing_for_fallback_check.scn"
	root.add_child(fallback)
	await frames(3)
	check(not fallback.get_node("Visual/Humanoid").available and fallback.body_mesh.visible,"missing local assets preserve the playable capsule fallback")
	fallback.queue_free()
	await frames(3)
	print("HUMANOID RESULT: ","PASS" if failures==0 else "FAIL")
	quit(0 if failures==0 else 1)
