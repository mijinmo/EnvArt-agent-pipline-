extends "res://envart/tools/build_local_sample.gd"
const PH := "res://envart/assets/polyhaven/"
const OUT := "res://envart/realism_refined/"
var fort: Node3D
var foliage_materials := {}
func add_asset(id: String,pos: Vector3,scale_value:=1.0,yaw:=0.0,collision:=false) -> Node3D:
	var path:=PH+id+"/"+id+"_2k.gltf"
	if not library.has(path): library[path]=load(path)
	var n: Node3D=library[path].instantiate()
	place(n,pos,Vector3.ONE*scale_value,yaw,collision,path)
	return n
func place(n: Node3D,pos: Vector3,size: Vector3,yaw: float,collision: bool,path: String) -> void:
	var b:=bounds(n)
	n.name=n.name+"_%03d"%serial;serial+=1;group.add_child(n);n.owner=art
	var anchor:=Vector3(b.get_center().x,b.position.y,b.get_center().z)
	n.basis=Basis(Vector3.UP,deg_to_rad(yaw))*Basis.from_scale(size)
	n.position=pos-n.basis*anchor;n.set_meta("asset_source",path)
	if not n.scene_file_path.is_empty():art.set_editable_instance(n,true)
	for child in n.find_children("*","MeshInstance3D",true,false):
		if n.scene_file_path.is_empty():child.owner=art
		for surface in child.mesh.get_surface_count():
			var original: Material=child.get_active_material(surface)
			if not original is StandardMaterial3D:continue
			if not material_cache.has(original):
				var m: StandardMaterial3D=original.duplicate()
				m.texture_filter=BaseMaterial3D.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS_ANISOTROPIC
				m.albedo_color*=Color(0.78,0.80,0.77) if "fort" in path else Color(0.91,0.93,0.91)
				m.normal_scale=0.55 if "fort" in path else 0.8
				material_cache[original]=m
			child.set_surface_override_material(surface,material_cache[original])
	if collision:
		collision_box(n.name+"Footprint",pos+Vector3(0,b.size.y*size.y/2,0),b.size*size,Vector3(0,yaw,0))
func wall(piece: String,pos: Vector3,size: Vector3,yaw:=0.0) -> Node3D:
	var original: MeshInstance3D=fort.find_child("modular_fort_01_"+piece,true,false)
	assert(original!=null,piece)
	var n:=Node3D.new();n.name=piece
	var mesh:=MeshInstance3D.new();mesh.name="SourceMesh";mesh.mesh=shorten_gate(original.mesh) if piece in ["wall_thin_gate_01","wall_thin_straight_03"] else original.mesh;n.add_child(mesh)
	place(n,pos,size,yaw,false,PH+"modular_fort_01/modular_fort_01_2k.gltf#"+piece)
	return n
func save(root_node: Node3D,path: String) -> void:
	var packed:=PackedScene.new();assert(packed.pack(root_node)==OK);assert(ResourceSaver.save(packed,path)==OK)
