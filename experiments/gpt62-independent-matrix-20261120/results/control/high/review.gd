extends Node3D
# Neutral view selection; the supplied controller handles all movement.
func _ready() -> void:
	$BaseLab/HUD/Panel.hide()
	for label in $BaseLab/World.find_children("*", "Label3D", true, false): label.hide()
	call_deferred("inspect", 0)
func inspect(index: int) -> void:
	var views = JSON.parse_string(FileAccess.get_file_as_string("res://views.json"))
	var v = views[index]
	var pos = Vector3(v.position[0], v.position[1], v.position[2])
	var target = Vector3(v.target[0], v.target[1], v.target[2])
	var pose = Transform3D(Basis.IDENTITY, pos).looking_at(target)
	$BaseLab/CameraRig.set_free_pose(pose, v.fov)
func _unhandled_key_input(event: InputEvent) -> void:
	if not event is InputEventKey or not event.pressed or event.echo: return
	match event.physical_keycode:
		KEY_5: inspect(0)
		KEY_6: inspect(1)
		KEY_7: inspect(2)
		_: return
	get_viewport().set_input_as_handled()
