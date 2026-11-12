extends SceneTree
func _initialize():
	var scene := Node3D.new(); scene.name="LocalAssetSample"; scene.set_script(load("res://envart/local_sample/sample.gd"))
	var base: Node3D = load("res://demo/controller_lab.tscn").instantiate(); base.name="BaseLab"; scene.add_child(base); base.owner=scene
	scene.set_editable_instance(base,true)
	var art: Node3D=load("res://envart/local_sample/art.tscn").instantiate(); art.name="Art"; scene.add_child(art); art.owner=scene
	var env := Environment.new(); var sky:=Sky.new(); var sky_mat:=ProceduralSkyMaterial.new()
	sky_mat.sky_top_color=Color("66889f"); sky_mat.sky_horizon_color=Color("d3d8cf"); sky_mat.ground_horizon_color=Color("c4c6b9"); sky_mat.ground_bottom_color=Color("7c826e"); sky.sky_material=sky_mat
	env.background_mode=Environment.BG_SKY; env.sky=sky; env.ambient_light_source=Environment.AMBIENT_SOURCE_COLOR; env.ambient_light_color=Color("bfd4e1"); env.ambient_light_energy=0.5
	env.tonemap_mode=Environment.TONE_MAPPER_FILMIC; env.ssao_enabled=true; env.ssao_radius=0.8; env.ssao_intensity=1.6; env.ssil_enabled=true; env.ssil_intensity=0.6
	base.get_node("WorldEnvironment").environment=env
	var sun: DirectionalLight3D=base.get_node("Sun"); sun.rotation_degrees=Vector3(-40,-38,0); sun.light_color=Color("ffefd7"); sun.light_energy=1.15; sun.shadow_enabled=true
	var views:=Node3D.new(); views.name="ReviewViews"; scene.add_child(views); views.owner=scene
	var poses := [["Door",Vector3(-3.40,2.55,0.9),Vector3(-0.15,1.75,-4.0)], ["Ramp",Vector3(-1.5,3.5,1.6),Vector3(-6,1.3,-3.8)], ["Props",Vector3(4.5,2.7,-8.3),Vector3(8.8,1.25,-4.4)]]
	for pose in poses:
		var marker:=Marker3D.new(); marker.name=pose[0]; views.add_child(marker); marker.owner=scene; marker.position=pose[1]; marker.basis=Basis.looking_at(pose[2]-pose[1])
	var hud:=CanvasLayer.new(); hud.name="HUD"; scene.add_child(hud); hud.owner=scene; hud.layer=2
	var hint:=Label.new(); hint.name="Hint"; hud.add_child(hint); hint.owner=scene; hint.position=Vector2(22,20); hint.add_theme_font_size_override("font_size",16); hint.add_theme_color_override("font_shadow_color",Color(0,0,0,0.9)); hint.add_theme_constant_override("shadow_offset_x",2); hint.add_theme_constant_override("shadow_offset_y",2)
	var packed:=PackedScene.new(); assert(packed.pack(scene)==OK); assert(ResourceSaver.save(packed,"res://envart/local_sample/local_sample.tscn")==OK); scene.free(); quit()
