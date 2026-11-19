@tool
extends "res://baseline/surface_treatment.gd"

func _ready() -> void:
 super._ready()
 var stand = StandardMaterial3D.new()
 stand.albedo_color = Color("#675347")
 stand.roughness = 0.95
 var stone = ShaderMaterial.new()
 stone.shader = preload("res://yard_final/grindstone.gdshader")
 for part: MeshInstance3D in $Harbor/workbench_grind62.find_children("*", "MeshInstance3D", true, false):
  part.material_override = stone if str(part.name).to_lower().contains("wheel") else stand
 var grinder = $Harbor/workbench_grind62
 if grinder is MeshInstance3D:
  grinder.material_override = stand
