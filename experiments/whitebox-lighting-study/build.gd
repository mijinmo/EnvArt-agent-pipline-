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
func concrete(id:String,tint:Color,freq:float,rough:float):
 var m=solid(tint,rough)
 m.albedo_texture=load("res://assets/"+id+"/Diffuse.jpg")
 m.normal_enabled=true;m.normal_texture=load("res://assets/"+id+"/nor_gl.jpg");m.normal_scale=0.25
 m.roughness_texture=null # Fixed calibrated roughness; retains source albedo and normal.
 m.uv1_triplanar=true;m.uv1_world_triplanar=true;m.uv1_scale=Vector3.ONE*freq
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
func base_lighting(r:Node,lit:bool):
 var g=Node3D.new();g.name="Lighting";r.add_child(g)
 var sun=DirectionalLight3D.new();sun.name="LabSun";g.add_child(sun);sun.rotation_degrees=Vector3(-48,-32,0);sun.light_energy=1.4;sun.light_color=Color(1,0.92,0.8);sun.shadow_enabled=true;sun.directional_shadow_max_distance=70
 var env=Environment.new();env.background_mode=Environment.BG_SKY
 var sky=Sky.new();var sm=ProceduralSkyMaterial.new();sm.sky_top_color=Color(0.19,0.32,0.47);sm.sky_horizon_color=Color(0.65,0.74,0.8);sm.ground_bottom_color=Color(0.12,0.16,0.22);sm.ground_horizon_color=Color(0.65,0.74,0.8);sky.sky_material=sm;env.sky=sky
 env.ambient_light_source=3;env.ambient_light_color=Color(0.65,0.77,0.9);env.ambient_light_energy=0.65;env.reflected_light_source=2;env.tonemap_mode=Environment.TONE_MAPPER_FILMIC
 if lit:
  env.ambient_light_source=Environment.AMBIENT_SOURCE_COLOR
  sun.rotation_degrees=Vector3(-38,-55,0);sun.light_energy=0.7;sun.light_color=Color(1,0.88,0.68);sun.light_angular_distance=1.5
  sm.sky_top_color=Color(0.035,0.055,0.08);sm.sky_horizon_color=Color(0.14,0.17,0.2);sm.ground_bottom_color=Color(0.055,0.06,0.07);sm.ground_horizon_color=Color(0.14,0.17,0.2)
  env.ambient_light_energy=0.42;env.ambient_light_color=Color(0.48,0.61,0.69)
  env.ssao_enabled=true;env.ssao_radius=0.6;env.ssao_intensity=1.3;env.ssil_enabled=true;env.ssil_radius=3;env.ssil_intensity=0.45
  env.ssr_enabled=true;env.tonemap_exposure=1.05
  spot(g,"PortalWarm",Vector3(0,2.64,-3.55),Vector3(0,0,-2.8),Color(1,0.73,0.39),4.0,8,68)
  spot(g,"RecordsTask",Vector3(8.75,3.35,-7.1),Vector3(8.5,0,-7.1),Color(1,0.83,0.55),5.0,7,64)
  spot(g,"RampFlood",Vector3(-6,3.8,-11.5),Vector3(-6,0,-2),Color(0.72,0.86,1),5.0,14,45)
  spot(g,"DeskLamp",Vector3(8.75,1.33,-7.7),Vector3(8.55,0.78,-7.25),Color(1,0.7,0.32),1.5,2,52)
  var bounce=OmniLight3D.new();bounce.name="WarmFloorBounce_Approximation";bounce.position=Vector3(7.7,0.6,-7);bounce.light_color=Color(0.75,0.62,0.42);bounce.light_energy=0.45;bounce.omni_range=4;bounce.shadow_enabled=false;g.add_child(bounce)
  var fill=OmniLight3D.new();fill.name="OpenSkyFill_Approximation";fill.position=Vector3(-2,5,3);fill.light_color=Color(0.56,0.7,0.86);fill.light_energy=1.1;fill.omni_range=18;fill.shadow_enabled=true;g.add_child(fill)
  var rp=ReflectionProbe.new();rp.name="RecordsReflection";rp.position=Vector3(6,1.8,-6);rp.size=Vector3(10,5,12);rp.interior=false;rp.box_projection=true;g.add_child(rp)
 var w=WorldEnvironment.new();w.name="Environment";w.environment=env;g.add_child(w)
