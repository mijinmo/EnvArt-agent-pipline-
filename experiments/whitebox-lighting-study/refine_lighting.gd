extends SceneTree
func _initialize():call_deferred("run")
func write_scene(scene:Node,path:String):
 var p=PackedScene.new();p.pack(scene);ResourceSaver.save(p,path)
func run():
 print("AMBIENT_SOURCE_DISABLED=",Environment.AMBIENT_SOURCE_DISABLED)
 for mode in ["whitebox_review","art_base"]:
  var s=load("res://"+mode+".tscn").instantiate()
  s.get_node("Lighting/Environment").environment.ambient_light_source=3
  write_scene(s,"res://"+mode+".tscn");s.free()
 var s=load("res://art_lit.tscn").instantiate();root.add_child(s)
 write_scene(s,"res://art_lit_01.tscn")
 var g=s.get_node("Lighting")
 var env=g.get_node("Environment").environment.duplicate(true)
 g.get_node("Environment").environment=env
 env.ambient_light_color=Color(0.71,0.78,0.84);env.ambient_light_energy=0.38;env.tonemap_exposure=1.0
 env.ssao_intensity=1.0
 var sky=env.sky.sky_material
 sky.sky_top_color=Color(0.09,0.13,0.18);sky.sky_horizon_color=Color(0.31,0.35,0.39);sky.ground_bottom_color=Color(0.08,0.09,0.10);sky.ground_horizon_color=Color(0.31,0.35,0.39)
 var sun=g.get_node("LabSun");sun.rotation_degrees=Vector3(-48,-32,0);sun.light_color=Color(0.96,0.98,1);sun.light_energy=0.78;sun.light_angular_distance=5.0
 var work=g.get_node("RecordsTask");work.light_color=Color(0.94,0.97,1);work.light_energy=2.8;work.light_size=0.6
 var portal=g.get_node("PortalWarm");portal.light_color=Color(1,0.93,0.81);portal.light_energy=2.5;portal.light_size=0.35
 var ramp=g.get_node("RampFlood");ramp.light_color=Color(0.85,0.91,1);ramp.light_energy=1.6;ramp.spot_angle=55;ramp.light_size=0.35;ramp.look_at(Vector3(-6,1.1,-4))
 var bounce=g.get_node("WarmFloorBounce_Approximation");bounce.name="NeutralFloorBounce_Approximation";bounce.light_color=Color(0.67,0.7,0.72);bounce.light_energy=0.65;bounce.omni_range=5
 var fill=g.get_node("OpenSkyFill_Approximation");fill.light_color=Color(0.76,0.84,0.94);fill.light_energy=1.1;fill.light_size=3.0
 var slope=SpotLight3D.new();slope.name="RampOpenSkyBounce_Approximation";g.add_child(slope);slope.owner=s;slope.position=Vector3(-7.5,5.5,1.5);slope.look_at(Vector3(-6,0.9,-3.4));slope.light_color=Color(0.82,0.89,1);slope.light_energy=2.1;slope.spot_range=13;slope.spot_angle=48;slope.light_size=2.0;slope.shadow_enabled=true
 g.get_node("DeskLamp").light_energy=1.3
 write_scene(s,"res://art_lit.tscn")
 write_scene(s,"res://art_lit_02.tscn")
 s.queue_free();await process_frame
 quit()
