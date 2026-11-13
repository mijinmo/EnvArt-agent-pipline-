extends SceneTree
var scene: Node3D
var serial:=0
func add(n:Node,p:Node=null)->Node:
	if p==null:p=scene
	p.add_child(n);n.owner=scene
	return n
func asset(id:String,pos:Vector3,angle:float=0.0,s:float=1.0)->Node3D:
	var path="res://assets/"+id+".gltf.glb"
	if not ResourceLoader.exists(path):path="res://assets/"+id+".glb"
	var n=load(path).instantiate()
	serial+=1;n.name=id+"_%03d"%serial
	add(n);n.position=pos;n.rotation.y=deg_to_rad(angle);n.scale=Vector3.ONE*s
	scene.set_editable_instance(n,true)
	tint(n)
	return n
func tint(n:Node):
	if n is MeshInstance3D:
		for i in n.mesh.get_surface_count():
			var m=n.mesh.surface_get_material(i).duplicate()
			m.albedo_color=Color(0.63,0.67,0.71)
			m.roughness=0.82
			n.set_surface_override_material(i,m)
	for child in n.get_children():tint(child)
func lamp(pos:Vector3,power:=1.0,radius:=6.0):
	var l=OmniLight3D.new();add(l);l.position=pos;l.light_color=Color("ffb463");l.light_energy=power*1.25;l.omni_range=radius;l.shadow_enabled=true
func camera(id:String,pos:Vector3,target:Vector3,fov:float):
	var c=Camera3D.new();c.name=id;add(c);c.position=pos;c.basis=Basis.looking_at(target-pos);c.fov=fov;c.far=250
