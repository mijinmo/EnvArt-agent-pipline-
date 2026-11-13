extends SceneTree
var scene:Node3D
var mats={}
func _initialize():
 call_deferred('build')
func add(n:Node,name:String,p:Vector3=Vector3.ZERO):
 n.name=name;scene.add_child(n);n.owner=scene
 if n is Node3D:n.position=p
 return n
func mat(name:String,c:Color,rough:float=0.7,metal:float=0.0):
 var m=StandardMaterial3D.new();m.albedo_color=c;m.roughness=rough;m.metallic=metal;mats[name]=m;return m
func box(name:String,p:Vector3,size:Vector3,m:Material):
 var n=MeshInstance3D.new();var mesh=BoxMesh.new();mesh.size=size;n.mesh=mesh;n.material_override=m;return add(n,name,p)
func cyl(name:String,p:Vector3,r:float,h:float,m:Material):
 var n=MeshInstance3D.new();var mesh=CylinderMesh.new();mesh.top_radius=r;mesh.bottom_radius=r;mesh.height=h;mesh.radial_segments=24;n.mesh=mesh;n.material_override=m;return add(n,name,p)
func text3(t:String,p:Vector3,size:int=48,color:Color=Color(0.84,0.82,0.7),scale_px:float=0.006):
 var n=Label3D.new();n.text=t;n.font_size=size;n.pixel_size=scale_px;n.modulate=color;n.outline_size=0;n.no_depth_test=false;add(n,'Wayfinding',p);return n
func bounds(n:Node3D,t:Transform3D=Transform3D.IDENTITY)->AABB:
 var result=AABB();var first=true
 for c in n.get_children():
  if c is Node3D:
   var tr=t*c.transform
   var b=AABB()
   if c is MeshInstance3D:b=tr*c.get_aabb()
   else:b=bounds(c,tr)
   if b.size.length()>0.001:
    if first:result=b;first=false
    else:result=result.merge(b)
 return result
func model(id:String,path:String,pos:Vector3,width:float,rot:float=0.0):
 var p=load(path)
 if p==null:push_error(path);return null
 var n=p.instantiate();var a=bounds(n);var sc=width/a.size.x
 var frame=Node3D.new();add(frame,id,pos);frame.rotation.y=deg_to_rad(rot);frame.add_child(n);n.owner=scene
 n.scale=Vector3.ONE*sc;n.position=Vector3(-a.get_center().x,-a.position.y,-a.get_center().z)*sc
 print(id,' bounds=',a,' scale=',sc)
 return frame
func light(p:Vector3,color:Color,energy:float,r:float):
 var n=OmniLight3D.new();n.light_color=color;n.light_energy=energy;n.omni_range=r;n.shadow_enabled=true;add(n,'PracticalLight',p)
