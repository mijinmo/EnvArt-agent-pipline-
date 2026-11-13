extends SceneTree
var scene:Node3D
var kit:Node3D
var rng=RandomNumberGenerator.new()
var counter=0
var stone_shader=preload("res://stone.gdshader")
func _initialize():
 call_deferred("build")
func own(n:Node):
 n.owner=scene
 for c in n.get_children(): own(c)
func bounds(n:Node3D, base:Transform3D=Transform3D.IDENTITY)->AABB:
 var t=base*n.transform
 var a=AABB();var first=true
 if n is MeshInstance3D:
  a=t*n.get_aabb();first=false
 for c in n.get_children():
  if c is Node3D:
   var b=bounds(c,t)
   if b.size.length()>0.00001:
    a=b if first else a.merge(b);first=false
 return a
func patch(n:Node, stone:bool):
 if n is MeshInstance3D:
  for s in n.mesh.get_surface_count():
   var orig=n.mesh.surface_get_material(s)
   if orig==null:continue
   var m=orig.duplicate()
   if m is StandardMaterial3D:
    m.metallic=0;m.roughness=0.91
    if stone:
     var name=orig.resource_name.to_lower()
     if name.contains("highlight"):m.albedo_color=Color(0.64,0.65,0.53)
     elif name.contains("main"):m.albedo_color=Color(0.46,0.49,0.39)
     m.vertex_color_use_as_albedo=false
    else:
     m.cull_mode=BaseMaterial3D.CULL_DISABLED
     if m.albedo_texture and not orig.resource_name.contains("Bark"):
      m.transparency=BaseMaterial3D.TRANSPARENCY_ALPHA_SCISSOR;m.alpha_scissor_threshold=0.3
    if stone and (orig.resource_name.to_lower().contains("main") or orig.resource_name.to_lower().contains("highlight")):
     var sm=ShaderMaterial.new();sm.shader=stone_shader
     sm.set_shader_parameter("base_tint",m.albedo_color)
     sm.set_shader_parameter("stone_color",load("res://assets/ambientcg/Rock030_1K-JPG_Color.jpg"))
     sm.set_shader_parameter("stone_roughness",load("res://assets/ambientcg/Rock030_1K-JPG_Roughness.jpg"))
     n.set_surface_override_material(s,sm)
    else:
     if not stone and orig.resource_name in ["Grass","Leaves","Flowers"]:m.albedo_color=Color(.70,.82,.68)
     n.set_surface_override_material(s,m)
 for c in n.get_children():patch(c,stone)
func place(kind:String,pos:Vector3,sc:float=1.0,yaw:float=0.0)->Node3D:
 var node:Node3D
 if kind.begins_with("R/"):
  var src=kit.find_child(kind.substr(2),true,false)
  if src==null:push_error(kind);return null
  node=src.duplicate();node.position=Vector3.ZERO;patch(node,true)
 else:
  node=load("res://assets/"+kind+".gltf").instantiate();patch(node,false)
 var b=bounds(node)
 var wrap=Node3D.new();wrap.name=kind.get_file()+"_%03d"%counter;counter+=1
 scene.add_child(wrap);wrap.add_child(node)
 node.position-=Vector3(b.get_center().x,b.position.y,b.get_center().z)
 wrap.scale=Vector3.ONE*sc;wrap.position=pos;wrap.rotation.y=deg_to_rad(yaw);own(wrap)
 return wrap
func box(name:String,pos:Vector3,size:Vector3,col:Color):
 var n=MeshInstance3D.new();n.name=name
 var mesh=BoxMesh.new();mesh.size=size;n.mesh=mesh
 var m=StandardMaterial3D.new();m.albedo_color=col;m.roughness=1;n.material_override=m
 scene.add_child(n);n.position=pos;n.owner=scene
