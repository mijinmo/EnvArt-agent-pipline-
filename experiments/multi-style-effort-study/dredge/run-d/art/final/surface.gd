@tool
extends "res://baseline/surface_treatment.gd"

func _ready() -> void:
 super._ready()
 if not has_node("Whitebox"):
  return
 for body in $Whitebox/World.get_children():
  if body.name in [&"BackWall", &"OcclusionWall", &"OcclusionReturn"]:
   continue
  var material := ShaderMaterial.new()
  material.shader = preload("res://art/final/wharf.gdshader")
  var wood_type := 1
  if body.name in [&"Floor", &"Ramp", &"Landing", &"SpawnPad"]:
   wood_type = 0
  elif str(body.name).begins_with("Door"):
   wood_type = 2
  material.set_shader_parameter("build", wood_type)
  body.get_node("Mesh").material_override = material
 var grinder := $Harbor.get_node("workbench_grind62")
 for part in grinder.find_children("*", "MeshInstance3D", true, false):
  var material := StandardMaterial3D.new()
  material.albedo_color = Color("#7e8783") if "wheel" in str(part.name).to_lower() else Color("#645a50")
  material.roughness = .95
  part.material_override = material
