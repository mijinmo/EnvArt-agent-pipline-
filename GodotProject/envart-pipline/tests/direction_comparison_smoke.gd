extends SceneTree
var failures:=0
func _initialize() -> void:call_deferred("run")
func check(ok: bool,message: String) -> void:
	if ok:print("PASS: ",message)
	else:failures+=1;push_error(message)
func settle() -> void:
	for i in 3:await physics_frame
	for i in 3:await process_frame
func run() -> void:
	Input.use_accumulated_input=false
	var comparison=load("res://envart/direction_studies/comparison.tscn").instantiate();root.add_child(comparison);await settle()
	var pose: Transform3D=comparison.sample.rig.free_camera.global_transform
	for i in [1,2,0]:
		var event:=InputEventKey.new();event.physical_keycode=[KEY_Z,KEY_X,KEY_C][i];event.pressed=true;Input.parse_input_event(event);Input.flush_buffered_events();await settle()
		check(comparison.current_direction==i,"shortcut selects direction "+str(i))
		check(comparison.sample.rig.free_camera.global_transform.is_equal_approx(pose),"same free camera pose "+str(i))
		check(comparison.get_child_count()==2,"only one playable variant loaded")
		var art_count:=0
		for n in comparison.sample.get_node("Art").find_children("*","Node3D",true,false):
			if n.has_meta("asset_source"):art_count+=1
		check(art_count>100,"actual source instances present "+str(i))
		event=InputEventKey.new();event.physical_keycode=[KEY_Z,KEY_X,KEY_C][i];Input.parse_input_event(event);Input.flush_buffered_events();await settle()
	comparison.sample.rig.set_mode(EACameraRig.Mode.RAIL);comparison.sample.rig.rail_camera.scrub(9.2)
	comparison.select_direction(1);await settle()
	check(comparison.sample.rig.mode==EACameraRig.Mode.RAIL,"rail mode survives switch")
	check(is_equal_approx(comparison.sample.rig.rail_camera.playhead(),9.2),"rail time survives switch")
	check(not comparison.sample.rig.rail_camera.is_playing(),"comparison holds rail frame")
	comparison.sample.backdrop_enabled=false;comparison.sample.set_whitebox(true)
	comparison.select_direction(2);await settle()
	check(comparison.sample.whitebox and not comparison.sample.get_node("Art").visible,"whitebox survives switch")
	check(not comparison.sample.get_node("Backdrop").visible,"backdrop remains hidden")
	var disabled:=true
	for s in comparison.sample.get_node("Art").find_children("*","CollisionShape3D",true,false):
		if not s.disabled:disabled=false
	check(disabled,"whitebox disables new prop collisions")
	comparison.sample.set_whitebox(false);await settle()
	check(not comparison.sample.get_node("BaseLab/World/Floor/Mesh").visible,"source floor hidden under authored paving")
	print("DIRECTION COMPARISON RESULT: ","PASS" if failures==0 else "FAIL")
	comparison.queue_free();await settle();quit(0 if failures==0 else 1)
