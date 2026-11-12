extends SceneTree
## Offline assembly. Source meshes and PBR textures are Quaternius CC0 Standard.
## Outputs an editable scene. Gameplay bodies in controller_lab remain untouched.
const DEST := "res://envart/local_sample/art.tscn"
var art: Node3D
var group: Node3D
var serial := 0
var material_cache := {}
var library := {}
func _initialize() -> void:
	call_deferred("build")
func section(label: String) -> void:
	group = Node3D.new(); group.name = label; art.add_child(group); group.owner = art
func bounds(n: Node3D) -> AABB:
	var first := true; var result := AABB()
	for m in n.find_children("*","MeshInstance3D",true,false):
		var t := Transform3D.IDENTITY
		var child: Node3D = m
		while child != n:
			t = child.transform * t; child = child.get_parent()
		var b: AABB = t * m.get_aabb()
		result = b if first else result.merge(b); first = false
	return result
func source(pack: String, model: String, pos: Vector3, size := Vector3.ONE, yaw := 0.0, grounded := true, collision := false) -> Node3D:
	var path := "res://envart/assets/quaternius_"+pack+"/"+model+".gltf"
	if not library.has(path): library[path] = load(path)
	var node: Node3D = library[path].instantiate()
	var b := bounds(node)
	node.name = "%s_%03d" % [model,serial]; serial += 1
	group.add_child(node); node.owner = art
	node.scale = size; node.rotation.y = deg_to_rad(yaw)
	node.position = pos
	if grounded: node.position.y -= b.position.y * size.y
	node.set_meta("asset_source",path)
	# Keep textures/UVs; attenuate overly strong source normals for close inspection.
	art.set_editable_instance(node,true)
	for mesh in node.find_children("*","MeshInstance3D",true,false):
		for surface in mesh.mesh.get_surface_count():
			var original: Material = mesh.get_active_material(surface)
			if original is StandardMaterial3D:
				if not material_cache.has(original):
					var tuned: StandardMaterial3D = original.duplicate()
					tuned.normal_scale = 0.38
					tuned.texture_filter = BaseMaterial3D.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS_ANISOTROPIC
					if "Vertex" in tuned.resource_name: tuned.vertex_color_use_as_albedo = true
					if "Wood" in tuned.resource_name or "Furniture" in tuned.resource_name:
						tuned.albedo_color = Color(0.78,0.82,0.88)
					if "Vine" in tuned.resource_name: tuned.albedo_color *= Color(0.85,0.90,0.80)
					material_cache[original] = tuned
				mesh.set_surface_override_material(surface,material_cache[original])
	if collision:
		var body := StaticBody3D.new(); body.name = node.name+"_Footprint"; group.add_child(body); body.owner = art
		body.collision_layer = 1; body.collision_mask = 2
		body.transform = Transform3D(Basis(Vector3.UP,deg_to_rad(yaw)),node.position)
		var shape := CollisionShape3D.new(); body.add_child(shape); shape.owner = art
		var box := BoxShape3D.new(); box.size = b.size * size
		shape.shape = box; shape.position = b.get_center()*size
	return node
func v(model: String, pos: Vector3, size := Vector3.ONE, yaw := 0.0, grounded := true) -> Node3D:
	return source("village",model,pos,size,yaw,grounded)
func p(model: String, pos: Vector3, scale_value := 1.0, yaw := 0.0, collision := false) -> Node3D:
	return source("props",model,pos,Vector3.ONE*scale_value,yaw,true,collision)
func light(pos: Vector3, strength := 0.7, radius := 2.6) -> void:
	var lamp := OmniLight3D.new(); lamp.name = "Warm_Lantern_%03d" % serial; serial += 1
	group.add_child(lamp); lamp.owner = art; lamp.position = pos; lamp.light_color = Color("ffbd72"); lamp.light_energy = strength; lamp.omni_range = radius; lamp.shadow_enabled = true; lamp.omni_attenuation = 1.5
func lantern(pos: Vector3, yaw := 0.0) -> void:
	source("props","Lantern_Wall",pos,Vector3.ONE*0.48,yaw,false)
	light(pos+Basis(Vector3.UP,deg_to_rad(yaw))*Vector3(0,0.2,0.46))