func _initialize():
	scene=Node3D.new();scene.name="Emberwatch";root.add_child(scene)
	var env=WorldEnvironment.new();add(env);env.environment=Environment.new()
	var e=env.environment;e.background_mode=Environment.BG_COLOR;e.background_color=Color("758b99");e.ambient_light_source=Environment.AMBIENT_SOURCE_COLOR;e.ambient_light_color=Color("b6c9dd");e.ambient_light_energy=0.55;e.tonemap_mode=Environment.TONE_MAPPER_LINEAR
	e.ssao_enabled=true;e.ssao_radius=1.2;e.ssao_intensity=1.1;e.ssao_power=1.5;e.ssao_detail=0.5;e.ssao_light_affect=0.0;e.ssao_ao_channel_affect=0.0
	e.ssil_enabled=true;e.ssil_radius=3.0;e.ssil_intensity=0.65;e.ssil_sharpness=0.85
	e.fog_enabled=true;e.fog_light_color=Color("819ba6");e.fog_density=0.004
	var sun=DirectionalLight3D.new();add(sun);sun.rotation_degrees=Vector3(-42,-28,0);sun.light_color=Color("ffe0ba");sun.light_energy=1.25;sun.shadow_enabled=true;sun.directional_shadow_max_distance=90
	# Modular paving, dirt and boundary wear at native proportions.
	for x in range(-6,7):
		for z in range(-6,7):
			var tile="floor_tile_small"
			if abs(x)==6 or abs(z)==6:tile="floor_dirt_small_weeds" if (x+z)%3==0 else "floor_dirt_small_A"
			elif (x*7+z*3)%19==0:tile="floor_tile_small_broken_A"
			elif (x*7+z*3)%23==0:tile="floor_tile_small_decorated"
			asset(tile,Vector3(x*2,0,z*2),float(posmod(x+z,4)*90))
	for x in [-8,-4,0,4,8]:
		asset("wall_doorway_sides" if x==0 else ("wall_archedwindow_gated" if x==8 else "wall"),Vector3(x,0,-8))
		asset("barrier",Vector3(x,4,-8))
	for z in [-6,-2,2]:
		asset("wall_archedwindow_gated" if z==-2 else "wall",Vector3(10,0,z),-90)
		asset("barrier",Vector3(10,4,z),-90)
	for x in [-10,-6,-2,2,6,10]:asset("pillar",Vector3(x,0,-8))
	for z in [-4,0,4]:asset("pillar",Vector3(10,0,z))
	# Gate anchors: real opening, elevated heraldry, symmetric warm practicals.
	for x in [-1.6,1.6]:
		asset("torch_mounted",Vector3(x,2.2,-7.4));lamp(Vector3(x,2.7,-6.8),1.4,6)
	for x in [-4,4]:asset("banner_patternA_red",Vector3(x,0,-7.4))
	# Raised left watch deck, stone retaining modules, timber stair with railings.
	for x in [-8,-6,-4]:
		for z in [-6,-4]:
			asset("floor_foundation_allsides",Vector3(x,0,z))
			asset("floor_foundation_allsides",Vector3(x,2,z))
			asset("floor_wood_small_dark",Vector3(x,4.01,z))
	asset("stairs_wood_decorated",Vector3(-6,0,-3))
	asset("barrier",Vector3(-8.1,4,-2.9),0,0.5)
	asset("barrier",Vector3(-3.9,4,-2.9),0,0.5)
	asset("barrier",Vector3(-9,4,-5),90)
	asset("barrel_small_stack",Vector3(-7.7,4.05,-5.5),15,0.8)
	asset("table_small_decorated_A",Vector3(-4.3,4.05,-5.6),90,0.85)
	# Wall-side ration/ledger station.
	asset("table_long",Vector3(6.3,0.05,-5.2),90)
	asset("sword_shield",Vector3(6,2.7,-7.35))
	asset("shelf_small_candles",Vector3(8.3,2.5,-7.4))
	asset("shelf_large",Vector3(4.9,2.55,-7.4))
	for i in range(4):asset("bottle_A_labeled_green",Vector3(4.2+i*0.43,2.66,-7.12),float(i*20),0.65)
	asset("plate_stack",Vector3(7.2,1.08,-5.5),0,0.8)
	asset("plate_food_A",Vector3(5.4,1.08,-5.1),15,0.8)
	asset("bottle_C_brown",Vector3(7.8,1.08,-5.2),-10,0.8)
	asset("candle_triple",Vector3(6.7,1.08,-5.6),0,0.7)
	asset("coin_stack_medium",Vector3(4.9,1.08,-5.6),0,0.8)
	asset("chair",Vector3(5.5,0.05,-3.4),-160,0.9)
	asset("stool",Vector3(7.5,0.05,-3.7),12,0.8)
	asset("barrel_large_decorated",Vector3(8.5,0.05,-1.6),-15,0.85)
	asset("barrel_small_stack",Vector3(8.6,0.05,1.0),-80,0.8)
	asset("keg_decorated",Vector3(3.3,0.05,-6.0),10,0.8)
	asset("torch_mounted",Vector3(9.4,2.4,-4.1),-90);lamp(Vector3(8.7,2.9,-4.1),1.6,7)
	# Entrance supplies leave middle route open.
	asset("chest",Vector3(-2.8,0.05,4.4),15)
	asset("sword_shield",Vector3(-2.6,0.9,5.15),-10,0.8)
	asset("box_small_decorated",Vector3(-4.2,0.05,4.9),-8)
	asset("candle_triple",Vector3(-1.8,0.05,4.5),0,0.65);lamp(Vector3(-1.8,0.9,4.5),0.6,3)
	for p in [Vector3(9,0.05,3.7),Vector3(-9,0.05,2),Vector3(2.1,0.05,-7.1)]:asset("rubble_half",p,24,0.6)
	for x in [-7,7]:
		for z in range(-5,6):
			if posmod(z+x,4)!=0:asset("floor_dirt_small_A",Vector3(x*2,-0.015,z*2),0)
	for p in [Vector3(-16,0,-17),Vector3(17,0,-13),Vector3(-18,0,-1),Vector3(18,0,2)]:asset("rubble_large",p,31,0.62)
	# Distant continuation behind gate; same family, lower contrast through atmosphere.
	for x in [-2,0,2]:
		for z in [-10,-12,-14,-16]:asset("floor_tile_small",Vector3(x,0,z))
	for tx in [-14,12]:
		for level in range(3):
			for side in range(4):
				var a=side*PI/2;asset("wall_archedwindow_open",Vector3(tx+sin(a)*2,level*4,-23+cos(a)*2),side*90)
		for side in range(4):
			var a=side*PI/2;asset("barrier",Vector3(tx+sin(a)*2,12,-23+cos(a)*2),side*90)
	for x in [-10,-6,-2,2,6,10]:asset("wall_broken",Vector3(x,0,-25))
	# Low-poly terrain is only the missing distant support, not architecture.
	var st=SurfaceTool.new();st.begin(Mesh.PRIMITIVE_TRIANGLES)
	for xi in range(-35,35):
		for zi in range(-35,35):
			var a=Vector3(xi*4,0,zi*4);var b=a+Vector3(4,0,0);var c=a+Vector3(4,0,4);var d=a+Vector3(0,0,4)
			for v in [a,b,c,a,c,d]:
				v.y=-0.025
				if v.z < -32:v.y+=maxf(0.0,(-v.z-32)*0.12)* (1.3+0.65*sin(v.x*0.063)+0.4*cos(v.z*0.11))
				if abs(v.x)>25:v.y+=maxf(0.0,(abs(v.x)-25)*0.08)*(1+0.4*sin(v.z*0.12))
				st.add_vertex(v)
	st.generate_normals();var ground=MeshInstance3D.new();add(ground);ground.name="DistantAshTerrain";ground.mesh=st.commit()
	var earth=StandardMaterial3D.new();earth.albedo_color=Color("5d6059");earth.roughness=1.0;ground.material_override=earth
	camera("Overall",Vector3(-13,12,19),Vector3(0,1.8,-3.8),54)
	camera("Entrance",Vector3(3.0,3.4,6.5),Vector3(-0.3,2,-8),68)
	camera("Activity",Vector3(2.3,3.7,0.5),Vector3(6.4,1.8,-5.6),62)
	camera("Transition",Vector3(-12,6,7),Vector3(-5.6,2,-3.5),65)
	(scene.get_node("Overall") as Camera3D).current=true
	scene.set_script(load("res://inspection.gd"))
	var pack=PackedScene.new();pack.pack(scene);ResourceSaver.save(pack,"res://courtyard.tscn")
	print("Saved editable courtyard with ",serial," kit instances")
	quit()
