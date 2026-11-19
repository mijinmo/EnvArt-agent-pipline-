@tool
extends "res://art/pass01/HarbourSurfaces.gd"

const STONE = preload("res://art/final/GrindingStone.gdshader")
const FLOAT_PAINT = preload("res://art/final/BuoyEnamel.gdshader")

func _ready() -> void:
 super()
 if not has_node("Harbor"): return
 for group in $Harbor.get_children():
  var group_name := str(group.name)
  if group_name.begins_with("MooringFloat"):
   var paint := ShaderMaterial.new()
   paint.shader = FLOAT_PAINT
   var swatch := "#ac5242"
   if "Stripe" in group_name: swatch = "#e1cba0"
   elif "Foot" in group_name or "Eye" in group_name: swatch = "#424e50"
   paint.set_shader_parameter("coat",Color(swatch))
   (group as MeshInstance3D).material_override = paint
  if group_name.begins_with("workbench_grind"):
   for child in group.find_children("*","MeshInstance3D",true,false):
    var metal := ShaderMaterial.new()
    if child.name == &"wheel":
     metal.shader = STONE
     child.material_override = metal
    else:
     metal.shader = BOARDS
     metal.set_shader_parameter("plank_a",Color("#5e534a"))
     metal.set_shader_parameter("plank_b",Color("#967b60"))
     metal.set_shader_parameter("width_m",.41)
     child.material_override = metal
  if not group.has_meta("wash"): continue
  for node in group.find_children("*","MeshInstance3D",true,false):
   var mesh_node := node as MeshInstance3D
   for i in mesh_node.mesh.get_surface_count():
    var src := mesh_node.mesh.surface_get_material(i) as StandardMaterial3D
    var ink := mesh_node.get_surface_override_material(i) as ShaderMaterial
    if not src or not ink: continue
    var hue := Color.WHITE
    match src.resource_name:
     "MI_Trim_Furniture": hue = Color("#ead7b5")
     "MI_Trim_Metal": hue = Color("#adc3c8")
     "MI_Trim_Cloth": hue = Color("#c2b58f")
     "MI_WoodTrim","MI_WoodTrim_Wear":
      hue = Color("#9d8890") if group_name.begins_with("Roof") else Color("#bba49a")
     "MI_Plaster": hue = Color("#f6e1c7")
    if hue != Color.WHITE:
     var fresh: ShaderMaterial = ink.duplicate()
     fresh.set_shader_parameter("wash",hue)
     mesh_node.set_surface_override_material(i,fresh)
 for lantern in $Renewal/BenchLamp/StormLamp.find_children("*","MeshInstance3D",true,false):
  for i in lantern.mesh.get_surface_count():
   var original := lantern.mesh.surface_get_material(i) as StandardMaterial3D
   if not original or original.resource_name not in ["Pigment_d5a15b","Pigment_f4d096","Pigment_dbab67"]: continue
   var glass: StandardMaterial3D = original.duplicate()
   glass.emission_enabled = true
   glass.emission = Color("#ffbc71")
   glass.emission_energy_multiplier = 1.2
   lantern.set_surface_override_material(i,glass)
