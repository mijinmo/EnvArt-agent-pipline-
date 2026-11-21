extends SceneTree
# First assembly only. The saved waystation.tscn is authoritative after manual edits.
var h
var scene: Node3D
var rng := RandomNumberGenerator.new()
var regions := {}
var terrain_noise := FastNoiseLite.new()
const V = "res://assets/quaternius_village/"
const P = "res://assets/quaternius_props/"
const N = "res://assets/quaternius_nature/"
func _initialize() -> void: call_deferred("build")
func group(label: String) -> Node3D:
	var n := Node3D.new()
	n.name = label
	scene.add_child(n)
	n.owner = scene
	regions[label] = n
	return n
func asset(folder: String, file: String, region: String, pos: Vector3, height: float, angle: float = 0, fit := Vector3.ZERO) -> Node3D:
	return h.add_asset(folder+file+".gltf",regions[region],file,pos,height,angle,fit)
func mat(color: String) -> StandardMaterial3D:
	var m := StandardMaterial3D.new()
	m.albedo_color = Color(color)
	m.roughness = 0.9
	return m
func box(region: String,label: String,pos: Vector3,size: Vector3,m: Material) -> MeshInstance3D:
	var n := MeshInstance3D.new()
	n.name=label
	var mesh := BoxMesh.new()
	mesh.size=size
	n.mesh=mesh
	n.material_override=m
	n.position=pos
	regions[region].add_child(n)
	n.owner=scene
	return n
func solid(parent: Node3D, size: Vector3, center: Vector3) -> void:
	var body:=StaticBody3D.new()
	body.collision_layer=1
	body.collision_mask=2
	parent.add_child(body)
	body.owner=scene
	var col:=CollisionShape3D.new()
	var s:=BoxShape3D.new()
	s.size=size
	col.shape=s
	col.position=center
	body.add_child(col)
	col.owner=scene
func house(pos: Vector3, w: float, floors: int, region: String, angle: float=0) -> void:
	var base := Node3D.new()
	base.name="TimberHouse"
	regions[region].add_child(base)
	base.owner=scene
	var store: Node3D=regions[region]
	regions[region]=base
	var height:=2.8*floors
	for level in range(floors):
		for i in range(2):
			var x:float=(-0.25+0.5*i)*w
			for z in [-w*0.5,w*0.5]:
				asset(V,"Wall_Plaster_Straight",region,Vector3(x,level*2.8,z),0,0,Vector3(w*0.5,2.8,0.28))
				asset(V,"Wall_Plaster_WoodGrid",region,Vector3(x,level*2.8,z+0.13),0,0,Vector3(w*0.5,2.8,0.22))
			for side in [-1,1]:
				asset(V,"Wall_Plaster_Straight",region,Vector3(side*w*0.5,level*2.8,x),0,90,Vector3(w*0.5,2.8,0.28))
		for x in [-w*0.5,w*0.5]:
			asset(V,"Corner_Exterior_Wood",region,Vector3(x,level*2.8,w*0.5),2.8)
	asset(V,"Roof_RoundTiles_4x4",region,Vector3(0,height-0.12,0),0,0,Vector3(w+0.65,w*0.64,w+0.65))
	asset(V,"Roof_Front_Brick4",region,Vector3(0,height-0.17,w*0.5+0.05),0,0,Vector3(w*0.96,w*0.52,0.18))
	asset(V,"Roof_Front_Brick4",region,Vector3(0,height-0.17,-w*0.5),0,180,Vector3(w*0.96,w*0.52,0.18))
	asset(V,"Prop_Chimney",region,Vector3(w*0.25,height+w*0.28,-w*0.15),1.8)
	asset(V,"Door_1_Flat",region,Vector3(-w*0.2,0,w*0.5+0.24),2.1)
	for x in [w*0.22,-w*0.23]:
		var y:float=3.2 if floors>1 else 0.8
		asset(V,"Window_Wide_Flat1",region,Vector3(x,y,w*0.5+0.25),1.2)
		asset(V,"WindowShutters_Wide_Flat_Open",region,Vector3(x,y,w*0.5+0.32),1.25)
	asset(V,"Prop_Vine2",region,Vector3(w*0.38,0.4,w*0.5+0.4),height*0.85)
	solid(base,Vector3(w,height,w),Vector3(0,height*0.5,0))
	base.position=pos
	base.rotation_degrees.y=angle
	regions[region]=store
