@tool
extends Node3D

const PRESS_INK = preload("res://shaders/press_ink.gdshader")
var library: Dictionary = {}

func _ready() -> void:
	for unit in find_children("*", "Node3D", true, false):
		if unit.scene_file_path.begins_with("res://art/"):
			var pieces = unit.find_children("*", "MeshInstance3D", true, false)
			if unit is MeshInstance3D:
				pieces.append(unit)
			for piece in pieces:
				finish(piece, unit.scene_file_path.get_file())

func finish(piece: MeshInstance3D, part: String) -> void:
	if not piece.mesh:
		return
	for index in piece.mesh.get_surface_count():
		var base = piece.mesh.surface_get_material(index) as StandardMaterial3D
		if not base or base.transparency != BaseMaterial3D.TRANSPARENCY_DISABLED:
			continue
		var texture_name = ""
		if base.albedo_texture:
			texture_name = base.albedo_texture.resource_path.get_file().to_lower()
		var pigment = ""
		var role = 0
		if part.begins_with("Platform_3Plates"):
			pigment = "92a7ad"
			role = 1
		elif part.begins_with("Wall"):
			pigment = "41989c" if "jade" in texture_name else "324562"
			role = 2
		elif "ink" in texture_name:
			pigment = "263450"
		elif "ochre" in texture_name:
			pigment = "efae38"
		elif "red" in texture_name and not "steel" in texture_name and not "cream" in texture_name:
			pigment = "d0454b"
		elif "cream" in texture_name:
			pigment = "c7cebd"
		elif "steel" in texture_name:
			pigment = "7c93aa"
		if pigment == "" or part.begins_with("Prop_Light"):
			continue
		var key = part + str(index) + texture_name
		if not library.has(key):
			var material = ShaderMaterial.new()
			material.shader = PRESS_INK
			material.set_shader_parameter("enamel", Color(pigment))
			material.set_shader_parameter("shade", Color("22213b"))
			material.set_shader_parameter("stock", base.albedo_texture)
			material.set_shader_parameter("surface_role", role)
			library[key] = material
		piece.set_surface_override_material(index, library[key])