func build() -> void:
	fort=load(PH+"modular_fort_01/modular_fort_01_2k.gltf").instantiate()
	art=Node3D.new();art.name="RealismTrialArt"
	section("StoneGate")
	# Original 1.2 m collision opening; source threshold sunk below ground.
	wall("wall_thin_gate_01",Vector3(0,-0.16,-4),Vector3(0.25,0.48,0.36),90)
	add_asset("wooden_crate_01",Vector3(-2.02,0,-4.15),1.25,-8,true)
	add_asset("wooden_crate_01",Vector3(-2.04,0.437,-4.14),1.12,6)
	add_asset("wine_barrel_01",Vector3(-2.88,0,-4.5),1.1,15,true)
	add_asset("wooden_bucket_02",Vector3(-2.55,0,-3.4),0.82,-17)
	add_asset("wine_barrel_01",Vector3(1.97,0,-4.18),1.05,-15,true)
	add_asset("wooden_lantern_01",Vector3(1.97,0.915,-4.18),0.82,8)
	add_asset("wooden_crate_01",Vector3(2.85,0,-4.1),1.18,8,true)
	section("StorehouseWalls")
	for z in [-8.5,-3.5]:wall("wall_thin_straight_01",Vector3(10,-0.05,z),Vector3(0.22,0.35,0.3375))
	wall("wall_thin_straight_03",Vector3(8,-0.05,-1),Vector3(0.22,0.54,0.54),90)
	for x in [-10.0,-6.0,-2.0,2.0,6.0,10.0]:wall("wall_thin_straight_04",Vector3(x,-0.06,-12),Vector3(0.24,0.54,0.54),90)
	section("CooperRepairBench")
	var table:=add_asset("small_wooden_table_01",Vector3(8.9,0,-6.3),1.65,90,true)
	var top:=bounds(table).size.y*1.65
	add_asset("wooden_lantern_01",Vector3(8.92,top,-6.65),0.85,15)
	var hammer:=add_asset("wooden_hammer_01",Vector3(8.75,top,-6.0),1.1,30)
	# Lay the hammer flat and ground its rotated bounds on the tabletop.
	var hb:=bounds(hammer);hammer.basis=Basis(Vector3.UP,0.5)*Basis(Vector3.RIGHT,PI/2)*Basis.from_scale(Vector3.ONE*1.1)
	var rotated: AABB=Transform3D(hammer.basis,Vector3.ZERO)*hb;hammer.position=Vector3(8.72,top,-6.0)-Vector3(rotated.get_center().x,rotated.position.y,rotated.get_center().z)
	add_asset("wooden_bucket_02",Vector3(8.9,0,-7.55),0.9,10)
	add_asset("wine_barrel_01",Vector3(9.1,0,-4.65),1.15,24,true)
	add_asset("wine_barrel_01",Vector3(8.2,0,-4.3),1.02,-16,true)
	add_asset("wooden_crate_02",Vector3(8.95,0,-3.1),1.1,82,true)
	add_asset("wooden_crate_01",Vector3(8.97,0.5104,-3.07),0.8,-8)
	section("DispatchGoods")
	for item in [[Vector3(7.85,0,-0.25),1.2,-13.0],[Vector3(9.0,0,-0.4),1.1,16.0],[Vector3(7.83,0.4195,-0.22),0.86,7.0]]:
		add_asset("wooden_crate_01",item[0],item[1],item[2],item[0].y==0)
	add_asset("wine_barrel_01",Vector3(9.25,0,0.6),1.1,12,true)
	add_asset("wooden_bucket_02",Vector3(7.1,0,0.15),0.8,-20)
	add_asset("wooden_lantern_01",Vector3(7.83,0.7202,-0.22),0.75,12)
	enrich_courtyard()
	section("PlayableCargoStacks")
	cargo_stack(Vector3(1,0,1),0.4,1)
	cargo_stack(Vector3(1,0,-1),0.9,2)
	cargo_stack(Vector3(3,0,-3),1.4,4)
	loose_cargo()
	harmonize_details()
	# Original gameplay envelopes are retained.
	save(art,OUT+"art.tscn");art.free()
	art=Node3D.new();art.name="TrialBackdrop";section("DistantFort")
	var context: Node3D=load("res://envart/local_sample/backdrop.tscn").instantiate()
	var hills: MeshInstance3D=context.get_node("ContinuousRollingHills").duplicate();art.add_child(hills);hills.owner=art
	context.free()
	wall("tower_round",Vector3(-18,-0.3,-34),Vector3.ONE*0.8)
	wall("tower_round",Vector3(18,-0.3,-34),Vector3.ONE*0.7)
	wall("wall_thin_straight_01",Vector3(0,-0.2,-35),Vector3(0.6,0.85,0.85),90)
	save(art,OUT+"backdrop.tscn");art.free();fort.free()
	var m:=StandardMaterial3D.new();var tex:=PH+"cobblestone_floor_03/cobblestone_floor_03_"
	m.albedo_texture=load(tex+"diff_2k.jpg");m.normal_enabled=true;m.normal_texture=load(tex+"nor_gl_2k.jpg");m.normal_scale=0.42;m.albedo_color=Color("b0b3a6");m.metallic_specular=0.25
	m.roughness_texture=load(tex+"arm_2k.jpg");m.roughness_texture_channel=BaseMaterial3D.TEXTURE_CHANNEL_GREEN
	m.ao_enabled=true;m.ao_texture=load(tex+"arm_2k.jpg");m.ao_texture_channel=BaseMaterial3D.TEXTURE_CHANNEL_RED
	m.uv1_triplanar=true;m.uv1_world_triplanar=true;m.uv1_scale=Vector3.ONE/2.4
	m.texture_filter=BaseMaterial3D.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS_ANISOTROPIC
	assert(ResourceSaver.save(m,OUT+"ground.tres")==OK)
	var scene: Node3D=load("res://envart/local_sample/local_sample.tscn").instantiate()
	scene.set_script(load(OUT+"trial.gd"));scene.name="PolyHavenTrial"
	for label in ["Art","Backdrop"]:
		scene.get_node(label).free();var n: Node3D=load(OUT+label.to_lower()+".tscn").instantiate();n.name=label;scene.add_child(n);n.owner=scene
	var env: Environment=scene.get_node("BaseLab/WorldEnvironment").environment.duplicate(true)
	env.ambient_light_energy=0.43;env.ambient_light_color=Color("a9c1d3");env.fog_density=0.0015;env.fog_light_color=Color("a0b2bf");env.ssao_intensity=1.35;env.ssao_radius=0.6;env.ssil_intensity=0.35
	scene.get_node("BaseLab/WorldEnvironment").environment=env
	var sun: DirectionalLight3D=scene.get_node("BaseLab/Sun");sun.rotation_degrees=Vector3(-33,-58,0);sun.light_color=Color("ffe4c4");sun.light_energy=1.05;sun.light_angular_distance=1.3
	save(scene,OUT+"trial.tscn");scene.free();print("REFINED REALISM BUILT: ",serial," placement operations (including wear overlays)");quit()

