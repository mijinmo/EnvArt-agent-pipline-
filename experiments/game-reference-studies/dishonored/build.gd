extends SceneTree
var scene:Node3D
var stone:StandardMaterial3D
var iron:StandardMaterial3D
var concrete:StandardMaterial3D
func _initialize(): call_deferred("build")
func add(n:Node,name_:String,pos=Vector3.ZERO):
 scene.add_child(n);n.name=name_;n.owner=scene
 if n is Node3D:n.position=pos
 return n
func mat(c:Color,tex="",uv=1.0):
 var m=StandardMaterial3D.new();m.albedo_color=c;m.roughness=.84
 if tex!="":m.albedo_texture=load(tex);m.uv1_scale=Vector3(uv,uv,uv)
 return m
func box(n,p,s,m):
 var i=MeshInstance3D.new();var mesh=BoxMesh.new();mesh.size=s;i.mesh=mesh;i.material_override=m;return add(i,n,p)
func cyl(n,p,r,h,m):
 var i=MeshInstance3D.new();var mesh=CylinderMesh.new();mesh.top_radius=r;mesh.bottom_radius=r;mesh.height=h;mesh.radial_segments=16;i.mesh=mesh;i.material_override=m;return add(i,n,p)
func pipe(n,a,b,r=.09):
 var p=cyl(n,(a+b)*.5,r,a.distance_to(b),iron)
 p.quaternion=Quaternion(Vector3.UP,(b-a).normalized())
 return p
func imported(path,n,p,s=1.0,rot=0.0,override=null):
 var src=load(path).instantiate();root.add_child(src)
 var group=add(Node3D.new(),n,p);group.scale=Vector3.ONE*s;group.rotation.y=rot
 for m in src.find_children("*","MeshInstance3D",true,false):
  if "Collision" in str(m.name) or str(m.name).ends_with("100"):continue
  var out=MeshInstance3D.new();out.mesh=m.mesh;group.add_child(out);out.owner=scene;out.name=m.name;out.transform=m.global_transform
  if override:out.material_override=override
  elif "props/" in path:
   for i in m.mesh.get_surface_count():
    var orig=m.mesh.surface_get_material(i);var key=orig.resource_name if orig else ""
    var file="";var folder=path.get_base_dir()+"/"
    if "DrumMetal" in key:file="3td_drummetal_01.jpg"
    elif "OilDrumTop" in key:file="3td_oildrumtop_01.png"
    elif "Crate01" in key:file="3td_crate_01_lft.png"
    elif "Crate" in key:file="3td_crate_02.png"
    elif "Pallet" in key:file="3td_palletwood_01.jpg"
    elif "BarrelTop" in key:file="3td_bareltop_03.png"
    elif "Barrel" in key:file="3td_barrel_02.jpg"
    elif "tank01" in key:file="3td_tank_01.jpg"
    elif "tank02" in key:file="3td_tank_02.jpg"
    var mm=mat(Color(.64,.64,.53),folder+file if file!="" and FileAccess.file_exists(folder+file) else "")
    out.set_surface_override_material(i,mm)
 src.queue_free()
 return group
