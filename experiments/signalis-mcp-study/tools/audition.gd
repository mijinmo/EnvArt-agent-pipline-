extends SceneTree
var scene: Node3D
var report := {}
func bounds(n: Node, x := Transform3D.IDENTITY) -> AABB:
 var t := x
 if n is Node3D: t = x * n.transform
 var box := AABB()
 var has := false
 if n is MeshInstance3D and n.mesh:
  box = t * n.get_aabb(); has = true
 for c in n.get_children():
  var b := bounds(c, t)
  if b.size.length() > 0.0001:
   box = box.merge(b) if has else b; has = true
 return box
func _initialize():
 scene = Node3D.new();scene.name = "AssetAudition";root.add_child(scene)
 var paths := ["quaternius_scifi/WallAstra_Straight_Flat.gltf","quaternius_scifi/ShortWall_MetalPlates_Straight.gltf","quaternius_scifi/Door_Frame_Square.gltf","quaternius_scifi/Prop_Computer.gltf","quaternius_scifi_props/Prop_Desk_Medium.gltf","quaternius_scifi_props/Prop_Chair.gltf","quaternius_scifi_props/Prop_Locker.gltf","quaternius_scifi_props/Prop_Shelves_ThinTall.gltf","crt/monitor.glb","old-computer/keyboard.glb","quaternius_scifi/Prop_Light_Wide.gltf","quaternius_scifi/Platform_DarkPlates.gltf"]
 for i in paths.size():
  var path: String = paths[i]
  var n: Node3D = load("res://assets/" + path).instantiate()
  var b := bounds(n);report[path] = {"position":[b.position.x,b.position.y,b.position.z],"size":[b.size.x,b.size.y,b.size.z]}
  var fit := 2.4 / maxf(b.size.x,maxf(b.size.y,b.size.z))
  n.scale *= fit;n.position = Vector3((i%4)*3.8,0,-(i/4)*4.0) - Vector3(b.get_center().x,b.position.y,b.get_center().z)*fit
  scene.add_child(n);n.owner=scene
  var label:=Label3D.new();label.text=path.get_file().get_basename();label.font_size=30;label.pixel_size=0.004;label.position=Vector3((i%4)*3.8,-0.3,-(i/4)*4.0+1.5);label.rotation_degrees.x=-45
  scene.add_child(label);label.owner=scene
 var env:=WorldEnvironment.new();env.environment=Environment.new();env.environment.background_mode=Environment.BG_COLOR;env.environment.background_color=Color(0.16,0.17,0.19);env.environment.ambient_light_source=Environment.AMBIENT_SOURCE_COLOR;env.environment.ambient_light_color=Color(0.8,0.85,1);env.environment.ambient_light_energy=0.65;scene.add_child(env);env.owner=scene
 var light:=DirectionalLight3D.new();light.rotation_degrees=Vector3(-55,-25,0);light.light_energy=1.8;scene.add_child(light);light.owner=scene
 var camera:=Camera3D.new();scene.add_child(camera);camera.owner=scene;camera.position=Vector3(6,13,13);camera.look_at_from_position(camera.position,Vector3(5.5,0,-3.7));camera.projection=Camera3D.PROJECTION_ORTHOGONAL;camera.size=18;camera.current=true
 var packed:=PackedScene.new();packed.pack(scene);ResourceSaver.save(packed,"res://scenes/audition.tscn")
 var file:=FileAccess.open("res://asset-bounds.json",FileAccess.WRITE);file.store_string(JSON.stringify(report,"  "))
 print("Asset audition saved");quit()
