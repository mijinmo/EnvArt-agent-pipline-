@tool
extends Node3D

@export var print_shader: Shader = preload("res://craft/wharf.gdshader")
@export var plain_comparison := false
@export var architectural_pigments: Dictionary[String,Texture2D] = {}
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
		if str(body.name).begins_with("Jump"):
			var crate := ShaderMaterial.new()
			crate.shader = preload("res://craft/packing_case.gdshader")
			crate.set_shader_parameter("case_size",(mesh_node.mesh as BoxMesh).size)
			mesh_node.material_override = crate
			continue
		var mat := StandardMaterial3D.new()
		match body.name:
			&"Floor":
				mat.albedo_color = Color("#a99588")
				mat.albedo_texture = preload("res://baseline/materials/paint/quay.png")
				mat.uv1_scale = Vector3(9,9,9)
			&"BackWall", &"OcclusionWall", &"OcclusionReturn":
				mat.albedo_color = Color("#594e4a")
			_:
				mat.albedo_texture = preload("res://baseline/materials/paint/quay.png")
				mat.albedo_color = Color("#7c6a60")
				var size: Vector3 = (mesh_node.mesh as BoxMesh).size
				mat.uv1_scale = Vector3(maxf(.40,size.x/2.4),maxf(.40,size.y/2.4),1)
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
		var roof := str(ancestor.name).begins_with("Roof_Wooden")
		for i in node.mesh.get_surface_count():
			var base := node.mesh.surface_get_material(i) as StandardMaterial3D
			if base:
				var role := "items"
				match base.resource_name:
					"MI_WoodTrim","MI_WoodTrim_Wear": role = "roof" if roof else "wood"
					"MI_Trim_Furniture": role = "boards"
					"MI_Trim_Metal": role = "cast"
					"MI_Trim_Cloth","MI_Banner": role = "fabric"
					"MI_Plaster": role = "plaster"
					"MI_Brick": role = "brick"
					"MI_UnevenBrick": role = "stone"
					"colormap": role = "survival"
				var key := str(base.get_instance_id()) + role
				var paint: StandardMaterial3D = cache.get(key)
				if not paint:
					paint = base.duplicate()
					if architectural_pigments.has(role):
						paint.albedo_texture = architectural_pigments[role]
					else:
						paint.albedo_texture = load("res://baseline/materials/paint/"+role+".png")
					paint.albedo_color = Color.WHITE
					cache[key] = paint
				var wash := Color.WHITE
				if role == "survival":
					wash = Color("#8eaaa9") if str(node.name).to_lower().contains("wheel") else Color("#92715a")
				if str(ancestor.name).begins_with("Bottle"):
					wash = Color("#2e6761")
				var treated := harmonize(paint,wash) as ShaderMaterial
				if treated:
					treated.set_shader_parameter("surface_role", {"plaster":1,"roof":2,"boards":3,"cast":4,"wood":5}.get(role,0))
					node.set_surface_override_material(i,treated)
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