func build():
 scene=Node3D.new();scene.name="PumpLane";root.add_child(scene)
 stone=mat(Color(.53,.52,.39),"res://assets/ground/cobblestone_floor_03_diff_2k.jpg",1.0)
 stone.uv1_triplanar=true;stone.uv1_scale=Vector3.ONE*.34;stone.normal_enabled=true;stone.normal_texture=load("res://assets/ground/cobblestone_floor_03_nor_gl_2k.jpg");stone.normal_scale=.65
 concrete=mat(Color(.46,.45,.35),"res://assets/props/3td_RoadBarrier_01/3td_concrete_01.jpg",1.0);concrete.uv1_triplanar=true;concrete.uv1_scale=Vector3.ONE*.5
 iron=mat(Color(.13,.19,.18));iron.metallic=.55;iron.roughness=.56
 var atlas=mat(Color(.55,.61,.53),"res://assets/industrial/atlas.png")
 var wh=ShaderMaterial.new();wh.shader=load("res://facade.gdshader");wh.set_shader_parameter("albedo_map",load("res://assets/warehouse/Set_01_DiffuseMap.png"))
 imported("res://assets/warehouse/warehouse02.glb","OldPumpWorksWest",Vector3(-14.2,.25,0),.95,0,wh)
 imported("res://assets/warehouse/warehouse02.glb","EastBondedWarehouse",Vector3(14.2,.25,-1),.95,PI,wh)
 imported("res://assets/warehouse/warehouse02.glb","DistantWorkshops",Vector3(1,.25,-49),.8,PI/2,wh)
 box("CobbleRoad",Vector3(0,-.18,-8),Vector3(13,.36,70),stone)
 # complete raised service walkways and continuous curb modules
 for side in [-1,1]:
  box("RaisedServiceWalk",Vector3(side*3.85,.12,-9),Vector3(2.1,.24,62),concrete)
  for z in range(-38,23):
   box("IndividualCurb",Vector3(side*2.75,.16,z),Vector3(.23,.32,.96),concrete)
  # imported tall industrial window frames, measured 2 by 3m
  for z in [-28,-22,-16,-10,-4,2,8]:
   imported("res://assets/industrial/IndWindowEFrame.fbx","TallWindow",Vector3(side*4.69,2.8,z),.5,-side*PI/2,atlas)
   box("WindowStoneSill",Vector3(side*4.53,2.78,z),Vector3(.48,.16,2.25),concrete)
   # shallow vertical masonry pilasters emphasize height
   box("BrickPilaster",Vector3(side*4.67,3.0,z+2.35),Vector3(.32,5.5,.42),concrete)
  for h in [.55,2.45,5.85]:
   box("ContinuousCornice",Vector3(side*4.55,h,-8),Vector3(.40,.18,48),concrete)
 # rear pumping office tower, built from real 2m modules at three storeys
 var kit=ShaderMaterial.new();kit.shader=load("res://kit_material.gdshader");kit.set_shader_parameter("atlas",load("res://assets/industrial/atlas.png"))
 for y in [.25,3.25,6.25,9.25]:
  for x in [-3,-1,1,3]:
   imported("res://assets/industrial/IndWindowBFull.fbx","PumpOfficeFrontBay",Vector3(x,y,-31),1,0,kit)
   imported("res://assets/industrial/IndWallFull.fbx","PumpOfficeBackBay",Vector3(x,y,-37),1,PI,kit)
  for z in [-32,-34,-36]:
   imported("res://assets/industrial/IndWallFull.fbx","PumpOfficeWestBay",Vector3(-4,y,z),1,-PI/2,kit)
   imported("res://assets/industrial/IndWallFull.fbx","PumpOfficeEastBay",Vector3(4,y,z),1,PI/2,kit)
  box("OfficeFloorCornice",Vector3(0,y+2.9,-30.85),Vector3(8.3,.18,.3),concrete)
 for x in [-3,-1,1,3]:
  for z in [-32,-34,-36]:
   imported("res://assets/industrial/IndRoofDarkGreyFull.fbx","OfficeRoofTile",Vector3(x,12.3,z),1,0,iron)
 box("OfficeRoofCornice",Vector3(0,12.25,-30.8),Vector3(8.5,.3,.4),concrete)
 # asymmetric service annex facade on the east, stopping beneath the original roof
 for z in [-16,-14,-12]:
  imported("res://assets/industrial/IndWindowBFull.fbx","EastRaisedServiceBay",Vector3(3.9,5.8,z),1,-PI/2,kit)
 for z in [-16,-14,-12]:
  imported("res://assets/industrial/IndWallFull.fbx","EastServiceRear",Vector3(8.1,5.8,z),1,PI/2,kit)
  for x in [5,7]:imported("res://assets/industrial/IndRoofDarkGreyFull.fbx","EastServiceRoof",Vector3(x,8.85,z),1,0,iron)
 for x in [5,7]:
  imported("res://assets/industrial/IndWallFull.fbx","EastServiceSideNorth",Vector3(x,5.8,-11),1,0,kit)
  imported("res://assets/industrial/IndWallFull.fbx","EastServiceSideSouth",Vector3(x,5.8,-17),1,PI,kit)
 box("EastServiceCornice",Vector3(3.85,8.75,-14),Vector3(.3,.2,6.2),concrete)
 # actual facade-sized plaster repair panels occupy a few bays, not a full uniform overlay
 var plaster=mat(Color(.39,.4,.34),"res://assets/props/3td_RoadBarrier_01/3td_concrete_01.jpg");plaster.uv1_triplanar=true;plaster.uv1_scale=Vector3.ONE*.35
 for z in [-18,-6,6]:
  box("EastLimewashRepair",Vector3(4.67,1.45,z),Vector3(.035,2.2,3.0),plaster)
 for z in [-12,0,12]:
  box("WestLimewashRepair",Vector3(-4.67,1.25,z),Vector3(.035,1.8,2.6),plaster)
 # two service stair transitions from cobbled roadway to walk
 for x in [-3.8,3.8]:
  imported("res://assets/industrial/IndStairsNarrowHalf.fbx","SideEntrySteps",Vector3(x,0,13),.45,PI,concrete)
 # municipal pumping supply pipe, held by collars
 pipe("MainSupplyRiser",Vector3(-4.34,.6,-3),Vector3(-4.34,7.9,-3),.15)
 pipe("OverheadSupply",Vector3(-4.34,7.9,-3),Vector3(4.34,7.9,-3),.15)
 pipe("Downpipe",Vector3(4.34,1,-3),Vector3(4.34,7.9,-3),.15)
 for y in [1.4,3.2,5.3,7.1]:
  cyl("PipeCollar",Vector3(-4.34,y,-3),.205,.12,iron)
  box("PipeWallBracket",Vector3(-4.5,y,-3),Vector3(.35,.1,.38),iron)
 # maintenance catwalk links the two working elevations; open railings preserve sky
 box("MaintenanceCatwalk",Vector3(0,4.5,-13),Vector3(9.1,.16,1.0),iron)
 for z in [-13.5,-12.5]:
  pipe("CatwalkTopRail",Vector3(-4.5,5.5,z),Vector3(4.5,5.5,z),.035)
  for x in range(-4,5):pipe("CatwalkPost",Vector3(x,4.5,z),Vector3(x,5.5,z),.025)
 for x in [-4.2,4.2]:pipe("CatwalkBrace",Vector3(x,3.5,-13),Vector3(x*.7,4.4,-13),.08)
 # valve, gauge and a service hose make the fuel station readable
 var red=mat(Color(.35,.15,.10));red.metallic=.3
 var wheel=MeshInstance3D.new();var tm=TorusMesh.new();tm.inner_radius=.19;tm.outer_radius=.25;wheel.mesh=tm;wheel.material_override=red;add(wheel,"StopValve",Vector3(4.05,1.5,-3));wheel.rotation.z=PI/2
 for ang in [0,PI/3,2*PI/3]:
  var dv=Vector3(0,cos(ang)*.23,sin(ang)*.23);pipe("ValveSpoke",Vector3(4.05,1.5,-3)-dv,Vector3(4.05,1.5,-3)+dv,.018)
 var gauge=cyl("PressureGaugeBody",Vector3(4.12,2.05,-3),.15,.09,iron);gauge.rotation.z=PI/2
 var face=cyl("PressureGaugeFace",Vector3(4.06,2.05,-3),.125,.01,mat(Color(.7,.68,.5)));face.rotation.z=PI/2
 pipe("GaugeNeedle",Vector3(4.045,2.05,-3),Vector3(4.045,2.13,-3.05),.01)
 for i in range(32):
  var a=float(i)/32*TAU;var b=float(i+1)/32*TAU
  pipe("HangingServiceHose",Vector3(3.9,1.0+cos(a)*.45,-5+sin(a)*.28),Vector3(3.9,1.0+cos(b)*.45,-5+sin(b)*.28),.025)
 # fenced boundary still leaves a visible workshop layer behind
 for x in [-4.5,4.5]:box("GatePier",Vector3(x,1.5,-24),Vector3(.65,3,.65),concrete)
 for x in range(-21,22):pipe("GatePicket",Vector3(x*.2,.25,-24),Vector3(x*.2,2.65,-24),.024)
 for h in [.6,2.1]:pipe("GateCrossRail",Vector3(-4.4,h,-24),Vector3(4.4,h,-24),.045)
 # Group 1: bonded goods awaiting morning collection; all on pallet or raised pavement
 var prop="res://assets/props/"
 imported(prop+"3td_Pallet_01/3td_pallet01.dae","ShippingPallet",Vector3(-3.75,.26,5),.72,.04)
 imported(prop+"3td_Crate_01/3td_crate01.dae","BondedCrateA",Vector3(-3.9,.44,4.8),.72,.07)
 imported(prop+"3td_Crate_01/3td_crate01.dae","BondedCrateB",Vector3(-3.15,.44,5.05),.58,-.06)
 imported(prop+"3td_Crate_01/3td_crate01.dae","BondedCrateC",Vector3(-3.9,1.205,4.8),.56,.05)
 imported(prop+"3td_Pallet_01/3td_pallet01.dae","SparePallet",Vector3(-3.75,.26,7.2),.72,.08)
 imported(prop+"3td_Pallet_01/3td_pallet01.dae","SparePalletStack",Vector3(-3.75,.44,7.2),.72,-.03)
 # verified open container and wooden mallet from authorized raw cache
 imported("res://assets/cached_support/wooden_bucket_02/wooden_bucket_02_2k.gltf","OpenDeliveryPail",Vector3(-3.05,.26,6.6),.85,.3)
 # Group 2: oil replenishment and pipe maintenance bay
 imported(prop+"3td_Barrel_01/3td_barrel01.dae","FuelDrumA",Vector3(3.65,.23,-2),1.0,.1)
 imported(prop+"3td_Barrel_01/3td_barrel01.dae","FuelDrumB",Vector3(3.6,.23,-.8),1.0,-.3)
 imported(prop+"3td_Crate_01/3td_crate01.dae","MaintenanceChest",Vector3(3.45,.26,1.0),.58,0)
 imported(prop+"3td_WeldingTank_01/weldingtank01.dae","ServiceGasCylinder",Vector3(4.1,.26,-4),.8,0)
 # repair bench with supported spare pipe lengths and wrench-like iron part
 box("RepairBenchTop",Vector3(3.7,1.0,-6.5),Vector3(1.5,.12,2.1),concrete)
 for xx in [3.15,4.2]:
  for zz in [-7.2,-5.8]:box("BenchIronLeg",Vector3(xx,.62,zz),Vector3(.07,.75,.07),iron)
 for z in [-7,-6.6,-6.2]:pipe("SparePipe",Vector3(3.1,1.14,z),Vector3(4.2,1.14,z),.065)
 var mallet=imported("res://assets/cached_support/wooden_hammer_01/wooden_hammer_01_2k.gltf","BenchWoodenMallet",Vector3(3.45,1.105,-6.1),1.2,.5);mallet.rotation.x=PI/2
 imported("res://assets/cached_support/wooden_bucket_02/wooden_bucket_02_2k.gltf","BenchWashPail",Vector3(4.0,1.065,-7),.68,0)
 # pavement drains and curb dirt accumulated at edges
 for z in [-12,0,10]:
  box("DrainRecess",Vector3(2.35,.012,z),Vector3(.65,.025,1.2),iron)
  for k in range(8):box("DrainSlat",Vector3(2.35,.035,z-.5+k*.14),Vector3(.64,.035,.045),concrete)
 seed(24)
 for i in range(85):
  var side=-1 if i%2==0 else 1
  var x=side*randf_range(2.45,2.66);var z=randf_range(-23,17)
  var b=box("CurbStoneDebris",Vector3(x,.035,z),Vector3(randf_range(.03,.11),.06,randf_range(.05,.19)),concrete);b.rotation.y=randf()*PI
 # localized repair rubble and drain runoff; center travel line remains open
 var dirt=mat(Color(.17,.18,.13));dirt.roughness=.96
 for center in [Vector3(-2.85,.025,6.7),Vector3(2.75,.025,-3),Vector3(2.35,.025,0),Vector3(2.35,.025,-12)]:
  for i in range(7):
   var xx=center.x+randf_range(-.28,.28);var zz=center.z+randf_range(-.8,.8)
   var chunk=box("ServiceBayRubble",Vector3(xx,.04,zz),Vector3(randf_range(.025,.09),randf_range(.025,.06),randf_range(.04,.14)),concrete);chunk.rotation=Vector3(randf_range(-.2,.2),randf()*PI,randf_range(-.2,.2))
  for i in range(9):
   var stain=box("DrainSediment",center+Vector3(randf_range(-.2,.2),0,randf_range(-.5,.5)),Vector3(randf_range(.15,.4),.006,randf_range(.3,.8)),dirt);stain.rotation.y=randf_range(-.25,.25)
 # small damp patches obey central channel
 var wet=mat(Color(.10,.16,.14));wet.roughness=.24
 for zz in []:
  var puddle=MeshInstance3D.new();var pm=CylinderMesh.new();pm.top_radius=.8;pm.bottom_radius=.8;pm.height=.009;pm.radial_segments=32;puddle.mesh=pm;puddle.material_override=wet;add(puddle,"DampDepression",Vector3(.4,.01,zz));puddle.scale=Vector3(.6,1,1.8)
 # original municipal signage provides a graphic hierarchy and purpose
 var signmat=mat(Color(.33,.39,.33));var cream=Color(.74,.71,.51)
 box("EnamelTradeSign",Vector3(-3.47,2.5,6.7),Vector3(.08,1.15,1.1),signmat)
 var label=Label3D.new();label.text="MORROW\n& SONS\nPUMP WORKS";label.font_size=46;label.pixel_size=.0028;label.modulate=cream;label.outline_size=0;add(label,"TradeLettering",Vector3(-3.42,2.5,6.7));label.rotation.y=PI/2
 box("OilBaySign",Vector3(3.47,1.8,-1.0),Vector3(.08,.6,1.0),signmat)
 var l2=Label3D.new();l2.text="OIL STORE\nNO FLAME";l2.font_size=42;l2.pixel_size=.0026;l2.modulate=cream;l2.outline_size=0;add(l2,"OilNotice",Vector3(3.42,1.8,-1.0));l2.rotation.y=-PI/2
 # practical lanterns on imported warehouse frontages
 var glow=mat(Color(.75,.56,.26));glow.emission_enabled=true;glow.emission=Color(1,.54,.18);glow.emission_energy_multiplier=2.0
 for v in [Vector3(-4.0,2.35,4),Vector3(4,2.35,-5),Vector3(-4,2.35,-15)]:
  pipe("LanternArm",v+Vector3(-.5,.35,0),v+Vector3(0,.35,0),.035)
  box("LanternFrame",v,Vector3(.25,.42,.25),iron)
  box("LanternGlass",v+Vector3(.01,0,.01),Vector3(.20,.30,.27),glow)
  var l=OmniLight3D.new();l.light_color=Color(1,.63,.31);l.light_energy=1.8;l.omni_range=4;l.shadow_enabled=true;add(l,"WarmServiceLantern",v+Vector3(.3,0,.3))
 var env=Environment.new();env.background_mode=Environment.BG_SKY;var sky=Sky.new();var sm=ProceduralSkyMaterial.new();sm.sky_top_color=Color(.23,.34,.36);sm.sky_horizon_color=Color(.65,.65,.48);sm.ground_bottom_color=Color(.18,.22,.2);sm.ground_horizon_color=Color(.65,.65,.48);sky.sky_material=sm;env.sky=sky;env.ambient_light_source=Environment.AMBIENT_SOURCE_COLOR;env.ambient_light_color=Color(.50,.61,.60);env.ambient_light_energy=.85
 env.tonemap_mode=Environment.TONE_MAPPER_FILMIC;env.ssao_enabled=true;env.ssao_radius=1.6;env.ssao_intensity=1.1;env.fog_enabled=true;env.fog_light_color=Color(.49,.54,.42);env.fog_density=.005;env.adjustment_enabled=true;env.adjustment_saturation=.72;env.adjustment_contrast=1.03
 var world=WorldEnvironment.new();world.environment=env;add(world,"Atmosphere")
 var sun=DirectionalLight3D.new();sun.light_color=Color(1,.86,.57);sun.light_energy=1.55;sun.rotation_degrees=Vector3(-38,-34,0);sun.shadow_enabled=true;sun.directional_shadow_max_distance=100;add(sun,"LateAfternoonKey")
 var cams=[["Overall",Vector3(1.6,2.15,16),Vector3(-.3,3,-7),66],["Detail",Vector3(.7,1.9,9),Vector3(-3.5,1.1,5.2),62],["Transition",Vector3(-.8,1.7,2.4),Vector3(3.6,1.2,-4),65]]
 for c in cams:
  var camera=Camera3D.new();camera.fov=c[3];add(camera,c[0],c[1]);camera.look_at(c[2]);camera.current=c[0]=="Overall"
 var packed=PackedScene.new();packed.pack(scene);ResourceSaver.save(packed,"res://study.tscn");print("SAVED study.tscn");quit()
