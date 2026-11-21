extends SceneTree
# One-off draft construction. Do not rerun over manually/MCP edited scene versions.
var scene: Node3D
var art: Node3D
var shader: Shader
var statistics := {}
func _initialize(): call_deferred("build")
func own(n: Node, parent: Node = null) -> Node:
 if parent == null: parent = art
 parent.add_child(n);n.owner=scene;return n
func bounds(n: Node, xf:=Transform3D.IDENTITY) -> AABB:
 var t:=xf
 if n is Node3D:t=xf*n.transform
 var box:=AABB();var has:=false
 if n is MeshInstance3D and n.mesh:box=t*n.get_aabb();has=true
 for c in n.get_children():
  var b:=bounds(c,t)
  if b.size.length()>0.00001:box=box.merge(b) if has else b;has=true
 return box
func recolor(n:Node,tint:Color):
 if n is MeshInstance3D:
  for i in n.get_surface_override_material_count():
   var src=n.get_active_material(i)
   var mat:=ShaderMaterial.new();mat.shader=shader;mat.set_shader_parameter("tint",tint)
   if src is BaseMaterial3D and src.albedo_texture:
    mat.set_shader_parameter("has_texture",true);mat.set_shader_parameter("source_tex",src.albedo_texture)
   elif src is BaseMaterial3D:
    mat.set_shader_parameter("tint",src.albedo_color*tint)
   n.set_surface_override_material(i,mat)
 for c in n.get_children():recolor(c,tint)
func asset(path:String,label:String,pos:Vector3,scale_v:Vector3,angle:float=0,tint:=Color(0.75,0.78,0.69)) -> Node3D:
 var n:Node3D=load("res://assets/"+path).instantiate();n.name=label
 var b:=bounds(n);var base:=Vector3(b.get_center().x,b.position.y,b.get_center().z)
 var holder:=Node3D.new();holder.name=label;own(holder);holder.position=pos;holder.rotation.y=deg_to_rad(angle)
 holder.add_child(n);n.owner=scene;n.name="Source";n.scale*=scale_v;n.position=-base*scale_v
 scene.set_editable_instance(n,true);recolor(n,tint)
 statistics[path]=statistics.get(path,0)+1
 return holder
func fit_asset(path:String,label:String,pos:Vector3,height:float,angle:float=0,tint:=Color(0.75,0.78,0.69))->Node3D:
 var temp:Node3D=load("res://assets/"+path).instantiate();var b:=bounds(temp);temp.free()
 return asset(path,label,pos,Vector3.ONE*(height/maxf(b.size.y,0.01)),angle,tint)
func mat(color:Color,emit:=0.0)->StandardMaterial3D:
 var m:=StandardMaterial3D.new();m.albedo_color=color;m.roughness=0.88
 if emit>0:m.emission_enabled=true;m.emission=color;m.emission_energy_multiplier=emit
 return m
func box(label:String,pos:Vector3,size:Vector3,material:Material)->MeshInstance3D:
 var n:=MeshInstance3D.new();n.name=label;n.mesh=BoxMesh.new();n.mesh.size=size;n.material_override=material;n.position=pos;own(n);return n
func label(text:String,pos:Vector3,size:=36,color:=Color(0.68,0.68,0.59),yaw:=0.0)->Label3D:
 var n:=Label3D.new();n.name="Sign_"+text.validate_node_name();n.text=text;n.font_size=size;n.pixel_size=0.006;n.outline_size=0;n.modulate=color;n.position=pos;n.rotation_degrees.y=yaw;n.no_depth_test=false;n.shaded=true;own(n);return n
func spot(label:String,pos:Vector3,target:Vector3,color:Color,energy:float,reach:float,angle:float)->SpotLight3D:
 var l:=SpotLight3D.new();l.name=label;own(l);l.position=pos;l.look_at(target);l.light_color=color;l.light_energy=energy;l.spot_range=reach;l.spot_angle=angle;l.spot_attenuation=0.65;l.shadow_enabled=true;l.shadow_blur=0.65;return l
