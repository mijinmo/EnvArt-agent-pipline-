extends SceneTree
const Helpers = preload("res://asset_helpers.gd")
func _initialize() -> void:
	var h = Helpers.new()
	h.root = Node3D.new()
	h.root.name = "AssetAudition"
	root.add_child(h.root)
	h.environment()
	for spec in [["red-cottage", Vector3.ZERO], ["temporary-mesh-fence-panel", Vector3(-6,0,1)], ["wooden-jetty",Vector3(0,0,6)], ["park-bench",Vector3(6,0,2)], ["utility-pole",Vector3(-8,0,-1)], ["traffic-light",Vector3(8,0,-1)]]:
		var n = h.add_asset("res://assets/tevy/"+spec[0]+".glb",h.root,spec[0],spec[1])
		print(spec[0], " ", h.bounds(n))
	var ground = MeshInstance3D.new()
	ground.mesh = PlaneMesh.new()
	ground.mesh.size = Vector2(40,30)
	var mat = StandardMaterial3D.new()
	mat.albedo_color = Color("666c6a")
	ground.material_override = mat
	h.root.add_child(ground)
	h.own(h.root)
	h.save("res://audition.tscn")
	quit()
