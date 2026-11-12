extends "res://envart/tools/build_local_sample.gd"
## Deterministic scenic ring. Imported modular architecture + procedural landforms.
## No collision, no near-field geometry and no runtime generator.
var config: Resource
var noise := FastNoiseLite.new()
var random := RandomNumberGenerator.new()
var pads: Array[Vector3] = []
var tree_locations: Array[Transform3D] = []
var house_specs := [Vector3(-28,15,-33),Vector3(-16,-12,-37),Vector3(-2,8,-39),Vector3(13,-18,-35),Vector3(27,25,-32),Vector3(35,-60,-17),Vector3(32,-75,0),Vector3(-34,65,-17),Vector3(-36,70,1),Vector3(19,160,36),Vector3(-24,190,37)]
func raw_height(x: float, z: float) -> float:
	var r := Vector2(x,z).length()
	var rise := smoothstep(17.0,38.0,maxf(absf(x),absf(z)))
	var low := 2.5 + 5.0*(noise.get_noise_2d(x,z)+0.5)
	var mountains := 0.0
	for peak in [Vector4(-80,-100,46,48),Vector4(85,-133,61,58),Vector4(150,35,40,60),Vector4(-155,50,36,55),Vector4(10,160,36,60)]:
		mountains += peak.z*exp(-Vector2(x-peak.x,z-peak.y).length_squared()/(peak.w*peak.w))
	return -0.5 + rise*(low+mountains*smoothstep(38,100,r)*(0.8+noise.get_noise_2d(x*1.8,z*1.8)*0.35))*config.hill_height_scale
func height_at(x: float,z: float) -> float:
	var h := raw_height(x,z)
	for pad in pads:
		var distance := Vector2(x-pad.x,z-pad.z).length()
		if distance < 7: h=lerpf(pad.y,h,smoothstep(3.4,7.0,distance))
	return h
func add_owned(node: Node, parent: Node = null) -> void:
	if parent==null: parent=art
	parent.add_child(node); node.owner=art
func build() -> void:
	if DisplayServer.get_name() == "headless":
		push_error("Backdrop baking requires a graphical backend for MultiMesh serialization. Run without --headless.")
		quit(1); return
	config=load("res://envart/local_sample/backdrop_config.tres")
	random.seed=config.seed_value; noise.seed=config.seed_value; noise.frequency=0.012; noise.fractal_octaves=4
	art=Node3D.new(); art.name="ProceduralBackdrop"; art.set_meta("seed",config.seed_value); art.set_meta("non_playable",true)
	for i in house_specs.size():
		house_specs[i].x *= 1.45; house_specs[i].z *= 1.45
	for spec in house_specs: pads.append(Vector3(spec.x,raw_height(spec.x,spec.z),spec.z))
	terrain()
	for i in house_specs.size(): house(i)
	trees()
	var packed:=PackedScene.new(); assert(packed.pack(art)==OK)
	assert(ResourceSaver.save(packed,"res://envart/local_sample/backdrop.tscn")==OK)
	print("BACKDROP: ",house_specs.size()," houses / ",tree_locations.size()," trees / seed ",config.seed_value)
	art.free(); quit()
func terrain() -> void:
	var surface:=SurfaceTool.new(); surface.begin(Mesh.PRIMITIVE_TRIANGLES)
	var count:=int(config.terrain_extent*2/config.terrain_grid_step)
	for iz in count+1:
		for ix in count+1:
			var x: float=-config.terrain_extent+ix*config.terrain_grid_step
			var z: float=-config.terrain_extent+iz*config.terrain_grid_step
			var h:=height_at(x,z)
			var dx:=height_at(x+0.4,z)-height_at(x-0.4,z); var dz:=height_at(x,z+0.4)-height_at(x,z-0.4)
			var normal:=Vector3(-dx,0.8,-dz).normalized()
			var far:=smoothstep(50,180,Vector2(x,z).length())
			var color: Color=config.near_grass.lerp(config.far_grass,far)
			var crag:=smoothstep(0.20,0.65,1.0-normal.y)+smoothstep(35,65,h)*0.45
			color=color.lerp(config.rock_color,clampf(crag,0,0.8))
			color=color.lightened(noise.get_noise_2d(x*2.1,z*2.1)*0.12)
			surface.set_color(color.srgb_to_linear()); surface.set_normal(normal); surface.add_vertex(Vector3(x,h,z))
	for iz in count:
		for ix in count:
			var x: float=-config.terrain_extent+(ix+0.5)*config.terrain_grid_step
			var z: float=-config.terrain_extent+(iz+0.5)*config.terrain_grid_step
			if absf(x)<18 and absf(z)<18: continue
			var a:=iz*(count+1)+ix; var b:=a+1; var c:=a+count+1; var d:=c+1
			for index in [a,b,c,b,d,c]: surface.add_index(index)
	var mesh:=MeshInstance3D.new(); mesh.name="ContinuousRollingHills"; mesh.mesh=surface.commit()
	var mat:=ShaderMaterial.new(); mat.shader=load("res://envart/local_sample/hills.gdshader")
	mesh.material_override=mat; add_owned(mesh)
