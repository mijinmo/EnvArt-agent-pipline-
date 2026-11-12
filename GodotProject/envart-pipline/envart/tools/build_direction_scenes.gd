extends SceneTree
func _initialize() -> void:
	for direction in ["ashen","facility"]:
		if not ResourceLoader.exists("res://envart/direction_studies/"+direction+"_art.tscn"):continue
		var scene: Node3D=load("res://envart/local_sample/local_sample.tscn").instantiate()
		scene.set_script(load("res://envart/direction_studies/variant.gd"));scene.art_direction=0 if direction=="ashen" else 1
		for name in ["Art","Backdrop"]:
			scene.get_node(name).free()
			var path: String="res://envart/direction_studies/"+direction+("_art.tscn" if name=="Art" else "_backdrop.tscn")
			var n: Node3D=load(path).instantiate();n.name=name;scene.add_child(n);n.owner=scene
		var lab:=scene.get_node("BaseLab")
		var env:=Environment.new();var sky:=Sky.new();var sky_mat:=ProceduralSkyMaterial.new()
		sky_mat.sky_top_color=Color("354451") if direction=="ashen" else Color("68889b")
		sky_mat.sky_horizon_color=Color("929da5") if direction=="ashen" else Color("c2d4dc")
		sky_mat.ground_horizon_color=sky_mat.sky_horizon_color;sky_mat.ground_bottom_color=Color("303942")
		sky.sky_material=sky_mat;env.background_mode=Environment.BG_SKY;env.sky=sky
		env.ambient_light_source=Environment.AMBIENT_SOURCE_COLOR;env.ambient_light_color=Color("b4c3d4");env.ambient_light_energy=0.55 if direction=="ashen" else 0.7
		env.tonemap_mode=Environment.TONE_MAPPER_FILMIC;env.ssao_enabled=true;env.ssao_radius=1.1;env.ssao_intensity=1.4;env.ssil_enabled=true;env.ssil_intensity=0.5
		env.fog_enabled=true;env.fog_density=0.007 if direction=="ashen" else 0.0025;env.fog_light_color=sky_mat.sky_horizon_color
		lab.get_node("WorldEnvironment").environment=env
		var sun: DirectionalLight3D=lab.get_node("Sun");sun.rotation_degrees=Vector3(-32,-40,0) if direction=="ashen" else Vector3(-48,-30,0)
		sun.light_color=Color("c1cfe0") if direction=="ashen" else Color("e0edfa");sun.light_energy=0.95 if direction=="ashen" else 1.15
		var packed:=PackedScene.new();assert(packed.pack(scene)==OK)
		assert(ResourceSaver.save(packed,"res://envart/direction_studies/"+direction+".tscn")==OK);scene.free()
	quit()