func lamp(pos: Vector3,region: String) -> void:
	asset(P,"Lantern_Wall",region,pos,0.55,180)
	var light:=OmniLight3D.new()
	light.name="LanternLight"
	light.position=pos+Vector3(0,0.2,0.2)
	light.light_color=Color("ffbc67")
	light.light_energy=2.0
	light.omni_range=4
	light.shadow_enabled=true
	regions[region].add_child(light)
	light.owner=scene
	var glow:=mat("ffb363")
	glow.emission_enabled=true
	glow.emission=Color("ffbe66")
	glow.emission_energy_multiplier=3
	box(region,"LanternGlass",pos+Vector3(0,0.2,0.08),Vector3(0.13,0.16,0.13),glow)
func terrain_height(x: float,z: float) -> float:
	var rise:=maxf(0,(-z-20)*0.14)
	var valley:=0.38+0.62*smoothstep(5,35,absf(x-10))
	return 1.8+rise*valley+(terrain_noise.get_noise_2d(x,z)+0.45)*rise*0.9
func terrain() -> void:
	var surf:=SurfaceTool.new()
	surf.begin(Mesh.PRIMITIVE_TRIANGLES)
	var verts:Array[Vector3]=[]
	for z in range(39):
		for x in range(71):
			var px:float=-140+x*4
			var pz:float=-16-z*4
			var height:float=terrain_height(px,pz)
			verts.append(Vector3(px,height,pz))
	for z in range(38):
		for x in range(70):
			var a:=z*71+x
			for i in [a,a+71,a+1,a+1,a+71,a+72]:
				var v:=verts[i]
				var c:=Color("547c70").lerp(Color("9bb3b0"),clampf((-v.z-16)/160,0,1))
				surf.set_color(c)
				surf.add_vertex(v)
	surf.index()
	surf.generate_normals()
	var m:=mat("ffffff")
	m.vertex_color_use_as_albedo=true
	surf.set_material(m)
	var mesh:=MeshInstance3D.new()
	mesh.name="ContinuousValleyTerrain"
	mesh.mesh=surf.commit()
	regions.Background.add_child(mesh)
	mesh.owner=scene
