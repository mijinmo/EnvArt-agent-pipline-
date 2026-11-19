@tool
extends Node3D

@export var print_shader: Shader = preload("res://materials/saltwood.gdshader")
@export var plain_comparison := false
var cache := {}

func _ready() -> void:
	if not get_node_or_null("Whitebox"):
		return
	var args := OS.get_cmdline_user_args()
	if "--whitebox" in args:
		$Harbor.hide()
		return
	plain_comparison = plain_comparison or "--control" in args
	for body in $Whitebox/World.get_children():
		var mesh_node := body.get_node_or_null("Mesh") as MeshInstance3D
		if mesh_node == null:
			continue
		var mat := StandardMaterial3D.new()
		match body.name:
			&"Floor":
				mat.albedo_color = Color("#bdb7ab")
				mat.albedo_texture = preload("res://materials/dockboards.svg")
				mat.uv1_scale = Vector3(5,5,5)
			&"BackWall", &"OcclusionWall", &"OcclusionReturn":
				mat.albedo_color = Color("#594e4a")
			_:
				mat.albedo_texture = preload("res://materials/dockboards.svg")
				mat.albedo_color = Color("#827f79")
				mat.uv1_scale = Vector3(.48,.48,.48)
		mesh_node.material_override = harmonize(mat,Color.WHITE)
	for mesh_node in $Harbor.find_children("*", "MeshInstance3D", true, false):
		var node := mesh_node as MeshInstance3D
		if node.mesh == null:
			continue
		var ancestor: Node = node
		while ancestor != self and not ancestor.has_meta("wash"):
			ancestor = ancestor.get_parent()
		if ancestor == self:
			continue
		var wash := Color(str(ancestor.get_meta("wash")))
		for i in node.mesh.get_surface_count():
			var base := node.mesh.surface_get_material(i) as StandardMaterial3D
			if base:
				var tint := wash
				if base.resource_name.contains("Plaster"):
					tint = Color("#ffe0b5")
				node.set_surface_override_material(i,harmonize(base,tint))
	if plain_comparison:
		var water := $Harbor.get_node_or_null("Sea") as MeshInstance3D
		if water:
			var base := StandardMaterial3D.new()
			base.albedo_color = Color("#294f57")
			base.roughness = .7
			water.material_override = base

func harmonize(original: StandardMaterial3D, wash: Color) -> Material:
	var key := str(original.get_instance_id()) + wash.to_html()
	if cache.has(key):
		return cache[key]
	var pigment := original.albedo_color * wash
	var mat: Material
	if plain_comparison:
		var standard := StandardMaterial3D.new()
		standard.albedo_texture = original.albedo_texture
		standard.albedo_color = pigment
		standard.uv1_scale = original.uv1_scale
		standard.vertex_color_use_as_albedo = original.vertex_color_use_as_albedo
		standard.roughness = .92
		standard.cull_mode = BaseMaterial3D.CULL_DISABLED
		standard.metallic_specular = 0
		mat = standard
	else:
		var ink := ShaderMaterial.new()
		ink.shader = print_shader
		ink.set_shader_parameter("wash",pigment)
		ink.set_shader_parameter("use_vertex",original.vertex_color_use_as_albedo)
		ink.set_shader_parameter("tiling",Vector2(original.uv1_scale.x,original.uv1_scale.y))
		if original.albedo_texture:
			ink.set_shader_parameter("pigment",original.albedo_texture)
		mat = ink
	cache[key] = mat
	return mat