func shorten_gate(original: Mesh) -> ArrayMesh:
	# Retain the source arch and threshold; shorten only the oversized parapet.
	var result:=ArrayMesh.new()
	for surface in original.get_surface_count():
		var arrays:=original.surface_get_arrays(surface)
		var vertices: PackedVector3Array=arrays[Mesh.ARRAY_VERTEX]
		var normals: PackedVector3Array=arrays[Mesh.ARRAY_NORMAL]
		for i in vertices.size():
			if vertices[i].y>5.8:
				vertices[i].y=5.8+(vertices[i].y-5.8)*0.35
				normals[i]=Vector3(normals[i].x,normals[i].y/0.35,normals[i].z).normalized()
		arrays[Mesh.ARRAY_VERTEX]=vertices;arrays[Mesh.ARRAY_NORMAL]=normals
		result.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES,arrays)
		result.surface_set_material(surface,original.surface_get_material(surface))
	return result

func enrich_courtyard() -> void:
	section("GateGoodsAndIvy")
	p("Bag",Vector3(-1.65,0,-3.4),0.66,25,true)
	p("Bag",Vector3(-3.3,0,-3.82),0.8,-15,true)
	p("Rope_1",Vector3(-2.88,0.958,-4.5),0.8,20)
	p("Pouch_Large",Vector3(-2.08,0.829,-4.11),0.42,-12)
	p("Vase_2",Vector3(2.65,0,-4.85),0.95,16,true)
	p("Vase_4",Vector3(1.75,0,-3.45),0.9,-8,true)
	ivy_patch(Vector3(1.05,2.85,-3.62),0,4)
	ivy_patch(Vector3(-1.14,2.75,-3.61),0,2)
	section("CooperTools")
	p("Rope_1",Vector3(8.93,0.88,-6.17),0.54,15)
	p("Mug",Vector3(8.62,0.88,-6.65),0.78,0)
	p("SmallBottle",Vector3(9.05,0.88,-6.69),1.35,8)
	p("Book_5",Vector3(8.73,0.88,-6.9),0.85,20)
	p("Scroll_1",Vector3(8.80,0.88,-6.91),0.8,15)
	p("Stool",Vector3(7.9,0,-6.65),0.8,-8,true)
	p("Bag",Vector3(9.05,0,-5.23),0.65,8,true)
	p("Vase_4",Vector3(8.35,0,-7.72),1.0,10,true)
	source("props","Peg_Rack",Vector3(9.68,1.7,-6.3),Vector3.ONE*0.8,-90,false)
	var rope:=source("props","Rope_1",Vector3(9.56,1.50,-6.53),Vector3.ONE*0.58,-90,false)
	rope.rotate_object_local(Vector3.RIGHT,PI/2)
	ivy_patch(Vector3(9.67,2.72,-5.55),-90,5)
	ivy_patch(Vector3(9.67,2.75,-8.5),-90,3)
	section("DispatchDetails")
	p("Bag",Vector3(7.24,0,-0.42),0.88,24,true)
	p("Bag",Vector3(8.93,0.384,-0.32),0.58,-13)
	p("Rope_2",Vector3(9.25,0.958,0.6),0.7,15)
	p("Vase_2",Vector3(6.55,0,0.15),0.9,20,true)
	p("Vase_Rubble_Medium",Vector3(6.65,0,0.7),0.5,10)
	ivy_patch(Vector3(6.65,3.25,-0.65),0,4)
	ivy_patch(Vector3(8.9,3.25,-0.65),0,3)
	section("RampTimberGuards")
	for side in [-7.68,-4.32]:
		for z in [-1.0,-3.0,-5.0]:
			plank_rail(Vector3(side,(-z)/3.0+0.10,z),90,-18.43495,1.054)
	# Keep all vegetation outside the traversable opening and ramp.
	ground_vegetation()
	section("GroundWear")
	for data in [[-2.4,-4.15,1.4,1.05],[2.5,-4.4,1.4,1.0],[9.0,-6.4,1.1,2.2],[8.1,-0.25,2.0,1.0],[9.35,-3.5,0.55,2.0],[6.4,0.6,0.8,0.75]]:
		var n:=MeshInstance3D.new();n.name="EarthAtFooting";group.add_child(n);n.owner=art;n.position=Vector3(data[0],0.006+serial*0.000001,data[1]);serial+=1
		var plane:=PlaneMesh.new();plane.size=Vector2(data[2]*2,data[3]*2);n.mesh=plane
		var m:=ShaderMaterial.new();m.shader=load(OUT+"ground_wear.gdshader");n.material_override=m;n.cast_shadow=GeometryInstance3D.SHADOW_CASTING_SETTING_OFF

