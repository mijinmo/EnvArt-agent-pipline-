extends SceneTree
# Reuses the project's existing motor checks for the protected play surfaces only.
var results: Array[Dictionary] = []
func _initialize() -> void:
	call_deferred("run")
func record(name: String, ok: bool, position: Vector3) -> void:
	results.append({"check":name,"passed":ok,"position":[position.x,position.y,position.z]})
func run() -> void:
	var args = OS.get_cmdline_user_args()
	if args.size() != 1:
		quit(2)
		return
	var scene = load("res://" + args[0]).instantiate()
	root.add_child(scene)
	for i in range(10): await process_frame
	for input in scene.find_children("*", "EAPlayerInput", true, false): input.set_physics_process(false)
	var players = scene.find_children("Player", "CharacterBody3D", true, false)
	if players.size() != 1:
		push_error("Expected existing single inspection player")
		quit(2)
		return
	var player = players[0]
	for direction in [-1.0,1.0]:
		player.teleport_to(Transform3D(Basis.IDENTITY,Vector3(0,0.08,-4-direction*1.6)))
		for i in range(55):
			player.set_motion(Vector3(0,0,direction),false,false)
			await physics_frame
		player.clear_motion()
		record("door direction "+str(direction),player.position.z < -5.2 if direction<0 else player.position.z>-2.8,player.position)
	player.teleport_to(Transform3D(Basis.IDENTITY,Vector3(-6,0.08,0.6)))
	for i in range(110):
		player.set_motion(Vector3.FORWARD,false,false)
		await physics_frame
	player.clear_motion()
	record("ramp to landing",player.position.y>1.85 and player.position.z < -6,player.position)
	var surfaces = [
		["JumpLow",Vector3(1,1.2,1),0.4],
		["JumpMid",Vector3(1,1.7,-1),0.9],
		["JumpHigh",Vector3(3,2.2,-3),1.4],
		["Step1",Vector3(5,1.1,2),0.2],
		["Step2",Vector3(5,1.3,1.4),0.4],
		["Step3",Vector3(5,1.5,.8),0.6],
		["Step4",Vector3(5,1.7,.2),0.8]
	]
	for item in surfaces:
		player.teleport_to(Transform3D(Basis.IDENTITY,item[1]))
		for i in range(70): await physics_frame
		record(str(item[0])+" original top remains usable",absf(player.position.y-item[2])<0.1,player.position)
	var ok = results.all(func(r):return r.passed)
	print("ROUTE_CHECK "+JSON.stringify({"passed":ok,"checks":results}))
	scene.free()
	quit(0 if ok else 2)
