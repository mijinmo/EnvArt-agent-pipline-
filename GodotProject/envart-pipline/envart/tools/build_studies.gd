extends SceneTree
## Explicit offline authoring step. Saves editable scenes; never runs during gameplay.
## Regeneration replaces only envart/styles/*.tscn. Save manual variations elsewhere.
const ASSETS := "res://envart/assets/kenney_castle/"
const IDS := ["verdant", "ashen", "facility"]
var art: Node3D
var base: Node3D
var rng := RandomNumberGenerator.new()
var stone: StandardMaterial3D
var dark: StandardMaterial3D
var trim: StandardMaterial3D
var accent: StandardMaterial3D
var vegetation: StandardMaterial3D
var variant: int
var sequence: int = 0

func _initialize() -> void:
	base = load("res://demo/controller_lab.tscn").instantiate()
	for index in 3:
		variant = index
		rng.seed = 81421
		build()
	base.free()
	quit()

func material(hex: String, roughness: float = 0.85, emission: float = 0.0) -> StandardMaterial3D:
	var m := StandardMaterial3D.new()
	m.albedo_color = Color(hex)
	m.roughness = roughness
	if emission > 0:
		m.emission_enabled = true
		m.emission = m.albedo_color
		m.emission_energy_multiplier = emission
	return m

func add(node: Node, parent: Node = null) -> void:
	sequence += 1
	if parent == null: parent = art
	if node.name.is_empty(): node.name = "Detail_%04d" % sequence
	parent.add_child(node)
	node.owner = art

func box(label: String, pos: Vector3, size: Vector3, mat: Material, parent: Node = null) -> MeshInstance3D:
	var mesh := BoxMesh.new()
	mesh.size = size
	var n := MeshInstance3D.new()
	n.name = label + "_%04d" % sequence
	n.mesh = mesh
	n.material_override = mat
	n.position = pos
	add(n, parent)
	return n

func source(model: String, pos: Vector3, scale_value: Vector3, yaw: float = 0, override: Material = null) -> Node3D:
	var node: Node3D = load(ASSETS + model + ".glb").instantiate()
	node.name = model.replace("-", "_") + "_%04d" % sequence
	node.position = pos
	node.scale = scale_value
	node.rotation.y = yaw
	add(node)
	# Preserve GLB instances; surface overrides are authored as editable children.
	if override:
		art.set_editable_instance(node, true)
		for m in node.find_children("*", "MeshInstance3D", true, false):
			m.material_override = override
	return node

func build() -> void:
	art = Node3D.new()
	art.name = IDS[variant].capitalize()
	art.set_script(load("res://envart/style.gd"))
	art.title = ["VERDANT RELIQUARY", "COURT OF ASH", "FACILITY 07"][variant]
	stone = material(["b7ad87", "646b70", "ced8df"][variant])
	dark = material(["575d40", "303b44", "253644"][variant])
	trim = material(["d8cda6", "8a9297", "e4edf0"][variant])
	accent = material(["409e9d", "ffab58", "49cfe4"][variant], 0.45, [0.0, 1.8, 1.3][variant])
	vegetation = material(["688d40", "3f4942", "36566b"][variant])
	configure_environment()
	var surfaces := Node3D.new()
	surfaces.name = "ProtectedSurfaces"
	add(surfaces)
	for body in base.get_node("World").get_children():
		if not body is StaticBody3D: continue
		var original: MeshInstance3D = body.get_node("Mesh")
		var n := MeshInstance3D.new()
		n.name = body.name
		n.mesh = original.mesh
		n.transform = body.transform * original.transform
		n.material_override = dark if body.name == "Floor" else stone
		if body.name == "SpawnPad": n.material_override = accent
		add(n, surfaces)
		if body.name == "Floor":
			n.position.y -= 0.025
			continue
		var size: Vector3 = original.mesh.size
		# Thin caps lie inside the source box, so the visual walk surface matches physics.
		box("Cap", Vector3(0, size.y * 0.5 - 0.013, 0), Vector3(size.x, 0.03, size.z), trim, n)
		if body.name.begins_with("Jump") or body.name.begins_with("Step"):
			box("LandingEdge", Vector3(0, size.y * 0.5 - 0.02, size.z * 0.5 - 0.035), Vector3(size.x * 0.9, 0.04, 0.05), accent, n)
		if body.name in ["BackWall", "DoorLeft", "DoorRight", "OcclusionWall", "OcclusionReturn", "Landing"]:
			clad(n, size)
	floor_pattern()
	if variant == 2:
		facility()
	else:
		courtyard()
	var packed := PackedScene.new()
	assert(packed.pack(art) == OK)
	assert(ResourceSaver.save(packed, "res://envart/styles/" + IDS[variant] + ".tscn") == OK)
	print("Saved ", IDS[variant], ": ", art.find_children("*", "MeshInstance3D", true, false).size(), " mesh nodes")
	art.free()

