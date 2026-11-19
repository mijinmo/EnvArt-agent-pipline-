@tool
extends Node3D

func _ready() -> void:
 for part in get_children():
  if part.name.begins_with("Shakes"): continue
  for child in part.find_children("*","MeshInstance3D",true,false):
   var mesh_node := child as MeshInstance3D
   for i in mesh_node.mesh.get_surface_count():
    var source := mesh_node.mesh.surface_get_material(i)
    if not source: continue
    var mat := StandardMaterial3D.new()
    match source.resource_name:
     "MI_Plaster": mat.albedo_color = Color("#cdaf94")
     "MI_Brick","MI_UnevenBrick": mat.albedo_color = Color("#8c7668")
     _: mat.albedo_color = Color("#574549")
    mat.roughness = .98
    mesh_node.set_surface_override_material(i,mat)