func collision_box(label: String, pos: Vector3, dimensions: Vector3, rotation_value := Vector3.ZERO) -> void:
	var body := StaticBody3D.new(); body.name = label; group.add_child(body); body.owner = art
	body.position = pos; body.rotation_degrees = rotation_value; body.collision_layer = 1; body.collision_mask = 2
	var shape := CollisionShape3D.new(); body.add_child(shape); shape.owner = art
	var box := BoxShape3D.new(); box.size = dimensions; shape.shape = box
func plank_rail(pos: Vector3, yaw: float, pitch := 0.0, length := 1.0) -> void:
	var n := v("Balcony_Cross_Straight",pos,Vector3(length,0.78,1),yaw,false)
	# Source rail lies at local z=1; place its center directly on the mounting line.
	# Rotate the unscaled frame, then apply lengths; S*R would flatten the slope
	# differently from the deck and leave a vertical gap at every 2 m seam.
	n.basis = Basis(Vector3.UP,deg_to_rad(yaw)) * Basis(Vector3.FORWARD,deg_to_rad(pitch)) * Basis.from_scale(Vector3(length,0.78,1))
	n.position -= n.basis * Vector3(0,0,1)
func build() -> void:
	art = Node3D.new(); art.name = "HarborDeliverySample"
	section("Doorway_StoneAndTimber")
	# Existing 1.2 m clear opening remains. Threshold is buried flush with floor.
	v("DoorFrame_Flat_Brick",Vector3(0,-0.05,-3.87),Vector3(1.10,1.10,1),180,false)
	v("DoorFrame_Flat_Brick",Vector3(0,-0.05,-4.13),Vector3(1.10,1.10,1),0,false)
	for x in [-1.13,1.13]:
		v("Corner_Exterior_Brick",Vector3(x,0,-3.87),Vector3(0.7,0.86,0.78),0)
		v("Corner_Exterior_Brick",Vector3(x,0,-4.13),Vector3(0.7,0.86,0.78),180)
	v("Prop_ExteriorBorder_Straight1",Vector3(0,2.60,-4.38),Vector3(1.38,1,1.08))
	v("Roof_RoundTile_2x1_Long",Vector3(0,3.09,-4),Vector3(0.72,0.40,0.68),0,false)
	lantern(Vector3(-1.08,1.60,-3.70))
	lantern(Vector3(1.08,1.60,-3.70))
	v("Prop_Vine4",Vector3(1.10,2.66,-3.56),Vector3(0.40,0.60,0.55),0,false)
	source("props","Banner_1",Vector3(-1.2,2.85,-3.9),Vector3.ONE*0.47,180,false)
	# A checked delivery and a waiting shipment frame the route without blocking it.
	p("Crate_Wooden",Vector3(-2.15,0,-4.05),1.0,-6,true)
	p("FarmCrate_Apple",Vector3(-2.15,0.94,-4.05),0.95,3)
	p("Barrel",Vector3(-2.86,0,-4.35),1.0,14,true)
	p("Bag",Vector3(-2.72,0,-3.57),0.8,-18,true)
	p("Rope_1",Vector3(-2.84,0.91,-4.35),0.65,12)
	p("Vase_4",Vector3(1.94,0,-4.10),1.15,8,true)
	p("Vase_2",Vector3(2.56,0,-4.26),0.88,-10,true)
	p("Bag",Vector3(2.1,0,-4.75),0.90,28,true)
	p("Bucket_Wooden_1",Vector3(1.82,0,-3.48),0.9,17)
	section("Ramp_LoadingDock")
	# Tile original slope, rather than changing the climb or building steps over it.
	var ramp_transform := Transform3D(Basis(Vector3.RIGHT,deg_to_rad(18.43495)),Vector3(-6,0.85,-3))
	for row in 4:
		var n := v("Floor_WoodDark",Vector3.ZERO,Vector3(1.5,1,0.7906125),0,false)
		n.transform = ramp_transform * Transform3D(Basis.IDENTITY.scaled(Vector3(1.5,1,0.7906125)),Vector3(0,0.141,(-2.3718375+row*1.581225)))
	for side in [-1.0,1.0]:
		collision_box("RampGuard_"+str(int(side)),Vector3(-6+side*1.67,1.5,-3),Vector3(0.10,1.1,6.32),Vector3(18.43495,0,0))
		for row in 3:
			var z: float = -1.0-row*2.0
			plank_rail(Vector3(-6+side*1.58,-z/3.0+0.08,z),90,-18.43495,1.0541)
	# Landing wall wraps only the original landing solid, with a timber platform top.
	v("Floor_WoodDark",Vector3(-6,1.99,-7),Vector3(1.5,1,1),0,false)
	for x in [-6.75,-5.25]:
		v("Wall_UnevenBrick_Straight",Vector3(x,0,-8.025),Vector3(0.75,0.64,1),180)
	v("Wall_UnevenBrick_Straight",Vector3(-7.51,0,-7),Vector3(1,0.64,1),-90)
	v("Wall_UnevenBrick_Straight",Vector3(-4.49,0,-7),Vector3(1,0.64,1),90)
	plank_rail(Vector3(-6,2.08,-8.08),0,0,1.5)
	plank_rail(Vector3(-7.58,2.08,-7),90)
	plank_rail(Vector3(-4.42,2.08,-7),90)
	collision_box("LandingBackGuard",Vector3(-6,2.5,-8.15),Vector3(3.2,1.0,0.1))
	for side in [-1.0,1.0]:
		collision_box("LandingSideGuard_"+str(int(side)),Vector3(-6+side*1.67,2.5,-7),Vector3(0.1,1.0,2.0))
	p("Crate_Wooden",Vector3(-7.02,2,-7.38),0.75,-4,true)
	p("Bag",Vector3(-7.02,2.70,-7.38),0.65,5)
	p("Rope_2",Vector3(-4.96,2,-7.44),0.7,9)
	# Side staging stays outside the 3 m ramp corridor.
	v("Prop_Wagon",Vector3(-8.80,0,-4.65),Vector3.ONE*0.72,-4)
	collision_box("WagonFootprint",Vector3(-8.8,0.6,-5.15),Vector3(1.3,1.2,2.7),Vector3(0,-4,0))
	p("Bag",Vector3(-8.95,0.68,-4.6),0.65,10)
	p("FarmCrate_Carrot",Vector3(-8.52,0.68,-4.6),0.7,-6)
	p("Barrel",Vector3(-8.62,0,-1.68),1.1,5,true)
	p("Crate_Wooden",Vector3(-8.72,0,-2.53),0.85,-11,true)
	p("Rope_3",Vector3(-8.62,1.0,-1.68),0.53,23)
	p("Bucket_Metal",Vector3(-8.15,0,-0.90),0.9,15)
	p("Bag",Vector3(-3.57,0,-6.82),1.05,19,true)
	p("Bag",Vector3(-3.85,0,-7.45),0.85,-14,true)
	section("Wall_ServiceAndMarket")
	# Inward face of original x=10 wall: 2 m kit modules, alternating masonry/plaster.
	for i in 5:
		var z := -10.0+i*2.0
		var model := "Wall_Plaster_WoodGrid" if i%2==0 else "Wall_UnevenBrick_Straight"
		v(model,Vector3(9.74,0,z),Vector3.ONE,-90)
		if i%2==0:
			v("Wall_Plaster_Straight",Vector3(9.78,0,z),Vector3.ONE,-90)
		v("Corner_Exterior_Wood",Vector3(9.69,0,z-1.0),Vector3.ONE,-90)
		v("Prop_ExteriorBorder_Straight1",Vector3(9.85,0.02,z),Vector3(1,1,0.35),-90)
		v("Roof_Wooden_2x1",Vector3(9.7,2.95,z),Vector3(1,0.65,0.55),-90,false)
	for x in [7.0,9.0]:
		v("Wall_UnevenBrick_Straight",Vector3(x,0,-0.74),Vector3.ONE,0)
		v("Wall_Plaster_WoodGrid",Vector3(x,0,-1.26),Vector3.ONE,180)
		v("Wall_Plaster_Straight",Vector3(x,0,-1.22),Vector3.ONE,180)
		v("Roof_Wooden_2x1",Vector3(x,2.95,-0.75),Vector3(1,0.65,0.55),0,false)
	v("Corner_Exterior_Wood",Vector3(6.04,0,-0.87),Vector3.ONE)
	v("Prop_Vine1",Vector3(6.27,2.8,-0.56),Vector3(0.65,0.9,0.8),0,false)
	# Repair bench: tools above, spare pails below, ledger and rope on the surface.
	p("Workbench",Vector3(8.97,0,-6.50),1.0,-90,true)
	p("Workbench_Drawers",Vector3(9.04,0.12,-6.50),1.0,-90)
	source("props","Peg_Rack",Vector3(9.50,1.75,-6.50),Vector3.ONE,-90,false)
	var pick := source("props","Pickaxe_Bronze",Vector3(9.38,1.38,-6.22),Vector3.ONE*0.65,-90,false); pick.rotate_object_local(Vector3.FORWARD,0.2)
	source("props","Axe_Bronze",Vector3(9.36,1.45,-6.83),Vector3.ONE*0.7,-90,false)
	p("Rope_1",Vector3(8.9,0.91,-6.94),0.63,0)
	p("Book_5",Vector3(8.8,0.91,-6.2),0.75,22)
	p("Scroll_1",Vector3(8.66,0.91,-6.42),1,40)
	p("Mug",Vector3(8.65,0.91,-5.90),0.85,22)
	p("Bucket_Metal",Vector3(8.65,0,-6.55),0.9,-8)
	p("Stool",Vector3(7.9,0,-6.37),1,14,true)
	p("Chain_Coil",Vector3(8.9,0.03,-7.60),0.8,0)
	lantern(Vector3(9.55,1.82,-7.67),-90)
	# Produce stall: actual filled crates, containers at varying working heights.
	p("Stall_Empty",Vector3(8.85,0,-3.35),1,-90,true)
	p("FarmCrate_Apple",Vector3(8.85,0.90,-2.94),0.90,-90)
	p("FarmCrate_Carrot",Vector3(8.85,0.90,-3.78),0.86,-90)
	p("Barrel_Apples",Vector3(8.72,0,-4.83),1,5,true)
	p("FarmCrate_Empty",Vector3(7.95,0,-4.35),1,-22,true)
	p("FarmCrate_Empty",Vector3(7.95,0.25,-4.35),0.95,-12)
	p("Bag",Vector3(9.15,0,-4.42),0.83,27,true)
	p("Bucket_Wooden_1",Vector3(8.03,0,-2.38),1,-12)
	p("Vase_2",Vector3(8.8,0,-1.84),0.75,5,true)
	p("Vase_4",Vector3(8.25,0,-1.78),1.1,-14,true)
	# Front-facing shipment stack makes the wall return readable on approach.
	p("Crate_Wooden",Vector3(7.3,0,0.0),1.05,4,true)
	p("Crate_Wooden",Vector3(8.33,0,-0.02),0.90,-6,true)
	p("Crate_Wooden",Vector3(7.32,0.98,-0.03),0.72,-12)
	p("Bag",Vector3(8.31,0.84,-0.02),0.72,13)
	p("Barrel",Vector3(9.2,0,0.10),1.08,5,true)
	p("Rope_2",Vector3(9.2,0.98,0.10),0.65,11)
	p("Vase_Rubble_Medium",Vector3(6.58,0,0.22),0.65,-19)
	lantern(Vector3(8.25,1.83,-0.65))
	source("props","Banner_1",Vector3(9.63,2.85,-8.42),Vector3.ONE*0.65,-90,false)
	v("Prop_Vine2",Vector3(9.45,2.95,-5.05),Vector3(0.6,1,0.7),-90,false)
	section("LocalGroundAndSettling")
	# Three bounded pads; untouched level beyond these remains a whitebox.
	for x in [-2.0,0.0,2.0]:
		for z in [-6.0,-4.0,-2.0]: v("Floor_UnevenBrick",Vector3(x,-0.007,z))
	for x in [-8.0,-6.0,-4.0]:
		for z in [-8.0,-6.0,-4.0,-2.0,0.0]: v("Floor_UnevenBrick",Vector3(x,-0.007,z))
	for x in [7.0,9.0]:
		for z in [-10.0,-8.0,-6.0,-4.0,-2.0,0.0]: v("Floor_UnevenBrick",Vector3(x,-0.007,z))
	# A few displaced stones at storage edges, never uniform noise on routes.
	for pair in [[-3.05,-4.7],[-3.2,-4.5],[2.8,-4.75],[-8.2,-7.8],[-8.7,-0.4],[6.3,0.1],[6.4,0.4],[9.0,-9.7]]:
		v("Prop_Brick%d" % (serial%4+1),Vector3(pair[0],0,pair[1]),Vector3.ONE*0.5,float(serial*31%360))
	var packed := PackedScene.new(); assert(packed.pack(art)==OK); assert(ResourceSaver.save(packed,DEST)==OK)
	print("Saved local sample: ",serial," source instances / practical lights")
	art.free(); quit()
