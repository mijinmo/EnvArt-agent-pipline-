extends "res://envart/tools/build_local_sample.gd"
const PH := "res://envart/assets/polyhaven/"
const OUT := "res://envart/realism_trial/"
var fort: Node3D
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
				material_cache[original]=m
			child.set_surface_override_material(surface,material_cache[original])
	if collision:
		collision_box(n.name+"Footprint",pos+Vector3(0,b.size.y*size.y/2,0),b.size*size,Vector3(0,yaw,0))
func wall(piece: String,pos: Vector3,size: Vector3,yaw:=0.0) -> Node3D:
	var original: MeshInstance3D=fort.find_child("modular_fort_01_"+piece,true,false)
	assert(original!=null,piece)
	var n:=Node3D.new();n.name=piece
	var mesh:=MeshInstance3D.new();mesh.name="SourceMesh";mesh.mesh=original.mesh;n.add_child(mesh)
	place(n,pos,size,yaw,false,PH+"modular_fort_01/modular_fort_01_2k.gltf#"+piece)
	return n
func save(root_node: Node3D,path: String) -> void:
	var packed:=PackedScene.new();assert(packed.pack(root_node)==OK);assert(ResourceSaver.save(packed,path)==OK)
func build() -> void:
	fort=load(PH+"modular_fort_01/modular_fort_01_2k.gltf").instantiate()
	art=Node3D.new();art.name="RealismTrialArt"
	section("StoneGate")
	# Original 1.2 m collision opening; source threshold sunk below ground.
	wall("wall_thin_gate_01",Vector3(0,-0.16,-4),Vector3(0.25,0.55,0.36),90)
	add_asset("wooden_crate_01",Vector3(-2.02,0,-4.15),1.25,-8,true)
	add_asset("wooden_crate_01",Vector3(-2.04,0.437,-4.14),1.12,6)
	add_asset("wine_barrel_01",Vector3(-2.88,0,-4.5),1.1,15,true)
	add_asset("wooden_bucket_02",Vector3(-2.55,0,-3.4),0.82,-17)
	add_asset("wine_barrel_01",Vector3(1.97,0,-4.18),1.05,-15,true)
	add_asset("wooden_lantern_01",Vector3(1.97,0.915,-4.18),0.82,8)
	add_asset("wooden_crate_01",Vector3(2.85,0,-4.1),1.18,8,true)
	add_asset("wooden_bucket_02",Vector3(2.55,0,-3.35),0.9,35)
	section("StorehouseWalls")
	wall("wall_thin_straight_01",Vector3(10,-0.05,-6),Vector3(0.22,0.355,0.675))
	wall("wall_thin_straight_03",Vector3(8,-0.05,-1),Vector3(0.22,0.39,0.54),90)
	for x in [-6.0,6.0]:wall("wall_thin_straight_02",Vector3(x,-0.06,-12),Vector3(0.24,0.47,0.81),90)
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
	add_asset("wooden_crate_01",Vector3(8.95,0,-3.1),1.2,-10,true)
	add_asset("wooden_crate_01",Vector3(8.98,0.4195,-3.1),1.1,6)
	section("DispatchGoods")
	for item in [[Vector3(7.9,0,-0.35),1.2,-5.0],[Vector3(8.9,0,-0.32),1.1,8.0],[Vector3(7.92,0.4195,-0.35),1.08,2.0]]:
		add_asset("wooden_crate_01",item[0],item[1],item[2],item[0].y==0)
	add_asset("wine_barrel_01",Vector3(9.25,0,0.6),1.1,12,true)
	add_asset("wooden_bucket_02",Vector3(7.1,0,0.15),0.8,-20)
	add_asset("wooden_lantern_01",Vector3(7.92,0.797,-0.35),0.75,12)
	# Ramp stays the original test geometry, with the same PBR paving as the ground.
	save(art,OUT+"art.tscn");art.free()
	art=Node3D.new();art.name="TrialBackdrop";section("DistantFort")
	wall("tower_round",Vector3(-18,-0.3,-34),Vector3.ONE*0.8)
	wall("tower_round",Vector3(18,-0.3,-34),Vector3.ONE*0.7)
	wall("wall_thin_straight_01",Vector3(0,-0.2,-35),Vector3(0.6,0.85,2.0),90)
	save(art,OUT+"backdrop.tscn");art.free();fort.free()
	var m:=StandardMaterial3D.new();var tex:=PH+"cobblestone_floor_03/cobblestone_floor_03_"
	m.albedo_texture=load(tex+"diff_2k.jpg");m.normal_enabled=true;m.normal_texture=load(tex+"nor_gl_2k.jpg");m.normal_scale=0.7
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
	env.ambient_light_energy=0.65;env.ambient_light_color=Color("cbd8e1");env.fog_density=0.002;env.ssao_intensity=1.15
	scene.get_node("BaseLab/WorldEnvironment").environment=env
	var sun: DirectionalLight3D=scene.get_node("BaseLab/Sun");sun.rotation_degrees=Vector3(-42,-35,0);sun.light_color=Color("fff0dc");sun.light_energy=1.25
	save(scene,OUT+"trial.tscn");scene.free();print("REALISM TRIAL BUILT: ",serial," source placements");quit()