func spot(g:Node,n:String,p:Vector3,target:Vector3,col:Color,energy:float,rangeval:float,angle:float):
 var l=SpotLight3D.new();l.name=n;g.add_child(l);l.position=p;l.look_at(target,Vector3.FORWARD if abs((target-p).normalized().dot(Vector3.UP))>0.99 else Vector3.UP);l.light_color=col;l.light_energy=energy;l.spot_range=rangeval;l.spot_angle=angle;l.spot_attenuation=1.0;l.shadow_enabled=true;l.shadow_bias=0.035;l.shadow_normal_bias=0.4
func run():
 art=Node3D.new();art.name="ArtContent";root.add_child(art)
 var w=load("res://source/whitebox.tscn").instantiate();art.add_child(w);w.scene_file_path=""
 mats.wall=concrete("concrete_wall_009",Color(0.68,0.66,0.59),0.28,0.95)
 mats.floor=concrete("concrete_floor_worn_001",Color(0.42,0.44,0.42),0.4,0.72)
 mats.ramp=concrete("concrete_floor_worn_001",Color(0.51,0.50,0.43),0.65,0.85)
 mats.metal=solid(Color(0.10,0.13,0.12),0.48,0.6);mats.yellow=solid(Color(0.62,0.39,0.055),0.68);mats.black=solid(Color(0.04,0.045,0.04),0.7);mats.paper=solid(Color(0.68,0.64,0.48),0.9)
 mats.emit=solid(Color(0.9,0.77,0.45),0.35);mats.emit.emission_enabled=true;mats.emit.emission=Color(1,0.78,0.45);mats.emit.emission_energy_multiplier=2.5
 for body in w.get_node("World").get_children():
  var m=body.get_node("Mesh")
  m.material_override=mats.floor if body.name in ["Floor","SpawnPad"] else (mats.ramp if body.name.begins_with("Step") or body.name.begins_with("Jump") or body.name in ["Ramp","Landing"] else mats.wall)
 decor=Node3D.new();decor.name="Art_Added";art.add_child(decor)
 # Door face adapters remain outside aperture x +/-0.6 and y<2.3.
 for x in [-0.655,0.655]:
  box("PortalFaceJamb",Vector3(x,1.15,-3.688),Vector3(0.09,2.3,0.018),mats.metal)
 box("PortalFaceHeader",Vector3(0,2.36,-3.687),Vector3(1.4,0.1,0.02),mats.metal)
 box("PortalLightHousing",Vector3(0,2.64,-3.80),Vector3(1.8,0.08,0.26),mats.metal)
 box("PortalLightLens",Vector3(0,2.593,-3.72),Vector3(1.55,0.012,0.16),mats.emit)
 box("DoorSign",Vector3(0,2.49,-3.68),Vector3(1.5,0.17,0.02),mats.black)
 label("DoorTypography","RECORDS  /  04",Vector3(0,2.49,-3.662),44,0.0021)
 box("AccessPanel",Vector3(1.05,1.35,-3.66),Vector3(0.24,0.31,0.07),mats.metal)
 label("AccessNumber","04",Vector3(1.05,1.39,-3.619),42,0.002)
 # Thin wall surface seams; no change to wall or playable geometry.
 for x in range(-10,12,2):box("BackWallSeam",Vector3(x,2,-11.746),Vector3(0.012,3.96,0.006),mats.black)
 box("BackWallJoint",Vector3(0,1.1,-11.746),Vector3(24,0.012,0.006),mats.black)
 box("BackWallSkirting",Vector3(0,0.12,-11.73),Vector3(24,0.24,0.03),mats.metal)
 for z in [-10,-8,-6,-4,-2]:box("EastWallSeam",Vector3(9.746,1.5,z),Vector3(0.006,2.98,0.012),mats.black)
 # Paint-only floor strips outside ramp width; no rail or prop on ramp.
 for x in [-7.61,-4.39]:box("RampApproachPaint",Vector3(x,0.004,-2.8),Vector3(0.08,0.006,6.4),mats.yellow)
 for k in range(8):
  box("RampSafetyDash",Vector3(-7.92,0.005,-0.1-k*0.75),Vector3(0.4,0.007,0.13),mats.yellow)
 # Stair nosing strips lie on vertical front faces, not over tread geometry.
 for i in range(4):box("StepFaceMark",Vector3(5,0.2*(i+1)-0.04,2.301-i*0.6),Vector3(1.96,0.05,0.003),mats.yellow)
 # Wall-side records station uses imported furniture; no new enclosure.
 asset("metal_office_desk","TransferDesk",Vector3(8.95,0,-6.9),0.95,-90)
 asset("mid_century_lounge_chair","ClerkChair",Vector3(7.75,0,-6.85),0.68,80)
 asset("desk_lamp_arm_01","TaskLamp",Vector3(8.9,0.748,-7.6),0.65,170)
 asset("binder_notebook","OpenLedger",Vector3(8.8,0.749,-6.8),1.25,-60,0,"binder_notebook")
 asset("vintage_radio_transceiver","TransferRadio",Vector3(9.05,0.749,-6.25),1,-90)
 for i in range(3):asset("3td/OfficeFileCabinet_01","ArchiveCabinet"+str(i),Vector3(9.23,0,-8.7-i*0.8),0.30,180,0)
 asset("cardboard_box_01","IncomingCarton",Vector3(8.8,0,-5.65),1.35,7)
 asset("cardboard_box_01","CartonOnCabinet",Vector3(9.23,1.6342,-9.5),1.1,14)
 asset("binder_notebook","ClosedFile",Vector3(9.2,1.6352,-8.7),1.2,5,0,"binder_notebook_closed")
 for i in range(4):box("TransferSheet",Vector3(8.7+i*0.012,0.753+i*0.0015,-7.15+i*0.018),Vector3(0.22,0.001,0.31),mats.paper)
 # Working bay markings are only surface paint.
 for z in [-10.9,-5.05]:box("StationPaint",Vector3(8.45,0.004,z),Vector3(2.3,0.006,0.07),mats.yellow)
 box("StationPaintEdge",Vector3(7.32,0.004,-7.98),Vector3(0.07,0.006,5.8),mats.yellow)
 var sign=label("RecordsStation","RECORDS TRANSFER\nINTAKE  /  04",Vector3(9.735,2.3,-7.5),62,0.003);sign.rotation_degrees.y=-90
 box("WorklightBracket",Vector3(9.3,3.28,-7.1),Vector3(0.9,0.08,0.08),mats.metal)
 box("WorklightHousing",Vector3(8.85,3.34,-7.1),Vector3(0.35,0.13,1.8),mats.metal)
 box("WorklightLens",Vector3(8.85,3.267,-7.1),Vector3(0.27,0.014,1.6),mats.emit)
 box("RampFloodHousing",Vector3(-6,3.8,-11.6),Vector3(0.6,0.22,0.22),mats.metal)
 box("RampFloodLens",Vector3(-6,3.77,-11.47),Vector3(0.5,0.13,0.015),mats.emit)
 save(art,"res://art_content.tscn")
 art.queue_free()
 await process_frame
 for mode in ["whitebox_review","art_base","art_lit"]:
  var scene=Node3D.new();scene.name=mode;root.add_child(scene)
  var content=load("res://source/whitebox.tscn" if mode=="whitebox_review" else "res://art_content.tscn").instantiate()
  scene.add_child(content);content.owner=scene
  cams(scene);base_lighting(scene,mode=="art_lit")
  # Preserve content as linked native instance rather than repacking descendants.
  for child in scene.get_children():
   child.owner=scene
   if child!=content:own(child,scene)
  var pack=PackedScene.new();pack.pack(scene);ResourceSaver.save(pack,"res://"+mode+".tscn")
  scene.queue_free();await process_frame
 print("BUILD_OK")
 await process_frame
 quit()
