extends SceneTree
const Helpers = preload("res://asset_helpers.gd")
var h = Helpers.new()
var r: Node3D
var mats := {}
var rng := RandomNumberGenerator.new()

func _initialize() -> void: call_deferred("build")

func group(label: String) -> Node3D:
	var n := Node3D.new()
	n.name = label
	r.add_child(n)
	return n

func color_mat(color: String, rough := 0.8, metal := 0.0) -> StandardMaterial3D:
	var m := StandardMaterial3D.new()
	m.albedo_color = Color(color)
	m.roughness = rough
	m.metallic = metal
	return m

func mesh(parent: Node3D, label: String, shape: Mesh, pos: Vector3, mat: Material) -> MeshInstance3D:
	var n := MeshInstance3D.new()
	n.name = label
	n.mesh = shape
	n.position = pos
	n.material_override = mat
	parent.add_child(n)
	return n

func box(parent: Node3D,label: String,pos: Vector3,size: Vector3,mat: Material) -> MeshInstance3D:
	var shape := BoxMesh.new()
	shape.size = size
	return mesh(parent,label,shape,pos,mat)

func beam(parent: Node3D,label: String,a: Vector3,b: Vector3,radius: float,mat: Material) -> void:
	var shape := CylinderMesh.new()
	shape.top_radius = radius
	shape.bottom_radius = radius
	shape.height = a.distance_to(b)
	shape.radial_segments = 8
	var n := mesh(parent,label,shape,(a+b)*0.5,mat)
	var direction := (b-a).normalized()
	if absf(direction.dot(Vector3.UP))<0.999: n.basis = Basis(Quaternion(Vector3.UP,direction))

func collision(parent: Node3D,label: String,pos: Vector3,size: Vector3) -> void:
	var n := StaticBody3D.new()
	n.name = label
	n.position = pos
	parent.add_child(n)
	var s := CollisionShape3D.new()
	s.shape = BoxShape3D.new()
	s.shape.size = size
	n.add_child(s)

func recolor(n: Node, repaint: bool, tint: Color) -> void:
	if n is MeshInstance3D:
		for i in n.mesh.get_surface_count():
			var old = n.get_active_material(i)
			if not old is BaseMaterial3D: continue
			if old.albedo_texture == null:
				var glass=color_mat("273739",0.3,0.18)
				n.set_surface_override_material(i,glass)
				continue
			var key = str(old.albedo_texture.resource_path)+str(repaint)+str(tint)
			if not mats.has(key):
				var m := ShaderMaterial.new()
				m.shader = load("res://weathered.gdshader")
				m.set_shader_parameter("atlas",old.albedo_texture)
				m.set_shader_parameter("normal_atlas",old.normal_texture)
				m.set_shader_parameter("normal_strength",0.55)
				m.set_shader_parameter("repaint_wood",repaint)
				m.set_shader_parameter("siding",load("res://art/aged-clapboard.png"))
				m.set_shader_parameter("cutout_threshold",0.08 if "fence" in old.albedo_texture.resource_path else 0.35)
				m.set_shader_parameter("tint",Vector3(tint.r,tint.g,tint.b))
				mats[key]=m
			n.set_surface_override_material(i,mats[key])
	for c in n.get_children(): recolor(c,repaint,tint)

func asset(parent: Node3D,slug: String,label: String,pos: Vector3,angle := 0.0,fit := Vector3.ZERO,repaint := false,tint := Color(0.8,0.83,0.8)) -> Node3D:
	var n = h.add_asset("res://assets/tevy/"+slug+".glb",parent,label,pos,0,angle,fit)
	recolor(n,repaint,tint)
	return n

func text3(parent: Node3D,label: String,words: String,pos: Vector3,size: int,color: Color) -> void:
	var t := Label3D.new()
	t.name=label
	t.text=words
	t.font_size=size
	var font:=SystemFont.new()
	font.font_names=PackedStringArray(["Georgia","Times New Roman"])
	t.font=font
	t.pixel_size=0.008
	t.modulate=color
	t.outline_size=0
	t.no_depth_test=false
	t.shaded=true
	t.position=pos
	parent.add_child(t)

func light(parent: Node3D,label: String,pos: Vector3,color: Color,energy: float,radius: float) -> void:
	var n := OmniLight3D.new()
	n.name=label
	n.position=pos
	n.light_color=color
	n.light_energy=energy
	n.omni_range=radius
	n.omni_attenuation=1.2
	n.shadow_enabled=true
	parent.add_child(n)