func house(index: int) -> void:
	var spec: Vector3=house_specs[index]
	group=Node3D.new(); group.name="VillageHouse_%02d"%index; add_owned(group)
	group.position=pads[index]-Vector3(0,0.05,0); group.rotation.y=deg_to_rad(spec.y)
	var size:=random.randf_range(0.86,1.16); group.scale=Vector3.ONE*size
	var floors:=3 if index==3 else (1 if index%3==0 else 2)
	for floor_index in floors:
		for side in 4:
			var basis:=Basis(Vector3.UP,side*PI/2)
			for bay in [-1.0,1.0]:
				var pos:=basis*Vector3(bay,floor_index*3.0,2)
				var model: String="Wall_UnevenBrick_Straight" if floor_index==0 else "Wall_Plaster_Straight"
				if floor_index>0: model="Wall_Plaster_Window_Wide_Flat"
				if floor_index==0 and side==0 and bay<0: model="Wall_UnevenBrick_Door_Flat"
				v(model,pos,Vector3.ONE,side*90.0,false)
				if floor_index>0:
					v("Window_Wide_Flat1",pos,Vector3.ONE,side*90.0,false)
					if index%2==0: v("WindowShutters_Wide_Flat_Open",pos,Vector3.ONE,side*90.0,false)
				elif side==0 and bay<0:
					v("Door_1_Flat",pos,Vector3.ONE,0,false)
			v("Corner_Exterior_Wood",basis*Vector3(1.96,floor_index*3.0,1.96),Vector3.ONE,side*90.0,false)
	var top: float=floors*3.0
	if index==3:
		v("Roof_Tower_RoundTiles",Vector3(0,top,0),Vector3.ONE,0,false)
	else:
		v("Roof_RoundTiles_4x4",Vector3(0,top,0),Vector3.ONE,0,false)
		v("Roof_Front_Brick4",Vector3(0,top,2.0),Vector3.ONE,0,false)
		v("Roof_Front_Brick4",Vector3(0,top,-2.0),Vector3.ONE,180,false)
		v("Prop_Chimney",Vector3(1.1,top+0.8,-0.6),Vector3(0.8,1,0.8),0,false)
func trees() -> void:
	# Three real tree meshes retain their bark and alpha-cut leaf materials.
	var meshes: Array[Mesh] = []
	var heights: Array[float] = []
	for model in ["CommonTree_1","CommonTree_3","Pine_1"]:
		var original: Node3D=load("res://envart/assets/quaternius_nature/"+model+".gltf").instantiate()
		var source_mesh: MeshInstance3D=original.find_children("*","MeshInstance3D",true,false)[0]
		var mesh: ArrayMesh=source_mesh.mesh.duplicate()
		for i in mesh.get_surface_count():
			var mat: StandardMaterial3D=source_mesh.get_active_material(i).duplicate()
			mat.vertex_color_use_as_albedo=true; mat.roughness=1.0
			mat.texture_filter=BaseMaterial3D.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS_ANISOTROPIC
			if "Leaves" in mat.resource_name: mat.albedo_color *= Color(0.70,0.80,0.62)
			mesh.surface_set_material(i,mat)
		meshes.append(mesh); heights.append(mesh.get_aabb().size.y); original.free()
	var cells: Dictionary={}
	var attempts:=0
	while tree_locations.size()<config.tree_count and attempts<config.tree_count*20:
		attempts+=1
		var angle:=random.randf_range(0,TAU); var radius:=random.randf_range(25,165)
		var x:=cos(angle)*radius; var z:=sin(angle)*radius
		if absf(x)<20 and absf(z)<20: continue
		var blocked:=false
		for pad in pads:
			if Vector2(x-pad.x,z-pad.z).length()<6.5: blocked=true
		if blocked or noise.get_noise_2d(x*2,z*2)<-0.18: continue
		var h:=height_at(x,z); var slope:=absf(height_at(x+1,z)-h)+absf(height_at(x,z+1)-h)
		if slope>1.6: continue
		var kind := random.randi_range(0,2)
		var scale_value:=random.randf_range(5.0,10.0)/heights[kind]
		var pose:=Transform3D(Basis(Vector3.UP,random.randf_range(0,TAU)).scaled(Vector3(scale_value*random.randf_range(0.75,1.1),scale_value,scale_value)),Vector3(x,h-0.10,z))
		tree_locations.append(pose)
		var key:=Vector3i(floori(x/40),kind,floori(z/40))
		if not cells.has(key): cells[key]=[]
		cells[key].append(pose)
	for key in cells:
		var mm:=MultiMesh.new(); mm.transform_format=MultiMesh.TRANSFORM_3D; mm.use_colors=true; mm.mesh=meshes[key.y]; mm.instance_count=cells[key].size()
		for i in mm.instance_count:
			mm.set_instance_transform(i,cells[key][i]); mm.set_instance_color(i,Color(0.84,0.92,0.78).lerp(Color.WHITE,random.randf()))
		var inst:=MultiMeshInstance3D.new(); inst.name="Forest_%d_%d_%d"%[key.x,key.y,key.z]; inst.multimesh=mm
		inst.cast_shadow=GeometryInstance3D.SHADOW_CASTING_SETTING_OFF; add_owned(inst)