func ivy_patch(_pos: Vector3,_yaw: float,_count: int) -> void:
	pass # Retired: stylized climbing foliage conflicts with the PBR plants.

func harmonize_details() -> void:
	var leaf:=ShaderMaterial.new();leaf.shader=load(OUT+"ivy.gdshader")
	leaf.set_shader_parameter("leaf_mask",load("res://envart/assets/quaternius_village/T_VineLeaf_png.png"))
	for mesh in art.find_children("*","MeshInstance3D",true,false):
		for surface in mesh.mesh.get_surface_count():
			var original: Material=mesh.get_active_material(surface)
			if not original is StandardMaterial3D:continue
			if original.resource_name=="MI_Vine":mesh.set_surface_override_material(surface,leaf)
			elif "Bag" in str(mesh.get_parent().name) or "Pouch" in str(mesh.get_parent().name):
				var muted: StandardMaterial3D=original.duplicate();muted.albedo_color*=Color(0.57,0.62,0.64);muted.roughness=1.0
				mesh.set_surface_override_material(surface,muted)

func cargo_stack(center: Vector3,height: float,layers: int) -> void:
	# Large crossed cases replace the six-small-cases-per-row pattern.
	# Preserve landing height and central support; upper rows have slight overhang.
	var rows:=1 if layers==1 else 2
	var path:=PH+"wooden_crate_02/wooden_crate_02_2k.gltf"
	if not library.has(path):library[path]=load(path)
	for level in rows:
		for side in 2:
			var n: Node3D=library[path].instantiate();var b:=bounds(n)
			var yaw:=90.0 if level%2==1 else 0.0
			var offset:=Vector3(-0.375+side*0.75,level*height/rows,0)
			if level%2==1:
				offset=Vector3(0,offset.y,offset.x)
				var turn:=11.0 if height>1.0 else -8.0
				offset=Basis(Vector3.UP,deg_to_rad(turn))*offset+Vector3(0.04,0,-0.025)
				yaw+=turn
			place(n,center+offset,Vector3(0.75,height/rows,1.5)/b.size,yaw,false,path)
			var tints: Array[Color]=[Color(0.85,0.84,0.80),Color(0.95,0.91,0.84),Color(0.79,0.82,0.80),Color(0.91,0.88,0.82)]
			for m in n.find_children("*","MeshInstance3D",true,false):
				for surface in m.mesh.get_surface_count():
					var material: StandardMaterial3D=m.get_active_material(surface).duplicate()
					material.albedo_color*=tints[(level*2+side+int(center.z))%4]
					m.set_surface_override_material(surface,material)

func vegetation_clear(pos: Vector3) -> bool:
	for center in [Vector3(1,0,1),Vector3(1,0,-1),Vector3(3,0,-3)]:
		if absf(pos.x-center.x)<0.85 and absf(pos.z-center.z)<0.85:return false
	return super(pos)

