extends SceneTree
func _initialize() -> void: call_deferred("run")
func run() -> void:
	var h = load("res://asset_helpers.gd").new()
	h.root = Node3D.new()
	h.root.name = "AssetAudition"
	root.add_child(h.root)
	h.environment()
	var samples = [
		["quaternius_village/Wall_Plaster_WoodGrid.gltf", Vector3(-5,0,0), 3.0],
		["quaternius_village/Roof_RoundTiles_4x4.gltf", Vector3(-5,3,0), 1.7],
		["quaternius_props/Barrel.gltf", Vector3(-3.6,0,1), 1.0],
		["quaternius_props/Prop_Wagon.gltf", Vector3(0,0,0), 1.7],
		["quaternius_nature/CommonTree_1.gltf", Vector3(3,0,0), 6.0],
		["quaternius_nature/Bush_Common_Flowers.gltf", Vector3(1.8,0,1), 0.8],
		["kenney_castle/wall.glb", Vector3(6,0,0), 3.0]]
	for s in samples:
		var path: String = "res://assets/" + s[0]
		if not ResourceLoader.exists(path):
			if "Wagon" in path: path = "res://assets/quaternius_village/Prop_Wagon.gltf"
			else: continue
		var n = h.add_asset(path,h.root,s[0].get_file().get_basename(),s[1],s[2])
		print(s[0], " bounds ",h.bounds(n))
	var f := MeshInstance3D.new()
	var box := BoxMesh.new()
	box.size = Vector3(22,0.2,12)
	f.mesh = box
	f.position.y = -0.1
	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color("646c65")
	f.material_override = mat
	h.root.add_child(f)
	f.owner = h.root
	h.save("res://audition.tscn")
	quit()