func configure_environment() -> void:
	var env := Environment.new()
	var sky := Sky.new()
	var sky_mat := ProceduralSkyMaterial.new()
	sky_mat.sky_top_color = Color(["448db4", "344b62", "172937"][variant])
	sky_mat.sky_horizon_color = Color(["c8dcca", "8e9a9d", "687c8a"][variant])
	sky_mat.ground_horizon_color = sky_mat.sky_horizon_color
	sky_mat.ground_bottom_color = Color(["626b42", "303c43", "172937"][variant])
	sky.sky_material = sky_mat
	env.background_mode = Environment.BG_SKY
	env.sky = sky
	env.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	env.ambient_light_color = Color(["d7e4d5", "a0b7d0", "bbd3e8"][variant])
	env.ambient_light_energy = [0.45, 0.30, 0.7][variant]
	env.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	env.ssao_enabled = true
	env.ssao_radius = 1.5
	env.ssao_intensity = 1.3
	env.fog_enabled = true
	env.fog_light_color = sky_mat.sky_horizon_color
	env.fog_density = [0.0015, 0.006, 0.002][variant]
	art.environment = env
	art.sun_color = Color(["ffe3ad", "b4c6dc", "d8efff"][variant])
	art.sun_energy = [1.25, 1.15, 1.1][variant]
	art.sun_rotation = [Vector3(-50,-35,0), Vector3(-26,-50,0), Vector3(-65,20,0)][variant]

func clad(parent: Node3D, size: Vector3) -> void:
	# Tile the visible face INSIDE the collision boundary, with recessed dark joints.
	parent.material_override = dark
	var along_x := size.x >= size.z
	var width := size.x if along_x else size.z
	var depth := size.z if along_x else size.x
	var rows := maxi(1, ceili(size.y / (1.0 if variant == 2 else 0.45)))
	var cols := maxi(1, ceili(width / (1.9 if variant == 2 else 1.2)))
	for side in [-1, 1]:
		for row in rows:
			for col in cols:
				var w := width / cols
				var h := size.y / rows
				var p := Vector3(-width/2 + w*(col+0.5), -size.y/2 + h*(row+0.5), side*(depth/2 - 0.010))
				var s := Vector3(w-0.025, h-0.025, 0.024)
				if not along_x:
					p = Vector3(p.z,p.y,p.x)
					s = Vector3(s.z,s.y,s.x)
				box("Panel" if variant == 2 else "Ashlar", p, s, stone if (row+col)%4 else trim, parent)

func floor_pattern() -> void:
	# Flush overlays are below the floor collision surface, avoiding floating foot contacts.
	var floor_mat := material(["a49f7e", "5c656b", "87959f"][variant])
	for x in range(-15,16,2):
		for z in range(-15,16,2):
			if variant != 2 and not (abs(x) < 3 or abs(z + 4) < 2 or abs(x+6)<2): continue
			box("Paving", Vector3(x,-0.012,z), Vector3(1.94,0.024,1.94), floor_mat)
	for z in range(-10,11,2):
		box("RouteMarker",Vector3(-0.45,-0.008,z),Vector3(0.06,0.02,0.65),accent)

