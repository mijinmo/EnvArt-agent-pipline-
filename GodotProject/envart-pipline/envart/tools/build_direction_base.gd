extends "res://envart/tools/build_local_sample.gd"
## Shared source-instance assembly for the two new direction studies.
var direction := "ashen"
var terrain_vertices := PackedVector3Array()
func asset(pack: String, model: String, pos: Vector3, size := Vector3.ONE, yaw := 0.0, collision := false, center := true) -> Node3D:
	var path := "res://envart/assets/"+pack+"/"+model+(".glb" if pack=="kaykit_dungeon" else ".gltf")
	if not library.has(path): library[path]=load(path)
	var n: Node3D=library[path].instantiate(); var b:=bounds(n)
	n.name=model+"_%04d"%serial; serial+=1; group.add_child(n); n.owner=art
	n.basis=Basis(Vector3.UP,deg_to_rad(yaw))*Basis.from_scale(size)
	var anchor:=Vector3(b.get_center().x,b.position.y,b.get_center().z) if center else Vector3.ZERO
	n.position=pos-n.basis*anchor; n.set_meta("asset_source",path)
	art.set_editable_instance(n,true)
	for mesh in n.find_children("*","MeshInstance3D",true,false):
		for surface in mesh.mesh.get_surface_count():
			var original: Material=mesh.get_active_material(surface)
			if not original is StandardMaterial3D: continue
			var stone_asset:=pack=="kaykit_dungeon" and (model.begins_with("wall") or model.begins_with("pillar") or model.begins_with("column") or model.begins_with("barrier") or model.begins_with("floor_tile"))
			var key:=str(original.get_instance_id())+str(stone_asset)
			if not material_cache.has(key):
				if stone_asset:
					var weather:=ShaderMaterial.new(); weather.shader=load("res://envart/direction_studies/weathered.gdshader")
					weather.set_shader_parameter("source_color_tex",original.albedo_texture); material_cache[key]=weather
				else:
					var m: StandardMaterial3D=original.duplicate(); m.normal_scale=0.3
					m.texture_filter=BaseMaterial3D.TEXTURE_FILTER_LINEAR_WITH_MIPMAPS_ANISOTROPIC
					if "Vertex" in m.resource_name: m.vertex_color_use_as_albedo=true
					if direction=="ashen":
						m.albedo_color*=Color(0.58,0.56,0.53); m.roughness=0.9
					else:
						m.metallic=0.16; m.metallic_texture=null; m.roughness=0.78; m.roughness_texture=null; m.normal_scale=0.18
						if m.resource_name=="MI_Trim_01": m.albedo_texture=load("res://envart/assets/quaternius_scifi/T_Trim_01_BaseColor.png")
						if m.resource_name=="MI_Trim_02":
							m.albedo_texture=load("res://envart/assets/quaternius_scifi_props/T_Trim_02_BaseColor.png")
							m.albedo_color*=Color(0.62,0.85,0.88)
						m.albedo_color*=Color(0.9,0.95,1.0)
					material_cache[key]=m
			mesh.set_surface_override_material(surface,material_cache[key])
	if collision:
		var body:=StaticBody3D.new(); body.name=n.name+"_Footprint"; group.add_child(body); body.owner=art
		body.collision_layer=1;body.collision_mask=2
		body.transform=Transform3D(Basis(Vector3.UP,deg_to_rad(yaw)),pos)
		var shape:=CollisionShape3D.new();body.add_child(shape);shape.owner=art
		var box:=BoxShape3D.new();box.size=b.size*size;shape.shape=box
		shape.position=(b.get_center()-anchor)*size
	return n
func k(model: String,pos: Vector3,scale_value:=1.0,yaw:=0.0,collision:=false) -> Node3D:
	return asset("kaykit_dungeon",model,pos,Vector3.ONE*scale_value,yaw,collision)
func s(model: String,pos: Vector3,size:=Vector3.ONE,yaw:=0.0,collision:=false) -> Node3D:
	return asset("quaternius_scifi",model,pos,size,yaw,collision)
func e(model: String,pos: Vector3,scale_value:=1.0,yaw:=0.0,collision:=false) -> Node3D:
	return asset("quaternius_scifi_props",model,pos,Vector3.ONE*scale_value,yaw,collision)
func point_light(pos: Vector3,color: Color,power:=1.0,radius:=4.0) -> void:
	var l:=OmniLight3D.new();group.add_child(l);l.owner=art;l.position=pos;l.light_color=color;l.light_energy=power;l.omni_range=radius;l.shadow_enabled=true
func glow_material(color: Color) -> StandardMaterial3D:
	var m:=StandardMaterial3D.new();m.albedo_color=color;m.emission_enabled=true;m.emission=color;m.emission_energy_multiplier=1.5;return m
func label3(text: String,pos: Vector3,yaw: float,color: Color,size:=42) -> void:
	var label:=Label3D.new();label.text=text;label.position=pos;label.rotation_degrees.y=yaw;label.font_size=size;label.pixel_size=0.006;label.modulate=color;label.outline_size=3
	group.add_child(label);label.owner=art
func save_scene(filename: String,root_node: Node3D) -> void:
	var packed:=PackedScene.new();assert(packed.pack(root_node)==OK)
	assert(ResourceSaver.save(packed,"res://envart/direction_studies/"+filename+".tscn")==OK)
func begin_backdrop() -> void:
	save_scene(direction+"_art",art); print(direction," near source instances: ",serial)
	art.free();art=Node3D.new();art.name=direction.capitalize()+"Backdrop"
func finish() -> void:
	save_scene(direction+"_backdrop",art);art.free();print("Saved ",direction," art and backdrop");quit()
func ash_terrain() -> void:
	var reference: Node3D=load("res://envart/local_sample/backdrop.tscn").instantiate()
	var n:=MeshInstance3D.new();n.name="AshenHills";n.mesh=reference.get_node("ContinuousRollingHills").mesh
	var m:=ShaderMaterial.new();m.shader=load("res://envart/direction_studies/ash_terrain.gdshader");n.material_override=m
	terrain_vertices=n.mesh.surface_get_arrays(0)[Mesh.ARRAY_VERTEX]
	group.add_child(n);n.owner=art;reference.free()

func terrain_height(x: float,z: float) -> float:
	# Sample the baked terrain triangles, including flattened village pads.
	var config: EABackdropConfig=load("res://envart/local_sample/backdrop_config.tres")
	var cells:=int(config.terrain_extent*2/config.terrain_grid_step)
	var gx: float=(x+config.terrain_extent)/config.terrain_grid_step
	var gz: float=(z+config.terrain_extent)/config.terrain_grid_step
	var ix:=clampi(floori(gx),0,cells-1);var iz:=clampi(floori(gz),0,cells-1)
	var u:=gx-ix;var v:=gz-iz;var a:=iz*(cells+1)+ix
	if u+v<=1: return terrain_vertices[a].y*(1-u-v)+terrain_vertices[a+1].y*u+terrain_vertices[a+cells+1].y*v
	return terrain_vertices[a+cells+2].y*(u+v-1)+terrain_vertices[a+1].y*(1-v)+terrain_vertices[a+cells+1].y*(1-u)