func build():
 rng.seed=8221;scene=Node3D.new();scene.name="SunlitWaysideRuins";root.add_child(scene)
 kit=load("res://assets/ruins/ModularRuins.glb").instantiate()
 # Broad, gently rolling terrain is the only custom geometry, supporting imported ruins.
 var st=SurfaceTool.new();st.begin(Mesh.PRIMITIVE_TRIANGLES)
 for z in range(-35,22):
  for x in range(-28,29):
   for v in [Vector2(x,z),Vector2(x,z+1),Vector2(x+1,z),Vector2(x+1,z),Vector2(x,z+1),Vector2(x+1,z+1)]:
    var h=height(v.x,v.y);st.set_uv(v*0.11);st.add_vertex(Vector3(v.x,h,v.y))
 st.generate_normals();var ground=MeshInstance3D.new();ground.name="Meadow_continuous_terrain";ground.mesh=st.commit()
 var sh=Shader.new();sh.code="shader_type spatial; render_mode cull_disabled; uniform sampler2D soil:source_color,filter_linear_mipmap,repeat_enable; varying vec3 wp; void vertex(){wp=(MODEL_MATRIX*vec4(VERTEX,1.0)).xyz;} void fragment(){float p=sin(wp.x*.34+sin(wp.z*.29))*sin(wp.z*.39);vec3 tex=texture(soil,wp.xz*.32).rgb; ALBEDO=mix(vec3(.14,.23,.045),vec3(.27,.34,.11),.5+.45*p)*(.55+tex*1.6);ROUGHNESS=.95;}"
 var gm=ShaderMaterial.new();gm.shader=sh;gm.set_shader_parameter("soil",load("res://assets/ambientcg/Ground037_1K-JPG_Color.jpg"));ground.material_override=gm;scene.add_child(ground);ground.owner=scene
 # Pavement is modeled masonry from downloaded ruins kit: broken edges lead into grass.
 for row in range(8):
  for col in range(2):
   var k="Floor_Standard" if row%3 else "Floor_Squares"
   place("R/"+k,Vector3(-0.98+col*1.97,0.01,10-row*1.96),1.0,180 if row%2 else 0)
 # Focal entrance, open to a sunlit grove beyond. No reconstructed game/IP facade.
 place("R/Arch_Gothic",Vector3(0,0,-5.5),1.32)
 place("R/Column_Square",Vector3(-2.55,0,-5.5),1.15)
 place("R/Column_Square",Vector3(2.55,0,-5.5),1.15)
 # A supported stepped breach built from imported wall modules, no suspended chessboard bricks.
 for j in range(3):
  place("R/Wall_Half",Vector3(-3.35-j*.95,0,-5.5),1.0-j*.13)
 for j in range(3):
  place("R/Wall_Half",Vector3(3.35+j*.95,0,-5.5),.9-j*.17)
 for side in [-1,1]:
  for i in range(12):
   if (side==1 and i==2) or (side==-1 and i==8):continue
   place("R/Wall_Half",Vector3(side*2.9,0,6.3-i*.64),0.60,90)
  place("R/Column_Round_Short",Vector3(side*2.9,0,7.1),0.75)
 # Broken arch remnants and fallen masonry explain debris at the perimeter.
 place("R/Wall_ArchRound_Overgrown_Broken",Vector3(-7.2,0,-6.7),1.0,18)
 place("R/Column_Round",Vector3(6.2,0,-8),0.85,0)
 var fallen=place("R/Column_Square",Vector3(-4.3,0.23,2.5),0.65,32)
 fallen.rotation.z=deg_to_rad(84)
 for i in range(35):
  var side=-1 if i%2 else 1
  var x=side*rng.randf_range(2.2,5.4);var z=rng.randf_range(-6,7)
  place("R/Bricks" if i%4==0 else "R/Brick",Vector3(x,0.02,z),rng.randf_range(.30,.68),rng.randf_range(0,360))
 # Vine sheets climb the vertical support surfaces instead of floating in the path.
 for spec in [Vector3(-2.55,.08,-5.07),Vector3(2.55,1.0,-5.04),Vector3(-3.9,.2,-5.03)]:
  place("village/Prop_Vine1",spec,0.85,0)
 place("village/Prop_Vine2",Vector3(2.7,.05,-5.1),.8)
 # Imported grass mesh distribution follows erosion edges; center remains readable.
 for i in range(1350):
  var x=rng.randf_range(-17,17);var z=rng.randf_range(-19,14)
  if abs(x)<1.8 and z>-5.5 and z<11:continue
  if abs(x)<2.8 and z<-5 and z>-6.3:continue
  place("nature/Grass_Common_Short" if i%3 else "nature/Grass_Common_Short",Vector3(x,height(x,z)-.025,z),rng.randf_range(.18,.37),rng.randf_range(0,360))
 for i in range(150):
  var side=-1 if i%2 else 1;var z=rng.randf_range(-5,11);var x=side*rng.randf_range(1.55,2.7)
  place("nature/Grass_Wispy_Short",Vector3(x,.05,z),rng.randf_range(.15,.31),rng.randf_range(0,360))
 for i in range(26):
  var x=rng.randf_range(-1.8,1.8);var z=round(rng.randf_range(-4,10)/1.96)*1.96+.18
  place("nature/Grass_Common_Short",Vector3(x,.075,z),rng.randf_range(.11,.20),rng.randf_range(0,360))
 var saved_distribution_state=rng.state
 for i in range(900):
  var side=-1 if i%2 else 1;var x=side*rng.randf_range(2.3,6.0);var z=rng.randf_range(-7.0,11.0)
  var p=Vector3(x,height(x,z)-.02,z)
  place("nature/Grass_Common_Short",p,rng.randf_range(.24,.43),rng.randf_range(0,360))
 rng.state=saved_distribution_state
 for center in [Vector3(-3.9,0,4.7),Vector3(-2.3,0,-4),Vector3(5,0,-6)]:
  for i in range(7):
   var p=center+Vector3(rng.randf_range(-1.0,1),0,rng.randf_range(-1.2,1.2));p.y=height(p.x,p.z)
   place("nature/Flower_3_Group" if i%3 else "nature/Flower_4_Group",p,rng.randf_range(.17,.30),rng.randf_range(0,360))
 for spec in [Vector3(-8,0,0),Vector3(9,0,-4),Vector3(-12,0,-12),Vector3(15,0,-15),Vector3(-9,0,-18),Vector3(14,0,-18),Vector3(-15,0,-9)]:
  spec.y=height(spec.x,spec.z);place("nature/CommonTree_1" if int(spec.x)%2 else "nature/CommonTree_3",spec,rng.randf_range(.85,1.35),rng.randf_range(0,360))
 for i in range(24):
  var side=-1 if i%2 else 1;var x=side*rng.randf_range(6,18);var z=rng.randf_range(-23,6)
  place("nature/Rock_Medium_1",Vector3(x,height(x,z)-.1,z),rng.randf_range(.28,.65),rng.randf_range(0,360))
 for p in [Vector3(-4.3,0,-4.2),Vector3(4.4,0,-5.1),Vector3(-3.9,0,2.5),Vector3(6.3,0,-7.7)]:
  place("nature/Fern_1",p,.9,23);place("nature/Clover_1",p+Vector3(.4,0,.2),.75,100)
 # A small abandoned offering group remains under the lee of the left pillar.
 place("R/Pot1_Broken",Vector3(-3.0,.02,-4.2),.8,24)
 place("R/Pot2",Vector3(-3.6,.02,-4.5),.7,-12)
 place("R/Statue_Fox",Vector3(0,.0,-10),.8,180)
 var env=WorldEnvironment.new();env.name="ClearDay";var e=Environment.new();env.environment=e
 e.background_mode=Environment.BG_SKY;var sky=Sky.new();var sm=ProceduralSkyMaterial.new();sm.sky_top_color=Color(.22,.48,.67);sm.sky_horizon_color=Color(.68,.80,.82);sm.ground_horizon_color=Color(.6,.68,.59);sky.sky_material=sm;e.sky=sky
 e.ambient_light_source=Environment.AMBIENT_SOURCE_COLOR;e.ambient_light_color=Color(.72,.82,.94);e.ambient_light_energy=.38
 e.tonemap_mode=Environment.TONE_MAPPER_FILMIC;e.tonemap_exposure=.88;e.ssao_enabled=true;e.ssao_radius=1.6;e.ssao_intensity=1.35
 e.fog_enabled=true;e.fog_light_color=Color(.68,.79,.80);e.fog_density=.0015
 scene.add_child(env);env.owner=scene
 var sun=DirectionalLight3D.new();sun.name="LateMorningSun";sun.rotation_degrees=Vector3(-47,-32,0);sun.light_color=Color(1.0,.97,.88);sun.light_energy=1.1;sun.shadow_enabled=true;sun.directional_shadow_max_distance=70
 scene.add_child(sun);sun.owner=scene
 for data in [["Overall",Vector3(8.4,5.6,14.4),Vector3(0,1.5,-3.4),55.0],["Detail",Vector3(-6.5,2.3,1.8),Vector3(-2.0,1.6,-5.3),53.0],["Transition",Vector3(3.8,1.5,9),Vector3(0,.2,2.5),58.0]]:
  var c=Camera3D.new();c.name=data[0];scene.add_child(c);c.owner=scene;c.position=data[1];c.look_at(data[2]);c.fov=data[3];c.current=data[0]=="Overall"
 var packed=PackedScene.new();packed.pack(scene);ResourceSaver.save(packed,"res://sunlit_ruins.tscn")
 print("SCENE BUILT: ",counter," asset instances")
 kit.free();quit()
func height(x:float,z:float)->float:
 var edge=smoothstep(3.0,11.0,abs(x));return edge*(.45+.45*sin(x*.22+z*.14)) + smoothstep(12,27,-z)*1.5
