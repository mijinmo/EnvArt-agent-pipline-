extends "res://envart/local_sample/sample.gd"
## Isolated material/asset experiment; original collision and controller are retained.
func _ready() -> void:
	super()
	var ground: Material=load("res://envart/realism_trial/ground.tres")
	for mesh in dressed_materials:
		dressed_materials[mesh]=ground
	set_whitebox(false)
func set_whitebox(enabled: bool) -> void:
	super(enabled)
	for body_name in ["DoorLeft","DoorRight","DoorLintel","OcclusionWall","OcclusionReturn","BackWall"]:
		lab.get_node("World/"+body_name+"/Mesh").visible=enabled
	lab.get_node("World/SpawnPad/Mesh").visible=enabled
func update_hint() -> void:
	$HUD/Hint.text="POLY HAVEN / MATERIAL TRIAL"+("  [WHITEBOX]" if whitebox else "")+"\n5 Door · 6 Ramp · 7 Props · 8 Vista · B Backdrop\n0 Compare · H Hide · 1 First · 2 Third · 3 Free · 4 Rail"
