extends RefCounted
# Helpers scoped to this study; the saved scene is the editable deliverable.
var root: Node3D

func bounds(n: Node3D, transform := Transform3D.IDENTITY) -> AABB:
	var result := AABB()
	var has := false
	for child in n.get_children():
		if not child is Node3D: continue
		var t: Transform3D = transform * child.transform
		var b := AABB()
		if child is MeshInstance3D:
			b = t * child.get_aabb()
		else:
			b = bounds(child, t)
		if b.size.length() > 0.0001:
			result = result.merge(b) if has else b
			has = true
	return result

func add_asset(path: String, parent: Node3D, label: String, pos: Vector3, height: float = 0.0, angle: float = 0.0, fit := Vector3.ZERO) -> Node3D:
	var n := Node3D.new()
	n.name = label
	parent.add_child(n, true)
	n.owner = root
	var item = load(path).instantiate()
	# Localize imported nodes before assigning their ownership to the saved scene.
	# Retaining the PackedScene link AND serializing its children creates duplicates.
	item.scene_file_path = ""
	n.add_child(item)
	item.owner = root
	var box := bounds(item)
	if height > 0.0: item.scale *= height / box.size.y
	if fit != Vector3.ZERO:
		item.scale = fit / box.size
	box = bounds(n)
	item.position -= Vector3(box.get_center().x, box.position.y, box.get_center().z)
	n.position = pos
	n.rotation.y = deg_to_rad(angle)
	return n

func own(node: Node) -> void:
	for c in node.get_children():
		c.owner = root
		own(c)

func save(path: String) -> void:
	var p := PackedScene.new()
	assert(p.pack(root) == OK)
	assert(ResourceSaver.save(p, path) == OK)

func environment() -> void:
	var e := Environment.new()
	e.background_mode = Environment.BG_COLOR
	e.background_color = Color("7eafb3")
	e.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	e.ambient_light_color = Color("a7c8d1")
	e.ambient_light_energy = 0.55
	e.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	e.ssao_enabled = true
	e.ssao_radius = 1.2
	e.ssao_intensity = 1.2
	e.glow_enabled = true
	e.glow_intensity = 0.25
	var w := WorldEnvironment.new()
	w.name = "Atmosphere"
	w.environment = e
	root.add_child(w)
	w.owner = root
	var sun := DirectionalLight3D.new()
	sun.name = "LateAfternoon"
	sun.rotation_degrees = Vector3(-36, -32, 0)
	sun.light_color = Color("ffe4b5")
	sun.light_energy = 1.55
	sun.shadow_enabled = true
	sun.directional_shadow_max_distance = 100
	root.add_child(sun)
	sun.owner = root
