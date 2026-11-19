@tool
extends "res://baseline/surface_treatment.gd"

const BOARDS = preload("res://art/pass01/TarredBoards.gdshader")

func _ready() -> void:
 super()
 if not has_node("Whitebox"): return
 for body in $Whitebox/World.get_children():
  var surface = body.get_node_or_null("Mesh") as MeshInstance3D
  if surface == null: continue
  if body.name in [&"BackWall", &"OcclusionWall", &"OcclusionReturn"]: continue
  if body.name in [&"JumpHigh", &"JumpMid"]:
   surface.hide()
   continue
  var boards := ShaderMaterial.new()
  boards.shader = BOARDS
  if body.name == &"Floor":
   boards.set_shader_parameter("plank_a", Color("#66706e"))
   boards.set_shader_parameter("plank_b", Color("#94775e"))
  if str(body.name).begins_with("Door"):
   boards.set_shader_parameter("plank_a", Color("#394f50"))
   boards.set_shader_parameter("plank_b", Color("#627771"))
  surface.material_override = boards
 for group in $Harbor.get_children():
  if not group.has_meta("wash"): continue
  for mesh_node in group.find_children("*","MeshInstance3D",true,false):
   var item := mesh_node as MeshInstance3D
   for i in item.mesh.get_surface_count():
    var src := item.mesh.surface_get_material(i) as StandardMaterial3D
    var ink := item.get_surface_override_material(i) as ShaderMaterial
    if not src or not ink: continue
    var hue := Color.WHITE
    match src.resource_name:
     "MI_Trim_Metal": hue = Color("#9399a3")
     "MI_Trim_Furniture": hue = Color("#bf987d")
     "MI_WoodTrim","MI_WoodTrim_Wear": hue = Color("#987978") if str(group.name).begins_with("Roof") else Color("#af9689")
     "MI_Plaster": hue = Color("#e7c8ad")
     "MI_Trim_Cloth": hue = Color("#baa17c")
    if str(group.name).begins_with("workbench_grind"):
     var stone := StandardMaterial3D.new()
     stone.albedo_color = Color("#797c78") if str(item.name) == "wheel" else Color("#63493f")
     stone.roughness = .98
     item.set_surface_override_material(i,stone)
    elif hue != Color.WHITE:
     var tinted: ShaderMaterial = ink.duplicate()
     tinted.set_shader_parameter("wash",hue)
     item.set_surface_override_material(i,tinted)
