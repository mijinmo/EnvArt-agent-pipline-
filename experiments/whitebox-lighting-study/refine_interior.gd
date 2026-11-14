extends "res://build_interior.gd"
func wall_materials(n,mat):
 if n is MeshInstance3D and n.material_override is ShaderMaterial:
  if n.material_override.shader.resource_path=="res://continuous_concrete.gdshader":n.material_override=mat
 for c in n.get_children():wall_materials(c,mat)
func run():
 var scene=load("res://interior.tscn").instantiate();root.add_child(scene)
 art=scene.get_node("ArtContent");decor=art.get_node("Art_Added")
 var wall=ShaderMaterial.new();wall.shader=load("res://concrete_detail.gdshader")
 wall.set_shader_parameter("concrete_color",load("res://assets/smooth_concrete_floor/Diffuse.jpg"))
 wall.set_shader_parameter("concrete_rough",load("res://assets/smooth_concrete_floor/Rough.jpg"))
 wall.set_shader_parameter("concrete_normal",load("res://assets/smooth_concrete_floor/nor_gl.jpg"))
 wall_materials(art,wall)
 mats.metal=solid(Color(0.10,0.12,0.11),0.5,0.55)
 mats.paper=solid(Color(0.70,0.66,0.53),0.9)
 mats.emit=solid(Color(0.9,0.81,0.6),0.4);mats.emit.emission_enabled=true;mats.emit.emission=Color(1,0.84,0.6);mats.emit.emission_energy_multiplier=2
 # Real shelves along the rear wall; existing camera and movement envelope kept clear.
 asset("steel_frame_shelves_01","PendingRecordsShelf",Vector3(7.2,0,-11.36),0.11,0)
 # Shelf tops from source triangle planes, calibrated to 0.11 scale.
 var levels=[0.1474,0.7036,1.2607,1.8175,2.3441]
 asset("cardboard_box_01","ShelfIntakeBox",Vector3(7.38,levels[0],-11.34),0.85,4)
 asset("binder_notebook","ShelfLedger",Vector3(6.93,levels[1],-11.34),1.2,90,0,"binder_notebook_closed")
 for i in range(7):
  asset("binder_notebook","ReferenceLedger"+str(i),Vector3(6.85+i*0.055,levels[2],-11.3),1.25,90,90,"binder_notebook_closed")
 asset("office_notepads","ShelfPaperReam",Vector3(7.52,levels[2],-11.3),1.0,2,0,"office_notepads_a4_stack")
 asset("cardboard_box_01","ShelfOutgoingBox",Vector3(7.1,levels[3],-11.35),0.8,-6)
 asset("office_notepads","ShelfNotes",Vector3(7.5,levels[1],-11.3),1.1,7,0,"office_notepads_yellow_pad")
 asset("industrial_storage_cart","TransferTrolley",Vector3(5.85,0,-10.60),0.73,10)
 asset("cardboard_box_01","TrolleyOutbox",Vector3(6.05,0.940,-10.60),0.85,-2)
 asset("binder_notebook","TrolleyManifest",Vector3(5.58,0.941,-10.56),1.15,18,0,"binder_notebook")
 asset("office_notepads","TrolleyReam",Vector3(5.82,0.564,-10.58),1.2,10,0,"office_notepads_a4_stack")
 # Main desk: individually selected source variants, not the asset catalogue layout.
 asset("office_notepads","IntakePad",Vector3(8.93,0.752,-7.16),0.82,-82,0,"office_notepads_yellow_pad")
 asset("office_notepads","StickyNotes",Vector3(8.55,0.755,-6.43),1.0,5,0,"office_notepads_sticky_stack")
 # Fixed functional wall details distinguish the work zone without turning the wall into tiles.
 box("ShelfIndexStrip",Vector3(7.2,2.48,-11.68),Vector3(1.18,0.19,0.02),mats.metal)
 label("ShelfIndexText","PENDING  /  21-27",Vector3(7.2,2.48,-11.66),36,0.0014)
 # A dedicated practical for incoming records, mounted above the board.
 box("RecordsWallLight",Vector3(5.72,2.65,-11.57),Vector3(1.18,0.09,0.22),mats.metal)
 box("RecordsWallLens",Vector3(5.72,2.60,-11.54),Vector3(1.03,0.012,0.13),mats.emit)
 var lg=scene.get_node("Lighting")
 var env=lg.get_node("Environment").environment.duplicate();lg.get_node("Environment").environment=env
 env.ambient_light_energy=0.17;env.ambient_light_color=Color(0.68,0.72,0.74);env.ssao_intensity=0.9
 var sky=lg.get_node("SkylightDaylight");sky.position=Vector3(4.6,5.35,-8.9);sky.look_at(Vector3(8,1,-10.1));sky.light_energy=6.0;sky.spot_angle=49;sky.light_color=Color(0.84,0.90,1.0);sky.light_size=0.45
 var office=lg.get_node("OfficePractical");office.light_color=Color(1,0.91,0.74);office.light_energy=2.7
 lg.get_node("DeskTask").light_energy=1.05
 lg.get_node("SkylightBounceApproximation").light_energy=0.85
 spot(lg,"RecordsWallPractical",Vector3(5.72,2.55,-11.46),Vector3(5.8,0.7,-10.4),Color(1,0.84,0.63),2.8,5,65)
 var newlight=lg.get_node("RecordsWallPractical");newlight.light_size=0.22;newlight.shadow_normal_bias=0.4
 # Portal receives low broad reflected fill from the lit room, preserving its practical.
 var entry=OmniLight3D.new();entry.name="EntryBounceApproximation";entry.position=Vector3(0.3,1.8,-5.5);entry.omni_range=4.5;entry.light_energy=0.65;entry.light_color=Color(0.78,0.82,0.86);lg.add_child(entry)
 save(scene,"res://interior_detailed.tscn")
 print("DETAIL_SAVED")
 scene.queue_free();await process_frame;await process_frame;quit()