func part(id: String,piece: String,pos: Vector3,scale_value:=1.0,yaw:=0.0) -> Node3D:
	var path:=PH+id+"/"+id+"_2k.gltf"
	if not library.has(path):library[path]=load(path)
	var source_root: Node3D=library[path].instantiate()
	var original: MeshInstance3D=source_root.find_child(piece,true,false)
	assert(original!=null,piece)
	var n:=Node3D.new();n.name=piece
	var mesh:=MeshInstance3D.new();mesh.name="SourceMesh";mesh.mesh=original.mesh;n.add_child(mesh)
	place(n,pos,Vector3.ONE*scale_value,yaw,false,path+"#"+piece)
	if id in ["fern_02","weed_plant_02","nettle_plant"]:
		if not foliage_materials.has(id):
			var m:=ShaderMaterial.new();m.shader=load(OUT+"foliage.gdshader")
			var prefix:=PH+id+"/textures/"+id
			for channel in {"leaf_color":"diff","leaf_alpha":"alpha","leaf_normal":"nor_gl","leaf_arm":"arm"}:
				var suffix: String={"leaf_color":"diff","leaf_alpha":"alpha","leaf_normal":"nor_gl","leaf_arm":"arm"}[channel]
				m.set_shader_parameter(channel,load(prefix+"_"+suffix+"_2k.jpg"))
			foliage_materials[id]=m
		mesh.material_override=foliage_materials[id]

	source_root.free();return n

func ground_vegetation() -> void:
	section("PBR_FootingPlants")
	var random:=RandomNumberGenerator.new();random.seed=20261113
	var anchors: Array[Vector3]=[Vector3(-3.25,0,-4.75),Vector3(2.8,0,-5.1),Vector3(9.35,0,-7.75),Vector3(9.45,0,-5.15),Vector3(6.3,0,0.75),Vector3(9.55,0,1.1),Vector3(-7.95,0,-6.0),Vector3(-4.05,0,-8.2),Vector3(9.5,0,-10.8),Vector3(-7.9,0,-1.1)]
	for i in anchors.size():
		part("fern_02","fern_02_"+["a","b","c","d"][i%4],anchors[i],random.randf_range(0.65,0.95),random.randf_range(-180,180))
		for j in 7:
			var pos:=anchors[i]+Vector3(random.randf_range(-0.65,0.65),0.007,random.randf_range(-0.45,0.45))
			if not vegetation_clear(pos):continue
			part("weed_plant_02","weed_plant_02_"+["a","b","c","d","e"][j%5]+"_LOD0",pos,random.randf_range(0.85,1.5),random.randf_range(-180,180))
		for j in 2:
			var pos:=anchors[i]+Vector3(random.randf_range(-0.3,0.3),0.005,random.randf_range(-0.3,0.3))
			if vegetation_clear(pos):part("nettle_plant","nettle_plant_tall_"+("a" if j==0 else "b")+"_LOD0",pos,random.randf_range(0.8,1.5),random.randf_range(-180,180))
	for x in [-10.1,-6.4,-2.3,4.5,8.8]:part("fern_02","fern_02_c",Vector3(x,0,-11.45),0.9,x*17)

func loose_cargo() -> void:
	section("CooperRepairStock")
	# Loose real barrel staves and an open case break up the closed-box rhythm.
	part("wooden_barrels_01","wooden_barrels_01_piece01",Vector3(8.15,0,-3.5),0.9,-31)
	part("wooden_barrels_01","wooden_barrels_01_piece02",Vector3(8.15,0,-5.15),0.7,17)
	part("wooden_barrels_01","wooden_barrels_01_piece04",Vector3(8.1,0.015,-3.9),0.9,41)
	part("wooden_barrels_01","wooden_barrels_01_piece05",Vector3(8.4,0.015,-3.8),0.9,29)
	part("wooden_barrels_01","wooden_barrels_01_piece08",Vector3(9.0,0.88,-6.05),0.4,8)
	var open_case:=part("wooden_crate_02","wooden_crate_02_crate",Vector3(6.9,0,0.8),0.95,27)
	var b:=bounds(open_case);collision_box("OpenCaseFootprint",Vector3(6.9,b.size.y*0.95/2,0.8),b.size*0.95,Vector3(0,27,0))
	var lid:=part("wooden_crate_02","wooden_crate_02_lid",Vector3(7.55,0,1.1),0.95,-12)
	lid.rotation_degrees.z=68
	var lb: AABB=Transform3D(lid.basis,Vector3.ZERO)*bounds(lid)
	lid.position=Vector3(7.55,0,0.9)-Vector3(lb.get_center().x,lb.position.y,lb.get_center().z)
	add_asset("wooden_crate_01",Vector3(4.5,0,-3.55),0.9,-22,true)
	part("wooden_barrels_01","wooden_barrels_01_piece03",Vector3(4.45,0,-2.7),0.8,12)