func omni(label:String,pos:Vector3,color:Color,energy:float,reach:float)->OmniLight3D:
 var l:=OmniLight3D.new();l.name=label;own(l);l.position=pos;l.light_color=color;l.light_energy=energy;l.omni_range=reach;l.omni_attenuation=1.4;l.shadow_enabled=true;return l
func camera(label:String,pos:Vector3,target:Vector3,ortho:=0.0)->Camera3D:
 var c:=Camera3D.new();c.name=label;own(c,scene);c.position=pos;c.look_at(target);c.fov=53
 if ortho>0:c.projection=Camera3D.PROJECTION_ORTHOGONAL;c.size=ortho
 c.near=0.1;c.far=70;return c
func save(path:String):
 var p:=PackedScene.new();p.pack(scene);ResourceSaver.save(p,path)
func build():
 shader=load("res://shaders/surface.gdshader")
 scene=Node3D.new();scene.name="SignalisStudy";root.add_child(scene)
 var whitebox:Node3D=load("res://source/whitebox.tscn").instantiate();scene.add_child(whitebox);whitebox.owner=scene;whitebox.visible=false
 art=Node3D.new();art.name="Art";own(art,scene)
 var env:=WorldEnvironment.new();env.name="Environment";own(env,scene);env.environment=Environment.new()
 var e:=env.environment;e.background_mode=Environment.BG_COLOR;e.background_color=Color(0.008,0.009,0.012);e.ambient_light_source=Environment.AMBIENT_SOURCE_COLOR;e.ambient_light_color=Color(0.48,0.58,0.59);e.ambient_light_energy=0.22;e.tonemap_mode=Environment.TONE_MAPPER_FILMIC;e.ssao_enabled=true;e.ssao_radius=0.8;e.ssao_intensity=1.3;e.glow_enabled=false
 var floor_mat:=ShaderMaterial.new();floor_mat.shader=load("res://shaders/floor.gdshader")
 box("RoomFloor",Vector3(3.2,-0.015,-8),Vector3(13,0.04,8.0),floor_mat)
 box("DoorApron",Vector3(0,-0.02,-2.9),Vector3(2.8,0.04,2.3),floor_mat)
 # Imported wall modules face along their local X; rotate for the back wall.
 for i in 4:
  asset("quaternius_scifi/WallAstra_Straight_Flat.gltf","BackModule_%d"%i,Vector3(-1.6+i*3.3,0,-11.72),Vector3(1,1.05,0.825),90,Color(0.70,0.72,0.65))
  asset("quaternius_scifi/ShortWall_MetalPlates_Straight.gltf","BackWainscot_%d"%i,Vector3(-1.6+i*3.3,0,-11.64),Vector3(1,0.82,0.825),90,Color(0.4,0.46,0.44))
 for i in 2:
  asset("quaternius_scifi/WallAstra_Straight_Flat.gltf","RightModule_%d"%i,Vector3(9.72,0,-9.7+i*3.8),Vector3(1,1.05,0.95),0,Color(0.60,0.64,0.59))
  asset("quaternius_scifi/WallAstra_Straight_Flat.gltf","LeftModule_%d"%i,Vector3(-3.25,0,-9.7+i*3.8),Vector3(1,1.05,0.95),180,Color(0.60,0.64,0.59))
 # Front enclosure is cut away for the fixed inspection cameras, as in the reference.
 var roof:=box("CeilingShadowEnclosure",Vector3(3.2,3.4,-8),Vector3(13.1,0.2,8.2),mat(Color(0.12,0.13,0.13)));roof.cast_shadow=GeometryInstance3D.SHADOW_CASTING_SETTING_SHADOWS_ONLY
 fit_asset("quaternius_scifi/Door_Frame_Square.gltf","OriginalDoorOpening",Vector3(0,0,-4),2.62,0,Color(0.61,0.63,0.55))
 box("FrontReturnLeft",Vector3(-2.0,0.45,-4),Vector3(2.0,0.9,0.22),mat(Color(0.18,0.22,0.22)))
 box("FrontReturnRight",Vector3(5.45,0.45,-4),Vector3(8.6,0.9,0.22),mat(Color(0.18,0.22,0.22)))
 box("BackIdentificationBand",Vector3(3.2,1.48,-11.56),Vector3(12.7,0.22,0.025),mat(Color(0.36,0.12,0.08)))
 label("RELAIS  /  07",Vector3(3.35,2.53,-11.48),56)
 label("TECHNISCHER DIENST",Vector3(-1.25,1.82,-11.48),24)
 # Three functional groups: repair desk, terminal bank, storage/maintenance.
 fit_asset("metal_office_desk/metal_office_desk.gltf","RepairDesk",Vector3(-1.55,0,-9.95),0.85,0,Color(0.77,0.78,0.68))
 fit_asset("crt/monitor.glb","RepairMonitor",Vector3(-1.8,0.86,-10.02),0.61,180,Color(0.66,0.70,0.62))
 asset("old-computer/keyboard.glb","RepairKeyboard",Vector3(-1.66,0.87,-9.51),Vector3.ONE*0.0028,0,Color(0.77,0.73,0.56))
 fit_asset("quaternius_scifi_props/Prop_Mug.gltf","DeskCup",Vector3(-0.8,0.86,-9.9),0.13,0)
 fit_asset("quaternius_scifi_props/Prop_Desk_Medium.gltf","TerminalBench",Vector3(3.4,0,-10.55),0.86,0,Color(0.45,0.51,0.48))
 for i in 3:
  fit_asset("crt/monitor.glb","Terminal_%d"%i,Vector3(2.45+i*0.92,0.87,-10.5),0.72,180 if i!=2 else 168,Color(0.67,0.69,0.60))
  asset("old-computer/keyboard.glb","Keyboard_%d"%i,Vector3(2.45+i*0.92,0.88,-9.99),Vector3.ONE*0.0023,0,Color(0.65,0.64,0.52))
 # Small emissive overlays on actual CRT screen positions; do not replace housings.
 box("HeroCRTGlow",Vector3(3.37,1.29,-10.20),Vector3(0.39,0.27,0.008),mat(Color(0.76,0.025,0.01),1.6))
 label("KEIN SIGNAL",Vector3(3.37,1.29,-10.189),14,Color(0.96,0.23,0.08))
 for i in 2:
  fit_asset("quaternius_scifi_props/Prop_Locker.gltf","Locker_%d"%i,Vector3(7.1+i*1.02,0,-11.12),2.35,0,Color(0.56,0.61,0.55))
 fit_asset("quaternius_scifi_props/Prop_Shelves_ThinTall.gltf","PartsShelf",Vector3(5.7,0,-11.1),2.35,0,Color(0.53,0.57,0.52))
 for i in 3:
  fit_asset("quaternius_scifi_props/Prop_Ammo_Small.gltf","PartsBin_%d"%i,Vector3(5.5+(i%2)*0.38,0.42+i*0.54,-10.97),0.26,-8+i*14,Color(0.53,0.55,0.45))
 fit_asset("quaternius_scifi_props/Prop_Shelves_WideShort.gltf","SideWorkbench",Vector3(8.9,0,-7.55),1.0,90,Color(0.52,0.57,0.51))
 fit_asset("quaternius_scifi_props/Prop_HealthPack.gltf","ToolCase",Vector3(8.7,1.03,-7.95),0.23,80,Color(0.58,0.48,0.36))
 fit_asset("crt/monitor.glb","RemovedMonitor",Vector3(8.65,1.02,-6.9),0.6,95,Color(0.54,0.59,0.52))
 fit_asset("quaternius_scifi_props/Prop_Crate_Tarp.gltf","CoveredSpares",Vector3(-2.12,0,-6.75),0.86,9,Color(0.47,0.51,0.44))
 fit_asset("quaternius_scifi_props/Prop_Crate.gltf","SingleOpenSpares",Vector3(6.6,0,-6.1),0.65,-17,Color(0.45,0.48,0.39))
 fit_asset("quaternius_scifi/Column_Pipes.gltf","ServiceRiser",Vector3(9.3,0,-10.7),2.8,0,Color(0.4,0.46,0.43))
 for i in 3:
  fit_asset("quaternius_scifi/Prop_AccessPoint.gltf","WallSwitch_%d"%i,Vector3(-2.4+i*4.2,1.2,-11.3),0.48,0,Color(0.7,0.73,0.61))
 fit_asset("quaternius_scifi/Prop_Vent_Wide.gltf","ReturnAir",Vector3(7.2,2.6,-11.35),0.3,0,Color(0.55,0.6,0.56))
 for pos in [Vector3(-1.3,2.85,-10.9),Vector3(3.4,2.85,-10.9),Vector3(8.4,2.85,-7.5)]:
  asset("quaternius_scifi/Prop_Light_Wide.gltf","Practical_%s"%pos.x,pos,Vector3.ONE,0,Color(0.68,0.7,0.61))
  box("Tube_%s"%pos.x,pos+Vector3(0,-0.08,0.13),Vector3(0.98,0.035,0.10),mat(Color(0.64,0.78,0.64),1.3))
 spot("RepairTaskLight",Vector3(-1.3,2.72,-10.7),Vector3(-1.1,0,-9.4),Color(0.64,0.79,0.73),4.8,6.0,61)
 spot("TerminalTaskLight",Vector3(3.4,2.72,-10.7),Vector3(3.5,0,-9.15),Color(0.8,0.81,0.60),4.8,6.2,63)
 spot("StorageTaskLight",Vector3(8.6,2.72,-7.4),Vector3(8.4,0,-7.2),Color(0.48,0.68,0.60),3.5,5.4,62)
 omni("TerminalRedSpill",Vector3(3.37,1.15,-9.9),Color(1.0,0.045,0.008),1.4,3.3)
 omni("ThresholdGreen",Vector3(0,2.1,-4.1),Color(0.4,0.63,0.52),1.0,3.8)
 box("DoorStatus",Vector3(-0.9,1.55,-3.66),Vector3(0.1,0.15,0.045),mat(Color(0.12,0.65,0.42),1.1))
 # Original doorway stays open; added floor markers avoid its 1.2 m clear passage.
 for i in 7:
  var strip:=box("ThresholdMark_%d"%i,Vector3(-0.55+i*0.18,0.017,-3.62),Vector3(0.08,0.009,0.23),mat(Color(0.53,0.48,0.26)));strip.rotation_degrees.y=-28
 for i in 11:
  var paper:=box("RepairPaper_%d"%i,Vector3(-1.0+fmod(i*0.73,3.2),0.018,-8.4+fmod(i*0.39,2.0)),Vector3(0.12+fmod(i*0.07,0.12),0.006,0.18),mat(Color(0.45,0.46,0.35)));paper.rotation_degrees.y=i*47
 var hero:=camera("HeroCamera",Vector3(3.0,12.2,3.7),Vector3(3.0,0.65,-8.0),11.4);hero.current=true
 camera("DetailCamera",Vector3(2.3,3.6,-5.5),Vector3(3.4,1.0,-10.4))
 camera("DoorCamera",Vector3(0.7,3.0,0.6),Vector3(0.0,1.15,-7.7))
 var layer:=CanvasLayer.new();layer.name="PixelFinish";own(layer,scene)
 var rect:=ColorRect.new();rect.name="Finish";own(rect,layer);rect.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT);rect.mouse_filter=Control.MOUSE_FILTER_IGNORE
 var post:=ShaderMaterial.new();post.shader=load("res://shaders/pixel_finish.gdshader");rect.material=post
 save("res://scenes/draft.tscn")
 var f:=FileAccess.open("res://asset-use.json",FileAccess.WRITE);f.store_string(JSON.stringify(statistics,"  "))
 print("Draft saved with ",statistics.size()," source models");quit()