func build() -> void:
	rng.seed=221122
	terrain_noise.seed=823
	terrain_noise.frequency=0.022
	h=load("res://asset_helpers.gd").new()
	scene=Node3D.new()
	scene.name="ValleyWaystation"
	h.root=scene
	root.add_child(scene)
	for region in ["Ground","Architecture","Gate","WorkYard","Garden","Foreground","Background"]: group(region)
	h.environment()
	var env:Environment=scene.get_node("Atmosphere").environment
	env.fog_enabled=true
	env.fog_mode=Environment.FOG_MODE_DEPTH
	env.fog_depth_begin=28
	env.fog_depth_end=155
	env.fog_depth_curve=0.85
	env.fog_light_color=Color("81a4b1")
	env.fog_sky_affect=0.1
	env.ambient_light_energy=0.3
	env.background_color=Color("80a2b1")
	scene.get_node("LateAfternoon").light_energy=1.35
	scene.get_node("LateAfternoon").rotation_degrees=Vector3(-24,-48,0)
	var base=load("res://source/whitebox.tscn").instantiate()
	base.name="BaseWhitebox"
	base.scene_file_path=""
	scene.add_child(base)
	base.owner=scene
	h.own(base)
	var ground:=ShaderMaterial.new()
	ground.shader=load("res://ground.gdshader")
	ground.set_shader_parameter("stone",load(V+"T_UnevenBrick_BaseColor.png"))
	var masonry:=StandardMaterial3D.new()
	masonry.albedo_texture=load(V+"T_UnevenBrick_BaseColor.png")
	masonry.normal_enabled=true
	masonry.normal_texture=load(V+"T_UnevenBrick_Normal.png")
	masonry.normal_scale=0.5
	masonry.uv1_triplanar=true
	masonry.uv1_world_triplanar=true
	masonry.uv1_scale=Vector3.ONE*0.45
	masonry.albedo_color=Color("a6b0a2")
	masonry.roughness=0.88
	for body in base.get_node("World").get_children():
		if not body is StaticBody3D: continue
		body.get_node("Mesh").material_override=ground if body.name in ["Floor","SpawnPad"] else masonry
	# Low continuous exterior ground extends the visible whitebox edge, no replacement of collision.
	box("Ground","GroundTransition",Vector3(0,-0.42,0),Vector3(160,0.3,160),ground)
	# A restrained imported stone border, varied plants, and original steps define the activity plane.
	for x in range(-15,16,2):
		asset(V,"Prop_ExteriorBorder_Straight1","Ground",Vector3(x,-0.08,3.4),0,0,Vector3(2,0.24,0.22))
	for x in range(-11,12,2):
		asset(V,"Wall_UnevenBrick_Straight","Architecture",Vector3(x,0,-11.63),0,0,Vector3(2,4,0.23))
		asset(V,"Prop_ExteriorBorder_Straight2","Architecture",Vector3(x,3.9,-11.6),0,0,Vector3(2.05,0.27,0.65))
	house(Vector3(-11,0,-7.9),4.6,2,"Architecture")
	house(Vector3(5.7,0,-9),4.2,2,"Architecture")
	# The gate keeps the original opening and exact physics. Decorative trim sits outside it.
	asset(V,"DoorFrame_Flat_Brick","Gate",Vector3(0,0,-3.57),0,0,Vector3(3.1,3.15,0.35))
	asset(V,"Roof_RoundTiles_4x4","Gate",Vector3(0,2.9,-4),0,0,Vector3(3.65,1.45,2.0))
	asset(V,"Roof_Front_Brick4","Gate",Vector3(0,2.85,-3.1),0,0,Vector3(3.1,1.2,0.14))
	asset(V,"Prop_Vine1","Gate",Vector3(-1.45,0.25,-3.27),2.5)
	asset(V,"Prop_Vine4","Gate",Vector3(1.5,0.4,-3.25),2.1)
	lamp(Vector3(-1.5,2.05,-3.1),"Gate")
	lamp(Vector3(1.5,2.05,-3.1),"Gate")
	# Left unloading bay and right potting/workbench group stay clear of the central route.
	asset(V,"Prop_Wagon","WorkYard",Vector3(-10,0,-1.9),1.7,83)
	asset(P,"Barrel","WorkYard",Vector3(-8.5,0,-1.8),1.0,25)
	asset(P,"Bag","WorkYard",Vector3(-9.0,0,-1.1),0.6,-30)
	asset(P,"FarmCrate_Apple","WorkYard",Vector3(-10,0.8,-1.8),0.55)
	asset(P,"Rope_2","WorkYard",Vector3(-11.3,0.03,-0.8),0.12,36)
	asset(P,"Bucket_Wooden_1","WorkYard",Vector3(-8.2,0,-2.6),0.55)
	asset(P,"Stall_Empty","WorkYard",Vector3(7.5,0,-4),2.8,180)
	asset(P,"Workbench","WorkYard",Vector3(7.1,0,-2.8),0.95)
	asset(P,"Pot_1","WorkYard",Vector3(6.4,1.0,-2.8),0.42)
	asset(P,"Vase_4","WorkYard",Vector3(7.5,0.98,-2.8),0.6)
	asset(P,"FarmCrate_Carrot","WorkYard",Vector3(8.9,0,-2.8),0.5,-20)
	asset(P,"Barrel","WorkYard",Vector3(9,0,-4.1),1.1)
	asset(P,"Stool","WorkYard",Vector3(7.3,0,-1.6),0.5,10)
	lamp(Vector3(8.7,2.1,-3.8),"WorkYard")
	# Trees establish the intermediate silhouette; leaves/grass retain source alpha masks.
	for t in [[-15,1,-8,9],[-13,0,4,8],[13,0,4,8],[12,0,-9,10],[-4,0,-10,7],[2,0,-11,8]]:
		asset(N,"CommonTree_1" if int(t[0])%2==0 else "CommonTree_3","Garden",Vector3(t[0],t[1],t[2]),t[3],rng.randf_range(0,360))
	# The activity strip remains clear; plants concentrate along its banks.
	for i in range(1000):
		var x:=rng.randf_range(-15,15)
		var z:=rng.randf_range(3.9,10.5) if i<800 else rng.randf_range(-10,-8.8)
		if absf(x)<1.5 and z>5.5: continue
		var f:String=["Grass_Common_Short","Grass_Wispy_Short","Clover_2","Flower_3_Group","Fern_1"][i%5]
		asset(N,f,"Garden",Vector3(x,0.01,z),rng.randf_range(0.24,0.66),rng.randf_range(0,360))
	for x in [-13,-9,-3,3,8,12]:
		asset(N,"Bush_Common_Flowers","Garden",Vector3(x,0,4.6),rng.randf_range(0.65,1.1),rng.randf_range(0,360))
	for x in [-14,-10,-2,4,11,14]:
		asset(N,"Rock_Medium_1","Garden",Vector3(x,-0.08,5.7),rng.randf_range(0.5,0.9),rng.randf_range(0,360))
	# Foreground is physical 3D framing, kept to the margins rather than masking the play route.
	for x in [-16,16]:
		asset(N,"CommonTree_3","Foreground",Vector3(x,-0.1,9),11.5,22*x)
		asset(N,"Bush_Common","Foreground",Vector3(x*0.8,0,9),1.2)
	for i in range(22):
		var x:=rng.randf_range(-18,18)
		if absf(x)<1.7: continue
		asset(N,"Bush_Common_Flowers","Foreground",Vector3(x,0,rng.randf_range(7,12)),rng.randf_range(0.7,1.5),rng.randf_range(0,360))
	for i in range(110):
		var x:=rng.randf_range(-15,15)
		if absf(x)<1.8: continue
		asset(N,"Fern_1" if i%3==0 else "Grass_Common_Tall","Foreground",Vector3(x,0,rng.randf_range(11,15)),rng.randf_range(0.4,0.8),rng.randf_range(0,360))
	# Reposition the working group into view beyond the original right wall; the wall stays intact.
	for item in regions.WorkYard.get_children():
		if item.position.x>0:
			item.position+=Vector3(4,0,3)
	for x in [6.6,8.3,9.5]:
		asset(V,"Prop_Vine2","Architecture",Vector3(x,0.3,-0.65),2.9)
	for x in [-11,-9,-3,-1,1,3,7,9,11]:
		asset(N,"Bush_Common_Flowers","Garden",Vector3(x,3.8,-11.5),0.75)
	terrain()
	for t in [[-20,4,-27,4.8,1],[-3,5,-37,4.4,2],[18,4,-29,4.8,1],[33,10,-65,4.5,2],[-35,12,-62,5.5,1]]:
		var y:=terrain_height(t[0],t[2])-0.15
		house(Vector3(t[0],y,t[2]),t[3],int(t[4]),"Background",rng.randf_range(-20,15))
		asset(V,"Wall_UnevenBrick_Straight","Background",Vector3(t[0],y-1.6,t[2]+t[3]*0.45),0,0,Vector3(t[3],1.9,0.5))
	for i in range(38):
		var x:=rng.randf_range(-70,70)
		var z:=rng.randf_range(-58,-18)
		var y:=terrain_height(x,z)
		asset(N,"Pine_1" if i%3==0 else "CommonTree_1","Background",Vector3(x,y-0.7,z),rng.randf_range(5,10),rng.randf_range(0,360))
	var player=load("res://controllers/player.tscn").instantiate()
	player.name="Player"
	player.position=Vector3(-3,0.1,2)
	scene.add_child(player)
	player.owner=scene
	player.scene_file_path=""
	h.own(player)
	# Retain the existing scale marker for play; neutral color keeps it subordinate to the art.
	player.get_node("Visual/Body").material_override=mat("6c817e")
	var camera:=Camera3D.new()
	camera.name="SideCamera"
	camera.position=Vector3(-3,4.4,22)
	scene.add_child(camera)
	camera.owner=scene
	camera.look_at(Vector3(-3,1.8,-2))
	camera.fov=32
	camera.current=true
	scene.set_script(load("res://sideview.gd"))
	h.save("res://waystation.tscn")
	print("SAVED waystation.tscn")
	quit()
