extends "res://envart/local_sample/sample.gd"
@export_enum("Ashen","Facility") var art_direction: int=0
func _ready() -> void:
	super()
	var stone:=StandardMaterial3D.new();stone.roughness=0.88
	stone.albedo_texture=load("res://envart/assets/quaternius_village/T_UnevenBrick_BaseColor.png")
	stone.albedo_color=Color("67717b");stone.uv1_triplanar=true;stone.uv1_world_triplanar=true;stone.uv1_scale=Vector3.ONE*0.55
	var foundation:=ShaderMaterial.new();foundation.shader=load("res://envart/direction_studies/ash_terrain.gdshader")
	var panel:=StandardMaterial3D.new();panel.albedo_color=Color("818e99");panel.roughness=0.7;panel.metallic=0.2
	for mesh in dressed_materials:
		dressed_materials[mesh]=foundation if mesh.get_parent().name in ["Floor","SpawnPad"] else (stone if art_direction==0 else panel)
	set_whitebox(false)
func set_whitebox(enabled: bool) -> void:
	super(enabled)
	for body_name in DRESSED:
		lab.get_node("World/"+body_name+"/Mesh").visible=enabled
	lab.get_node("World/SpawnPad/Mesh").visible=enabled
	lab.get_node("World/Floor/Mesh").visible=enabled
func update_hint() -> void:
	$HUD/Hint.text=("COURT OF ASH" if art_direction==0 else "FACILITY 07")+("  [WHITEBOX]" if whitebox else "")+"\n5 Door · 6 Ramp · 7 Props · 8 Vista · B Backdrop\n0 Compare · H Hide · 1 First · 2 Third · 3 Free · 4 Rail"