func courtyard() -> void:
	# Scenery is outside the 32 m gameplay floor; the collision harness stays authoritative.
	for x in [-18.0,18.0]:
		for z in range(-18,19,5):
			source("rocks-large", Vector3(x,-1,z),Vector3(4,4,4),rng.randf()*TAU,dark)
			if variant == 0:
				source("tree-large",Vector3(x+rng.randf_range(-1,1),0,z),Vector3.ONE*rng.randf_range(3.0,4.7),rng.randf()*TAU)
			else:
				dead_tree(Vector3(x,0,z))
	for x in [-9.0,9.0]:
		var height := 9.0 if variant == 0 else 13.0
		source("tower-square-base",Vector3(x,0,-18),Vector3(5,4,5),0,stone)
		for tier in (2 if variant == 0 else 3):
			source("tower-square-mid",Vector3(x,3.9+tier*3.0,-18),Vector3(5,3,5),0,stone)
		source("tower-square-top",Vector3(x,height,-18),Vector3(5,4,5),0,trim)
		if variant == 1:
			source("tower-hexagon-base",Vector3(x,height+1,-18),Vector3(2.5,4,2.5),0,dark)
			source("tower-hexagon-top",Vector3(x,height+5,-18),Vector3(2.5,2,2.5),0,stone)
	# Far mountains / broken silhouettes use sourced rock clusters, not new gameplay walls.
	for i in 10:
		var x := -42.0 + i*9.0
		source("rocks-large",Vector3(x,-3,-36-rng.randf_range(0,8)),Vector3(13,rng.randf_range(22,38),12),rng.randf()*TAU,vegetation if variant==0 else dark)
	# The front-facing gate keeps its 1.2 m x 2.3 m passage clear.
	for x in [-0.95,0.95]:
		box("GateCrown",Vector3(x,2.7,-4),Vector3(0.7,0.2,0.6),trim)
	box("GateFrieze",Vector3(0,2.85,-4),Vector3(2.6,0.12,0.6),trim)
	for x in [-0.95,0.95]:
		box("GateInlay",Vector3(x,1.4,-3.692),Vector3(0.10,1.7,0.016),accent)
	if variant == 0:
		for x in [-8.0,8.0]:
			source("flag-banner-long",Vector3(x,3.0,-12.05),Vector3.ONE*1.8,PI/2)
	else:
		for x in [-0.95,0.95]:
			var lamp := OmniLight3D.new()
			lamp.position = Vector3(x,2,-3.4)
			lamp.light_color = Color("ffb16a")
			lamp.light_energy = 2
			lamp.omni_range = 4
			add(lamp)
	# Thin lichen patches stay flush to the ground; no tall foliage hides platforms.
	if variant == 0:
		for i in 80:
			var x := rng.randf_range(-15,15)
			var z := rng.randf_range(-11,15)
			if abs(x)<3 or abs(x+6)<2 or abs(x-5)<2: continue
			box("MossPatch",Vector3(x,-0.006,z),Vector3(rng.randf_range(0.15,0.6),0.016,rng.randf_range(0.2,0.6)),vegetation)

func dead_tree(p: Vector3) -> void:
	source("tree-trunk",p,Vector3(2.5,6,2.5),rng.randf()*TAU,dark)
	for side in [-1,1]:
		var branch := box("DeadBranch",p+Vector3(side*0.7,3.3,0),Vector3(0.23,3.0,0.23),dark)
		branch.rotation.z = side*-0.7

func facility() -> void:
	# Remote structure frames the testing courtyard without closing the inspection path.
	for x in [-18.0,18.0]:
		for z in range(-18,19,6):
			box("StructuralPier",Vector3(x,6,z),Vector3(1.0,12,1.0),dark)
			box("PierLight",Vector3(x-signf(x)*0.51,6,z),Vector3(0.04,8,0.2),accent)
	for z in [-18.0,0.0,18.0]:
		box("OverheadBeam",Vector3(0,12,z),Vector3(37,0.8,0.9),dark)
		box("OverheadLight",Vector3(0,11.58,z),Vector3(30,0.04,0.22),trim)
	for x in range(-20,21,4):
		box("RearPanel",Vector3(x,6,-20),Vector3(3.9,12,0.4),stone)
		box("RearPanelSeam",Vector3(x,6,-19.78),Vector3(0.08,11,0.03),accent)
	var orange := material("e99c49",0.5)
	for x in [-0.95,0.95]:
		box("DoorGuide",Vector3(x,1.3,-3.69),Vector3(0.16,2.4,0.025),accent)
	box("DoorHeader",Vector3(0,2.45,-3.69),Vector3(2.5,0.17,0.025),accent)
	for z in [-2.0,0.0,2.0]:
		box("HazardStripe",Vector3(2.1,-0.005,z),Vector3(0.6,0.015,0.16),orange)
	for x in [-14.0,14.0]:
		# Equipment beyond the floor edge, never invisible obstacles in the test area.
		for z in [-22.0,22.0]:
			box("ServicePod",Vector3(x,1.7,z),Vector3(3,3.4,2),stone)
			for y in range(1,6):
				box("Vent",Vector3(x,y*0.45,z+1.01),Vector3(2.4,0.12,0.025),dark)
	var sign_node := Label3D.new()
	sign_node.name = "TestChamberNumber"
	sign_node.text = "07  /  FIELD SYSTEMS"
	sign_node.font_size = 128
	sign_node.pixel_size = 0.012
	sign_node.position = Vector3(0,7,-19.7)
	sign_node.modulate = Color("203947")
	add(sign_node)
