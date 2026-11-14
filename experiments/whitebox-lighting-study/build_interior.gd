extends SceneTree
var art:Node3D
var decor:Node3D
var mats={}
var cameras={"overall":[Vector3(-18,15,21),Vector3(0,0,-3),58.0],"door":[Vector3(-0.2,1.65,-0.7),Vector3(0,1.3,-4),60.0],"ramp":[Vector3(-10.2,3.4,2.8),Vector3(-6,1,-3.5),56.0],"props":[Vector3(5.7,2.0,-4.6),Vector3(8.8,0.9,-7.6),58.0]}
func _initialize():
 call_deferred("run")
func own(n:Node,r:Node):
 for c in n.get_children():
  c.owner=r
  own(c,r)
func save(n:Node,p:String):
 own(n,n)
 var pack=PackedScene.new()
 pack.pack(n)
 ResourceSaver.save(pack,p)
func solid(c:Color,r=0.6,metal=0.0):
 var m=StandardMaterial3D.new()
 m.albedo_color=c;m.roughness=r;m.metallic=metal
 return m
func box(n:String,p:Vector3,size:Vector3,m:Material,parent:Node=decor):
 var v=MeshInstance3D.new();v.name=n;v.position=p
 var b=BoxMesh.new();b.size=size;v.mesh=b;v.material_override=m;parent.add_child(v)
 return v
func label(n:String,t:String,p:Vector3,size:int=56,scaleval:float=0.0025):
 var l=Label3D.new();l.name=n;l.text=t;l.font_size=size;l.pixel_size=scaleval;l.position=p;l.modulate=Color(0.85,0.82,0.66);l.no_depth_test=false;l.outline_size=0;decor.add_child(l)
 return l
func extract_meshes(n:Node,xf:Transform3D,out:Node3D):
 var nx=xf
 if n is Node3D:nx=xf*n.transform
 if n is MeshInstance3D:
  var v=MeshInstance3D.new();v.name=n.name;v.mesh=n.mesh;v.transform=nx;v.material_override=n.material_override
  for i in n.get_surface_override_material_count():v.set_surface_override_material(i,n.get_surface_override_material(i))
  out.add_child(v)
 for c in n.get_children():extract_meshes(c,nx,out)
func asset(id:String,n:String,p:Vector3,scaleval=1.0,yaw=0.0,fixx=0.0,variant=""):
 var path="res://assets/"+id+"/"+id.get_file()+(".glb" if id.begins_with("3td") else ".gltf")
 var src=load(path).instantiate()
 var group=Node3D.new();group.name=n;decor.add_child(group)
 extract_meshes(src,Transform3D.IDENTITY,group);src.free()
 if variant!="":
  for c in group.get_children():
   if c.name!=variant:c.free()
 var basis=Basis(Vector3.UP,deg_to_rad(yaw))*Basis(Vector3.RIGHT,deg_to_rad(fixx))
 var bounds:AABB;var first=true
 for c in group.get_children():
  c.transform=Transform3D(basis.scaled(Vector3.ONE*scaleval),Vector3.ZERO)*c.transform
  var a=c.transform*c.get_aabb()
  if first:bounds=a;first=false
  else:bounds=bounds.merge(a)
 var offset=Vector3(-bounds.get_center().x,-bounds.position.y,-bounds.get_center().z)
 for c in group.get_children():c.position+=offset
 group.position=p
 print("PLACED ",n," size ",bounds.size," base ",p)
 return group
func cams(r:Node):
 var g=Node3D.new();g.name="Cameras";r.add_child(g)
 for n in cameras:
  var c=Camera3D.new();c.name=n;c.position=cameras[n][0];g.add_child(c);c.look_at(cameras[n][1]);c.fov=cameras[n][2];c.far=120;c.current=n=="overall"
func spot(g:Node,n:String,p:Vector3,target:Vector3,col:Color,energy:float,rangeval:float,angle:float):
 var l=SpotLight3D.new();l.name=n;g.add_child(l);l.position=p;l.look_at(target,Vector3.FORWARD if abs((target-p).normalized().dot(Vector3.UP))>0.99 else Vector3.UP);l.light_color=col;l.light_energy=energy;l.spot_range=rangeval;l.spot_angle=angle;l.spot_attenuation=1.0;l.shadow_enabled=true;l.shadow_bias=0.035;l.shadow_normal_bias=0.4
func new_cameras(scene):
 var cg=scene.get_node("Cameras")
 for c in cg.get_children():c.free()
 cameras={"room":[Vector3(3.3,2.15,-3.5),Vector3(8.4,2.1,-8.1),67.0],"props":[Vector3(5.7,2,-4.6),Vector3(8.8,0.9,-7.6),58.0],"door":[Vector3(-0.2,1.65,-0.7),Vector3(0,1.3,-4),60.0]}
 cg.free();cams(scene)
 scene.get_node("Cameras/room").current=true
