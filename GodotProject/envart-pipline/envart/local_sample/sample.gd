extends Node3D
## Small asset-first review slice. Gameplay remains in the original BaseLab.
const DRESSED := ["DoorLeft","DoorRight","DoorLintel","Ramp","Landing","OcclusionWall","OcclusionReturn","BackWall"]
var whitebox := false
var backdrop_enabled := true
var original_materials := {}
var dressed_materials := {}
@onready var lab: Node3D = $BaseLab
@onready var rig: EACameraRig = $BaseLab/CameraRig
func _ready() -> void:
	lab.get_node("HUD/Panel").hide()
	for label in lab.get_node("World").find_children("*","Label3D",true,false): label.hide()
	var masonry := StandardMaterial3D.new()
	masonry.albedo_texture = load("res://envart/assets/quaternius_village/T_UnevenBrick_BaseColor.png")
	masonry.normal_enabled = true
	masonry.normal_texture = load("res://envart/assets/quaternius_village/T_UnevenBrick_Normal.png")
	masonry.normal_scale = 0.45
	masonry.roughness = 0.9
	masonry.uv1_triplanar = true; masonry.uv1_world_triplanar = true; masonry.uv1_scale = Vector3.ONE*0.55
	var timber := masonry.duplicate()
	timber.albedo_texture = load("res://envart/assets/quaternius_village/T_WoodTrim_BaseColor.png")
	timber.normal_texture = load("res://envart/assets/quaternius_village/T_WoodTrim_Normal.png")
	for body_name in DRESSED:
		var mesh: MeshInstance3D = lab.get_node("World/"+body_name+"/Mesh")
		original_materials[mesh] = mesh.material_override
		dressed_materials[mesh] = timber if body_name == "Ramp" else masonry
		mesh.material_override = dressed_materials[mesh]
	# Only unconverted test obstacles retain the neutral review material.
	var context := StandardMaterial3D.new(); context.albedo_color = Color("8b9189"); context.roughness = 1
	var ground: ShaderMaterial = load("res://envart/local_sample/courtyard_ground.tres").duplicate()
	var backdrop_config: EABackdropConfig = load("res://envart/local_sample/backdrop_config.tres")
	ground.set_shader_parameter("grass_color",backdrop_config.near_grass)
	for body in lab.get_node("World").get_children():
		if body is StaticBody3D and not body.name in DRESSED:
			var mesh: MeshInstance3D = body.get_node("Mesh")
			original_materials[mesh] = mesh.material_override
			var surface: Material = ground if body.name in ["Floor","SpawnPad"] else context
			dressed_materials[mesh] = surface; mesh.material_override = surface
	lab.get_node("Spawn").position = Vector3(-0.2,0.08,-2.1)
	lab.reset_player()
	# Review markers are ordinary editable nodes in the scene.
	set_whitebox(false)
	inspect(0)
func update_hint() -> void:
	$HUD/Hint.text = "DELIVERY YARD / LOCAL SAMPLE" + ("  [WHITEBOX]" if whitebox else "") + "\n5 Door  ·  6 Ramp  ·  7 Props  ·  8 Vista  ·  B Backdrop\n0 Compare  ·  H Hide  ·  1 First  ·  2 Third  ·  3 Free  ·  4 Rail"
func set_whitebox(enabled: bool) -> void:
	whitebox = enabled; $Art.visible = not enabled
	$Backdrop.visible = not enabled and backdrop_enabled
	lab.get_node("WorldEnvironment").environment.fog_enabled = not enabled and backdrop_enabled
	for name in ["OcclusionWall", "OcclusionReturn"]: lab.get_node("World/"+name+"/Mesh").visible = enabled
	for mesh in original_materials:
		mesh.material_override = original_materials[mesh] if enabled else dressed_materials[mesh]
	for shape in $Art.find_children("*","CollisionShape3D",true,false): shape.set_deferred("disabled",enabled)
	for lamp in $Art.find_children("*","Light3D",true,false): lamp.visible = not enabled
	update_hint()
func inspect(index: int) -> void:
	var marker: Marker3D = $ReviewViews.get_child(index)
	rig.set_free_pose(marker.global_transform,62)
func _unhandled_key_input(event: InputEvent) -> void:
	if not event is InputEventKey or not event.pressed or event.echo: return
	match event.physical_keycode:
		KEY_0: set_whitebox(not whitebox)
		KEY_5: inspect(0)
		KEY_6: inspect(1)
		KEY_7: inspect(2)
		KEY_8: inspect(3)
		KEY_B:
			backdrop_enabled = not backdrop_enabled
			$Backdrop.visible = backdrop_enabled and not whitebox
			lab.get_node("WorldEnvironment").environment.fog_enabled = backdrop_enabled and not whitebox
		KEY_H: $HUD.visible = not $HUD.visible
		_: return
	get_viewport().set_input_as_handled()