func build() -> void:
	rng.seed=2333000
	r=Node3D.new()
	r.name="FerryOffice"
	h.root=r
	root.add_child(r)
	var arch=group("Office_EditableModules")
	var props=group("DockAndStreetProps")
	var bg=group("ForestAndShore")
	var weather=group("WeatherAndLighting")
	var physics=group("PlayableLane")
	var wood=color_mat("454a43")
	var trim=color_mat("5d645b")
	var steel=color_mat("272e2e",0.48,0.55)
	var dark=color_mat("1d282b",0.3,0.3)
	var paper=color_mat("8d978b")
	var blue=color_mat("263d49")
	# A complete single-storey shell assembled from real wall, window and roof assets.
	for x in [-4.0,-2.0,2.0,4.0]:
		asset(arch,"nordic-house-wall-window","FrontWindow",Vector3(x,0.95,-1.5),0,Vector3.ZERO,true)
		for y in [1.95,2.48,2.93]: box(arch,"WindowMullion",Vector3(x,y,-1.30),Vector3(0.94,0.025,0.025),wood)
	for x in [-4.0,-2.0,0.0,2.0,4.0]:
		asset(arch,"nordic-house-wall","RearWall",Vector3(x,0.95,-5.5),180,Vector3.ZERO,true)
		asset(arch,"red-wooden-house-roof-section","MainRoofBay",Vector3(x,3.74,-3.5),0,Vector3(2.06,1.4,4.85),true)
	for x in [-5.0,5.0]:
		for z in [-2.5,-4.5]:
			asset(arch,"nordic-house-wall","SideWall",Vector3(x,0.95,z),90 if x<0 else -90,Vector3.ZERO,true)
		asset(arch,"red-wooden-house-gable-wall","EndGable",Vector3(x,3.7,-3.5),90,Vector3(4.4,1.4,0.295),true)
	# Central glass entrance, framed with the source door modules.
	for x in [-0.55,0.55]:
		asset(arch,"nordic-house-wall-door","EntranceDoor",Vector3(x,0.95,-1.47),0,Vector3(1.12,2.8,0.24),true)
		box(arch,"DoorGlazing",Vector3(x,2.43,-1.29),Vector3(0.58,1.26,0.025),dark)
		box(arch,"DoorPull",Vector3(x+(-0.24 if x>0 else 0.24),1.88,-1.22),Vector3(0.035,0.19,0.04),steel)
	# Purpose-built portico uses the downloaded gable and tiled roof; trim fills joins.
	asset(arch,"red-wooden-house-gable-wall","CentralGable",Vector3(0,4.08,0.15),0,Vector3(5.5,2.12,0.295),true)
	asset(arch,"red-wooden-house-roof-section","PorticoRoof",Vector3(0,4.03,-1.35),90,Vector3(3.3,2.28,5.8),true)
	box(arch,"PorchCeiling",Vector3(0,4.055,-0.6),Vector3(5.45,0.12,1.8),wood)
	for x in [-2.52,2.52]:
		box(arch,"PorticoPost",Vector3(x,2.52,0.13),Vector3(0.19,3.15,0.19),wood)
		for y in [1.04,3.92]: box(arch,"PostMoulding",Vector3(x,y,0.13),Vector3(0.27,0.12,0.27),trim)
	for y in [3.99,4.10]: box(arch,"FrontCornice",Vector3(0,y,0.36),Vector3(5.78,0.1,0.24),trim)
	box(arch,"FerrySign",Vector3(0,4.85,0.35),Vector3(2.65,0.73,0.07),blue)
	for y in [4.52,5.18]: box(arch,"SignTrim",Vector3(0,y,0.40),Vector3(2.55,0.018,0.015),trim)
	text3(arch,"OfficeName","SILVER PINES\nFERRY OFFICE",Vector3(0,4.86,0.403),30,Color("bdc6b5"))
	box(arch,"WaitingHallSign",Vector3(0,3.38,-1.19),Vector3(1.62,0.39,0.05),paper)
	text3(arch,"HallText","TICKETS &\nWAITING HALL",Vector3(0,3.38,-1.153),18,Color("344750"))
	# Wooden dock: continuous geometry and collision, with visible piles and shore transition.
	for x in [-9.72,0.0,9.72]:
		for z in [0.85,-0.98]: asset(props,"wooden-jetty","DockBay",Vector3(x,-0.58,z),90)
	collision(physics,"Walkway",Vector3(0,0.9,0.9),Vector3(29.3,0.18,3.55))
	# Foreground handrail is deliberately slender, as in the reference.
	for x in range(-14,15):
		if x>-2 and x<3: continue
		beam(props,"RailPost",Vector3(x,0.94,2.10),Vector3(x,1.78,2.10),0.027,steel)
		for offset in [0.25,0.5,0.75]: beam(props,"RailBaluster",Vector3(x+offset,0.95,2.1),Vector3(x+offset,1.72,2.1),0.012,steel)
	for ends in [[-14.0,-1.2],[2.2,14.0]]:
		beam(props,"Handrail",Vector3(ends[0],1.78,2.1),Vector3(ends[1],1.78,2.1),0.032,steel)
	for x in [-10.5,-7.0,7.0,10.5]: asset(props,"temporary-mesh-fence-panel","BoundaryFence",Vector3(x,0.94,-0.45),0,Vector3.ZERO,false,Color(0.32,0.38,0.37))
	asset(props,"park-bench","WaitingBench",Vector3(-6.2,0.99,0.0))
	asset(props,"wooden-crate","JumpCrate",Vector3(5.8,0.99,1.4),-8)
	collision(physics,"Crate",Vector3(5.8,1.29,1.4),Vector3(0.6,0.6,0.6))
	asset(props,"wooden-crate","FreightBesideFence",Vector3(7.6,0.99,-0.1),12)
	asset(props,"wooden-crate","FreightSmall",Vector3(8.15,0.99,0.1),-15,Vector3(0.43,0.43,0.43))
	asset(props,"utility-pole","ForegroundPole",Vector3(-4.4,-0.1,2.7),0,Vector3(1.8,8.7,3.4),false,Color(0.45,0.51,0.48))
	var tire:=TorusMesh.new()
	tire.inner_radius=0.23
	tire.outer_radius=0.43
	var tire_node=mesh(props,"MooringTire",tire,Vector3(-4.4,1.63,2.93),color_mat("1c2423"))
	tire_node.rotation_degrees.x=90
	beam(props,"TireHangingRope",Vector3(-4.4,1.94,2.87),Vector3(-4.4,2.45,2.77),0.017,wood)
	asset(props,"traffic-light","RedHarborSignal",Vector3(7.3,0.98,0.2),0,Vector3(0.58,3.75,0.73),false,Color(0.65,0.68,0.65))
	var red=color_mat("c02d18")
	red.emission_enabled=true
	red.emission=Color("ff4c1e")
	red.emission_energy_multiplier=3
	var bulb:=SphereMesh.new()
	bulb.radius=0.092
	bulb.height=0.184
	mesh(props,"SignalRedLens",bulb,Vector3(7.3,4.34,0.59),red)
	light(weather,"SignalGlow",Vector3(7.3,4.35,0.8),Color("ff4a28"),0.5,2)
	# Noticeboard / timetables, where a traveller would wait.
	box(props,"TimetableCase",Vector3(-3.62,1.85,0.08),Vector3(1.15,1.28,0.13),wood)
	for x in [-4.09,-3.15]: box(props,"TimetableLeg",Vector3(x,1.35,0.03),Vector3(0.07,0.75,0.1),wood)
	box(props,"TimetablePaper",Vector3(-3.62,1.81,0.158),Vector3(0.96,0.99,0.012),paper)
	text3(props,"ScheduleTitle","FERRY SCHEDULE",Vector3(-3.62,2.31,0.18),13,Color("263c43"))
	text3(props,"ScheduleRows","NORTH SHORE  06:30\nEAST BAY      09:45\nSILVER PINES  14:10\n\nSERVICE SUSPENDED\nDUE TO WEATHER",Vector3(-3.62,1.86,0.18),9,Color("38464a"))
	for x in [-9.0,-6.5,4.5,7.0,9.5]: asset(props,"black-steel-street-bollard","RoadBollard",Vector3(x,0.45,4.9),0,Vector3.ZERO,false,Color(0.45,0.50,0.48))
	for j in range(3):
		var z=2.7-j*0.09
		for i in range(30):
			var x1=-15.0+i
			var x2=x1+1.0
			var y1=6.2+j*0.5+0.003*pow(x1+1.0,2)
			var y2=6.2+j*0.5+0.003*pow(x2+1.0,2)
			beam(props,"OverheadCable",Vector3(x1,y1,z),Vector3(x2,y2,z),0.013,steel)
	# Ground and broad background are part of the saved scene, not backdrop screenshots.
	var groundmat:=ShaderMaterial.new()
	groundmat.shader=load("res://ground.gdshader")
	box(bg,"WetRoadAndBank",Vector3(0,-0.18,1),Vector3(90,0.2,42),groundmat)
	box(bg,"ForegroundRoad",Vector3(0,0.35,14),Vector3(90,0.2,22),groundmat)
	var water=color_mat("465d60",0.21,0.48)
	box(bg,"WaterBeyondDock",Vector3(0,-0.12,-23),Vector3(130,0.07,38),water)
	var clouds:=QuadMesh.new()
	clouds.size=Vector2(220,90)
	var cloudmat:=ShaderMaterial.new()
	cloudmat.shader=load("res://cloud_backdrop.gdshader")
	mesh(bg,"StormCloudBackdrop",clouds,Vector3(0,25,-100),cloudmat)
	for layer in range(3):
		var st:=SurfaceTool.new()
		st.begin(Mesh.PRIMITIVE_TRIANGLES)
		var points:Array[Vector3]=[]
		for i in range(121):
			var x=-95.0+i*1.58
			var y=4.5+layer*1.0+sin(i*0.11+layer)*2.2+sin(i*0.33+0.4)*0.65+rng.randf_range(-0.25,0.25)
			points.append(Vector3(x,y,-42-layer*14))
		for i in range(120):
			for v in [Vector3(points[i].x,-2,points[i].z),points[i],points[i+1],Vector3(points[i].x,-2,points[i].z),points[i+1],Vector3(points[i+1].x,-2,points[i+1].z)]: st.add_vertex(v)
		st.generate_normals()
		var mountainmat=color_mat(["394e50","526668","667777"][layer])
		mountainmat.shading_mode=BaseMaterial3D.SHADING_MODE_UNSHADED
		mountainmat.cull_mode=BaseMaterial3D.CULL_DISABLED
		mesh(bg,"MountainRidge",st.commit(),Vector3.ZERO,mountainmat)
	for i in range(48):
		var x=rng.randf_range(-60,60)
		var z=rng.randf_range(-39,-24)
		var tall=rng.randf_range(3.3,6.8)
		asset(bg,"norway-spruce","DistantSpruce",Vector3(x,-0.05,z),rng.randf_range(0,360),Vector3(tall*0.43,tall,tall*0.43),false,Color(0.36,0.47,0.44))
	for i in range(8):
		var x=(-1 if i%2==0 else 1)*rng.randf_range(10,22)
		asset(bg,"dead-spruce","ShoreTree",Vector3(x,-0.05,rng.randf_range(-14,-8)),rng.randf_range(0,360),Vector3(2.5,6.0,2.5),false,Color(0.42,0.49,0.45))
	# Light sources have visible fixtures; weak overcast fill retains wood detail.
	var env:=Environment.new()
	env.background_mode=Environment.BG_SKY
	var sky:=Sky.new()
	var sm:=ShaderMaterial.new()
	sm.shader=load("res://storm.gdshader")
	sky.sky_material=sm
	env.sky=sky
	env.ambient_light_source=Environment.AMBIENT_SOURCE_COLOR
	env.ambient_light_color=Color("a5bbc1")
	env.ambient_light_energy=0.36
	env.tonemap_mode=Environment.TONE_MAPPER_FILMIC
	env.ssao_enabled=true
	env.ssao_radius=1.0
	env.ssao_intensity=1.5
	env.ssil_enabled=true
	env.ssil_intensity=0.8
	env.ssr_enabled=true
	env.glow_enabled=true
	env.glow_intensity=0.28
	env.volumetric_fog_enabled=true
	env.volumetric_fog_density=0.0
	var fog:=FogVolume.new()
	fog.name="DistantShoreMist"
	fog.size=Vector3(160,25,65)
	fog.position=Vector3(0,8,-45)
	var fm:=FogMaterial.new()
	fm.density=0.035
	fm.albedo=Color("7c9392")
	fm.emission=Color(0.17,0.20,0.19)
	fog.material=fm
	weather.add_child(fog)
	var we:=WorldEnvironment.new()
	we.environment=env
	weather.add_child(we)
	var sun:=DirectionalLight3D.new()
	sun.name="OvercastKey"
	sun.rotation_degrees=Vector3(-35,-20,0)
	sun.light_color=Color("b0c5c8")
	sun.light_energy=0.45
	sun.shadow_enabled=false
	sun.directional_shadow_max_distance=70
	weather.add_child(sun)
	var lamp=color_mat("b7b59a",0.4,0.5)
	lamp.emission_enabled=true
	lamp.emission=Color("ffd38a")
	lamp.emission_energy_multiplier=1.7
	var shade:=CylinderMesh.new()
	shade.top_radius=0.07
	shade.bottom_radius=0.22
	shade.height=0.12
	mesh(arch,"DoorLampShade",shade,Vector3(0,3.8,0.34),steel)
	var disc:=CylinderMesh.new()
	disc.top_radius=0.16
	disc.bottom_radius=0.16
	disc.height=0.018
	mesh(arch,"WarmBulb",disc,Vector3(0,3.73,0.34),lamp)
	light(weather,"DoorWarmPool",Vector3(0,3.45,0.32),Color("ffc77a"),1.7,3.2)
	light(weather,"DoorGlassBounce",Vector3(0,2.1,-0.95),Color("e8b77f"),0.6,2.0)
	var rain:=GPUParticles3D.new()
	rain.name="Rain"
	rain.amount=550
	rain.lifetime=1.4
	rain.visibility_aabb=AABB(Vector3(-24,-1,-10),Vector3(48,14,20))
	rain.position=Vector3(0,9,3)
	var pm:=ParticleProcessMaterial.new()
	pm.emission_shape=ParticleProcessMaterial.EMISSION_SHAPE_BOX
	pm.emission_box_extents=Vector3(20,4,6)
	pm.direction=Vector3(-0.15,-1,0)
	pm.spread=2
	pm.initial_velocity_min=9
	pm.initial_velocity_max=13
	pm.gravity=Vector3(0,-2,0)
	rain.process_material=pm
	var rm:=StandardMaterial3D.new()
	rm.transparency=BaseMaterial3D.TRANSPARENCY_ALPHA
	rm.shading_mode=BaseMaterial3D.SHADING_MODE_UNSHADED
	rm.albedo_color=Color(0.75,0.83,0.82,0.16)
	rm.billboard_mode=BaseMaterial3D.BILLBOARD_ENABLED
	var drop:=QuadMesh.new()
	drop.size=Vector2(0.009,0.36)
	drop.material=rm
	rain.draw_pass_1=drop
	weather.add_child(rain)
	var player:=CharacterBody3D.new()
	player.name="Player"
	player.set_script(load("res://player.gd"))
	player.position=Vector3(-1.0,1.03,1.4)
	var cap:=CollisionShape3D.new()
	cap.shape=CapsuleShape3D.new()
	cap.shape.radius=0.22
	cap.shape.height=1.7
	cap.position.y=0.85
	player.add_child(cap)
	var sprite:=Sprite3D.new()
	sprite.name="InkSprite"
	sprite.texture=load("res://art/investigator-sheet.png")
	sprite.hframes=3
	sprite.vframes=2
	sprite.pixel_size=0.0041
	sprite.position.y=0.93
	sprite.alpha_cut=SpriteBase3D.ALPHA_CUT_DISCARD
	sprite.alpha_scissor_threshold=0.28
	sprite.texture_filter=BaseMaterial3D.TEXTURE_FILTER_LINEAR
	sprite.modulate=Color(0.9,0.92,0.87)
	player.add_child(sprite)
	r.add_child(player)
	var camera:=Camera3D.new()
	camera.name="SideCamera"
	camera.position=Vector3(0,4.0,22)
	r.add_child(camera)
	camera.look_at(Vector3(0,2.95,0))
	camera.fov=22.2
	camera.current=true
	camera.set_script(load("res://follow.gd"))
	camera.set("target",NodePath("../Player"))
	h.own(r)
	h.save("res://ferry_office.tscn")
	print("SAVED ferry_office.tscn — modules, background, weather and player")
	quit()