func run():
 var before=load("res://art_lit.tscn").instantiate();root.add_child(before)
 new_cameras(before);save(before,"res://interior_before.tscn");before.free()
 var scene=Node3D.new();scene.name="RecordsInterior";root.add_child(scene)
 art=load("res://art_content.tscn").instantiate();scene.add_child(art);art.scene_file_path=""
 decor=art.get_node("Art_Added")
 for c in decor.get_children():
  if c is MeshInstance3D and c.mesh is BoxMesh:
   var sz=c.mesh.size
   if sz.is_equal_approx(Vector3(0.012,3.96,0.006)) or sz.is_equal_approx(Vector3(0.006,2.98,0.012)) or sz.is_equal_approx(Vector3(2.3,0.006,0.07)):
    c.free()
 for c in decor.get_children():
  if str(c.name).begins_with("BackWallSeam") or str(c.name).begins_with("EastWallSeam") or str(c.name)=="BackWallJoint" or str(c.name).begins_with("Worklight") or str(c.name).begins_with("StationPaint"):
   c.free()
 var wall=ShaderMaterial.new();wall.shader=load("res://continuous_concrete.gdshader")
 wall.set_shader_parameter("concrete_color",load("res://assets/smooth_concrete_floor/Diffuse.jpg"))
 wall.set_shader_parameter("concrete_rough",load("res://assets/smooth_concrete_floor/Rough.jpg"))
 for n in ["BackWall","OcclusionWall","OcclusionReturn","DoorLeft","DoorRight","DoorLintel"]:art.get_node("Whitebox/World/"+n+"/Mesh").material_override=wall
 mats.metal=solid(Color(0.095,0.11,0.105),0.48,0.55)
 mats.paper=solid(Color(0.73,0.70,0.61),0.85)
 mats.emit=solid(Color(0.88,0.91,0.83),0.4);mats.emit.emission_enabled=true;mats.emit.emission=Color(0.84,0.92,0.88);mats.emit.emission_energy_multiplier=2
 # Complete the enclosure outside the original play floor, without moving any original body.
 box("OuterWest",Vector3(-16.2,2.75,0),Vector3(0.4,5.5,32.8),wall)
 box("OuterEast",Vector3(16.2,2.75,0),Vector3(0.4,5.5,32.8),wall)
 box("OuterNorth",Vector3(0,2.75,-16.2),Vector3(32,5.5,0.4),wall)
 box("OuterSouth",Vector3(0,2.75,16.2),Vector3(32,5.5,0.4),wall)
 box("EastUpper",Vector3(10,4.25,-6),Vector3(0.5,2.5,10),wall)
 box("ReturnUpper",Vector3(8,4.25,-1),Vector3(4,2.5,0.5),wall)
 box("BackUpper",Vector3(0,4.75,-12),Vector3(24,1.5,0.5),wall)
 box("PortalUpperPier",Vector3(0,4.05,-4),Vector3(2.6,2.9,0.6),wall)
 # A small incoming-records noticeboard on the existing rear wall.
 box("NoticeFrame",Vector3(5.7,1.85,-11.705),Vector3(1.05,1.15,0.065),mats.metal)
 box("NoticeBacking",Vector3(5.7,1.85,-11.666),Vector3(0.98,1.08,0.015),solid(Color(0.22,0.24,0.22),0.9))
 for i in range(3):
  var x=5.41+i*0.29
  box("NoticeSheet",Vector3(x,1.85+(0.08 if i==1 else 0),-11.651),Vector3(0.25,0.44,0.004),mats.paper)
  var t=label("NoticeText","INTAKE\n"+str(21+i)+"\n________\n________\n________",Vector3(x,1.87+(0.08 if i==1 else 0),-11.646),26,0.0006);t.modulate=Color(0.08,0.09,0.08)
 label("NoticeHeading","DAILY TRANSFERS",Vector3(5.7,2.29,-11.642),32,0.0013)
 # Four contiguous roof pieces leave one actual 3 x 5 m daylight opening.
 box("RoofWest",Vector3(-6,5.65,0),Vector3(20,0.3,32),wall)
 box("RoofEast",Vector3(11.5,5.65,0),Vector3(9,0.3,32),wall)
 box("RoofNorth",Vector3(5.5,5.65,-13),Vector3(3,0.3,6),wall)
 box("RoofSouth",Vector3(5.5,5.65,5.5),Vector3(3,0.3,21),wall)
 for x in [4.05,6.95]:box("SkylightReveal",Vector3(x,5.9,-7.5),Vector3(0.10,0.8,5),mats.metal)
 for z in [-9.95,-5.05]:box("SkylightEnd",Vector3(5.5,5.9,z),Vector3(3,0.8,0.1),mats.metal)
 for z in [-8.35,-6.65]:box("SkylightMullion",Vector3(5.5,6.24,z),Vector3(3,0.08,0.06),mats.metal)
 var glass=solid(Color(0.62,0.75,0.82,0.16),0.12,0.1);glass.transparency=BaseMaterial3D.TRANSPARENCY_ALPHA
 var glazing=box("SkylightGlazing",Vector3(5.5,6.26,-7.5),Vector3(2.9,0.018,4.9),glass);glazing.cast_shadow=GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
 # A supported suspended office luminaire and continuous service conduit.
 box("OfficeHousing",Vector3(8.85,3.7,-7.1),Vector3(0.32,0.12,2.4),mats.metal)
 box("OfficeLens",Vector3(8.85,3.633,-7.1),Vector3(0.25,0.014,2.22),mats.emit)
 for z in [-8.05,-6.15]:box("Suspension",Vector3(8.85,4.58,z),Vector3(0.018,1.76,0.018),mats.metal)
 box("EastConduit",Vector3(9.71,3.2,-7.5),Vector3(0.045,0.055,7.5),mats.metal)
 box("ConduitDrop",Vector3(9.71,1.7,-6),Vector3(0.045,3,0.045),mats.metal)
 box("SwitchBox",Vector3(9.69,1.25,-6),Vector3(0.09,0.18,0.13),mats.metal)
 var title=decor.get_node("RecordsStation");title.text="RECORDS TRANSFER";title.pixel_size=0.0023;title.position.y=2.7
 var sub=label("StationSubline","INTAKE  /  04",Vector3(9.732,2.42,-7.5),42,0.002);sub.rotation_degrees.y=-90
 asset("binder_notebook","FileOnDesk",Vector3(9.15,0.75,-7.1),0.95,-85,0,"binder_notebook_closed")
 # Cabinet labels and papers: actual small details tied to use, not extra crate rows.
 for i in range(3):
  for k in range(4):
   var t=label("CabinetIndex",str(21+i)+" - "+str(k+1),Vector3(8.94,0.34+k*0.37,-8.7-i*0.8),24,0.0007);t.rotation_degrees.y=-90
 # Low plinth along the existing wall, no narrowing of the doorway.
 box("EastBaseboard",Vector3(9.72,0.08,-6),Vector3(0.035,0.16,9.9),mats.metal)
 var cg=Node3D.new();cg.name="Cameras";scene.add_child(cg);new_cameras(scene)
 var lg=Node3D.new();lg.name="Lighting";scene.add_child(lg)
 var env=Environment.new();env.background_mode=Environment.BG_SKY
 var sky=Sky.new();var sm=ProceduralSkyMaterial.new();sm.sky_top_color=Color(0.23,0.32,0.40);sm.sky_horizon_color=Color(0.6,0.66,0.69);sky.sky_material=sm;env.sky=sky
 env.ambient_light_source=Environment.AMBIENT_SOURCE_COLOR;env.ambient_light_color=Color(0.62,0.69,0.72);env.ambient_light_energy=0.28
 env.tonemap_mode=Environment.TONE_MAPPER_FILMIC;env.tonemap_exposure=1.0;env.ssao_enabled=true;env.ssao_radius=0.35;env.ssao_intensity=0.85;env.ssil_enabled=true;env.ssil_radius=3;env.ssil_intensity=0.45
 var we=WorldEnvironment.new();we.name="Environment";we.environment=env;lg.add_child(we)
 spot(lg,"SkylightDaylight",Vector3(5.5,5.45,-7.5),Vector3(8,0,-8),Color(0.86,0.92,1),5.0,13,67)
 spot(lg,"OfficePractical",Vector3(8.85,3.60,-7.1),Vector3(8.5,0,-7.1),Color(0.88,1,0.92),3.5,7,69)
 spot(lg,"DeskTask",Vector3(8.75,1.33,-7.7),Vector3(8.55,0.78,-7.25),Color(1,0.73,0.42),1.3,2,52)
 spot(lg,"DoorPractical",Vector3(0,2.59,-3.55),Vector3(0,0,-3.2),Color(1,0.9,0.74),2,6,65)
 for l in lg.get_children():
  if l is SpotLight3D:l.light_size=0.25;l.shadow_blur=1.0;l.shadow_normal_bias=0.5;l.shadow_bias=0.06
 var bounce=OmniLight3D.new();bounce.name="SkylightBounceApproximation";bounce.position=Vector3(5.4,2,-8);bounce.light_color=Color(0.73,0.81,0.9);bounce.light_energy=1.1;bounce.omni_range=10;lg.add_child(bounce)
 var rp=ReflectionProbe.new();rp.name="RoomReflection";rp.position=Vector3(5,2,-7);rp.size=Vector3(10,5,10);rp.interior=true;rp.box_projection=true;lg.add_child(rp)
 save(scene,"res://interior.tscn")
 print("INTERIOR_BUILT")
 scene.queue_free()
 await process_frame
 await process_frame
 quit()