func build():
 scene=Node3D.new();scene.name='RecordsAnnex';root.add_child(scene)
 var concrete=mat('Concrete',Color(0.72,0.74,0.7));concrete.albedo_texture=load('res://assets/concrete/Diffuse.jpg');concrete.normal_enabled=true;concrete.normal_texture=load('res://assets/concrete/nor_gl.jpg');concrete.normal_scale=0.38;concrete.roughness_texture=load('res://assets/concrete/Rough.jpg');concrete.uv1_triplanar=true;concrete.uv1_scale=Vector3.ONE*0.34
 var floor=concrete.duplicate();floor.albedo_color=Color(0.23,0.25,0.23);floor.roughness_texture=null;floor.roughness=0.32;floor.normal_scale=0.14;floor.uv1_scale=Vector3.ONE*0.23
 var dark=mat('BlackenedSteel',Color(0.04,0.055,0.052),0.37,0.65)
 var trim=mat('BrushedAluminum',Color(0.24,0.27,0.26),0.26,0.85)
 var yellow=mat('SafetyOchre',Color(0.64,0.44,0.06),0.6)
 var paper=mat('Paper',Color(0.62,0.59,0.45),0.9)
 var red=mat('BureauRed',Color(0.31,0.025,0.018),0.53)
 var white=mat('Fluorescent',Color(0.65,0.79,0.7),0.3);white.emission_enabled=true;white.emission=Color(0.65,0.8,0.72);white.emission_energy_multiplier=3.0
 # Structural shell; repeating real-world casting dimensions and recessed joints.
 box('PolishedConcreteFloor',Vector3(0,-0.15,0),Vector3(13,0.3,15),floor)
 box('CeilingSlab',Vector3(0,5.2,-1),Vector3(13,0.35,14),concrete)
 for x in [-5.7,-1.3,5.7]:
  box('LoadBearingPier',Vector3(x,2.6,-4.7),Vector3(0.8,5.2,1.1),concrete)
 box('LeftWall',Vector3(-6.25,2.6,-0.7),Vector3(0.35,5.2,14),concrete)
 # rear portal is an actual opening into lit vestibule.
 box('ArchiveBackWall',Vector3(-2.7,2.6,-5.5),Vector3(6.9,5.2,0.35),concrete)
 box('DoorRightPier',Vector3(5.15,2.6,-5.5),Vector3(1.9,5.2,0.35),concrete)
 box('PortalLintel',Vector3(2.65,4.4,-5.5),Vector3(3.1,1.6,0.35),concrete)
 box('VestibuleEnd',Vector3(2.6,2.5,-8),Vector3(6,5,0.3),concrete)
 for x in [0.95,4.25]:box('PortalSteelJamb',Vector3(x,1.75,-5.25),Vector3(0.12,3.5,0.28),dark)
 box('PortalSteelHead',Vector3(2.6,3.5,-5.25),Vector3(3.4,0.14,0.28),dark)
 for z in [-4.5,-1.0,2.5]:box('CeilingBeam',Vector3(0,4.75,z),Vector3(12.3,0.6,0.4),concrete)
 for x in range(-6,7,2):box('FloorExpansionJoint',Vector3(x,0.003,-0.5),Vector3(0.012,0.004,14),dark)
 for z in range(-7,8,2):box('FloorExpansionJoint',Vector3(0,0.004,z),Vector3(12.4,0.004,0.012),dark)
 for x in [-5.8,-3.9,-2.0,-0.1]:
  for y in [1.1,2.5,3.9]:
   var bolt=cyl('FormTieRecess',Vector3(x,y,-5.31),0.028,0.008,dark);bolt.rotation.x=PI/2
 # Supplied office cabinet and divider models form the archive and workstation enclosure.
 for i in range(5):model('ArchiveCabinet_%02d'%i,'res://assets/3td/OfficeFileCabinet_01/OfficeFileCabinet_01.glb',Vector3(-4.9+i*0.72,0,-4.7),0.67,0)
 for z in [-2.5,-0.55]:model('OfficePartition','res://assets/3td/OfficeDivider_02/OfficeDivider_02.glb',Vector3(-4.5,0,z),1.88,90)
 model('InspectionDesk','res://assets/metal_office_desk/metal_office_desk.gltf',Vector3(-1.7,0,-1.5),2.5,180)
 model('TaskLamp','res://assets/desk_lamp_arm_01/desk_lamp_arm_01.gltf',Vector3(-2.47,0.985,-1.6),0.22,-60)
 model('VisitorSeat','res://assets/mid_century_lounge_chair/mid_century_lounge_chair.gltf',Vector3(-1.0,0,0.4),0.86,165)
 model('WaitingSeat','res://assets/mid_century_lounge_chair/mid_century_lounge_chair.gltf',Vector3(-5.0,0,2.1),0.86,90)
 # Paperwork inspection activity, in-trays and document bundles.
 for k in range(3):
  box('SteelInTray',Vector3(-1.05,1.025+k*0.08,-1.58),Vector3(0.39,0.025,0.31),trim)
  box('InTrayBack',Vector3(-1.05,1.065+k*0.08,-1.73),Vector3(0.39,0.08,0.015),trim)
 for k in range(7):
  var sheet=box('DocumentStack',Vector3(-1.8,0.991+k*0.003,-1.4),Vector3(0.32,0.002,0.24),paper);sheet.rotation.y=k*0.035
 var folder=box('RedCaseFile',Vector3(-2.03,1.016,-1.29),Vector3(0.28,0.013,0.35),red);folder.rotation.y=-0.25
 for j in range(7):box('PrintedRecordLine',Vector3(-1.8,1.014,-1.47+j*0.021),Vector3(0.22,0.001,0.003),dark)
 cyl('PenCup',Vector3(-2.72,1.06,-1.16),0.045,0.15,dark)
 for i in range(4):cyl('Pencil',Vector3(-2.74+i*0.013,1.16,-1.16),0.003,0.2,yellow)
 # A foreground queue and finished threshold.
 for z in [1.2,3.6]:
  for x in [1.05,3.25]:
   cyl('QueuePost',Vector3(x,0.5,z),0.026,1.0,trim);cyl('QueueFoot',Vector3(x,0.025,z),0.16,0.05,dark)
 for x in [1.05,3.25]:box('QueueBelt',Vector3(x,0.91,2.4),Vector3(0.022,0.065,2.4),dark)
 box('ThresholdSafetyStrip',Vector3(2.6,0.008,-4.85),Vector3(3.1,0.008,0.28),yellow)
 for i in range(16):
  var b=box('HazardStripe',Vector3(1.12+i*0.19,0.014,-4.85),Vector3(0.065,0.004,0.28),dark);b.rotation.y=-0.35
 for x in [0.7,4.5]:box('RouteEdge',Vector3(x,0.009,-1.7),Vector3(0.035,0.006,6),yellow)
 # Signage with restrained typography.
 box('AnnexSign',Vector3(-2.9,3.3,-5.25),Vector3(3.5,0.82,0.08),dark)
 text3('RECORDS  /  04',Vector3(-2.9,3.36,-5.19),62,Color(0.83,0.81,0.69),0.005)
 text3('CENTRAL RESEARCH    •    AUTHORIZED PERSONNEL',Vector3(-2.9,3.08,-5.19),22,Color(0.56,0.6,0.53),0.004)
 box('ShelterSign',Vector3(2.6,3.95,-5.24),Vector3(2.95,0.53,0.06),yellow)
 text3('SHELTER  →',Vector3(2.6,3.97,-5.19),52,Color(0.035,0.045,0.035),0.006)
 box('NoticeBoard',Vector3(-5.6,1.9,-4.12),Vector3(0.62,0.84,0.03),dark)
 for y in [1.7,1.99]:
  box('PastedNotice',Vector3(-5.6,y,-4.09),Vector3(0.45,0.24,0.005),paper)
  text3('NOTICE\nCLEARANCE REQUIRED',Vector3(-5.6,y,-4.08),22,Color(0.04,0.05,0.04),0.0015)
 # Suspended fluorescent housings and conduit.
 for pos in [Vector3(-2.1,3.65,-1.65),Vector3(2.6,3.8,-3.7),Vector3(-4.4,3.7,2.3)]:
  box('FluorescentHousing',pos,Vector3(2.1,0.11,0.28),dark)
  box('Diffuser',pos+Vector3(0,-0.065,0),Vector3(1.95,0.035,0.2),white)
  for x in [-0.8,0.8]:cyl('SuspensionRod',pos+Vector3(x,0.62,0),0.009,1.2,trim)
  light(pos+Vector3(0,-0.17,0),Color(0.72,0.85,0.75),1.9,5.0)
 for x in [-5.85,-5.68]:cyl('ServiceRiser',Vector3(x,2.35,-4.25),0.025,4.7,trim)
 box('ServiceBox',Vector3(-5.7,1.6,-4.19),Vector3(0.44,0.6,0.17),dark)
 for i in range(8):box('ServiceVent',Vector3(-5.7,1.45+i*0.035,-4.095),Vector3(0.28,0.009,0.006),trim)
 light(Vector3(2.6,2.7,-7),Color(1,0.05,0.022),3.0,5.0)
 var lamp=mat('RedLamp',Color(0.6,0.025,0.01));lamp.emission_enabled=true;lamp.emission=Color(1,0.03,0.015);lamp.emission_energy_multiplier=4
 box('EmergencyLamp',Vector3(2.6,2.8,-7.78),Vector3(0.54,0.14,0.07),lamp)
 light(Vector3(-2.3,1.55,-1.3),Color(1.0,0.73,0.4),0.4,1.6)
 # Some dropped records close to desk, not random room-wide debris.
 for i in range(9):
  var n=box('DroppedRecord',Vector3(-2.2+sin(i*13.1)*0.7,0.013,-0.6+cos(i*3.2)*0.6),Vector3(0.21,0.002,0.29),paper);n.rotation.y=i*1.3
 var env=WorldEnvironment.new();var e=Environment.new();env.environment=e;e.background_mode=Environment.BG_COLOR;e.background_color=Color(0.022,0.028,0.03);e.ambient_light_source=Environment.AMBIENT_SOURCE_COLOR;e.ambient_light_color=Color(0.44,0.53,0.49);e.ambient_light_energy=0.22;e.tonemap_mode=Environment.TONE_MAPPER_FILMIC;e.ssao_enabled=true;e.ssao_radius=1.2;e.ssao_intensity=1.5;e.ssil_enabled=true;e.ssil_intensity=0.7;e.glow_enabled=true;e.glow_intensity=0.5;e.fog_enabled=true;e.fog_density=0.005;e.fog_light_color=Color(0.12,0.17,0.15);add(env,'Environment')
 var fill=OmniLight3D.new();fill.light_color=Color(0.56,0.68,0.72);fill.light_energy=0.8;fill.omni_range=11;add(fill,'EntranceBounce',Vector3(2.5,3.7,5.5))
 var cameras=[['overall',Vector3(6.4,2.7,7.2),Vector3(-0.85,1.85,-2.5),58],['detail',Vector3(0.65,1.88,1.25),Vector3(-1.9,1.0,-1.6),52],['transition',Vector3(0.0,1.75,0.8),Vector3(2.7,1.9,-6.0),57]]
 for c in cameras:
  var cam=Camera3D.new();add(cam,c[0],c[1]);cam.look_at(c[2]);cam.fov=c[3];cam.current=c[0]=='overall';cam.far=80
 var packed=PackedScene.new();packed.pack(scene);ResourceSaver.save(packed,'res://main.tscn');print('SAVED MAIN');quit()
