extends Node3D
func _ready() -> void:
	call_deferred("inspect", 0)
func inspect(index: int) -> void:
	var views = JSON.parse_string(FileAccess.get_file_as_string("res://views.json"))
	var v = views[index]
	var p = Vector3(v.position[0], v.position[1], v.position[2])
	var t = Vector3(v.target[0], v.target[1], v.target[2])
	$CameraRig.set_free_pose(Transform3D(Basis.IDENTITY, p).looking_at(t), v.fov)
func _unhandled_key_input(event: InputEvent) -> void:
	if not event is InputEventKey or not event.pressed or event.echo: return
	match event.physical_keycode:
		KEY_5: inspect(0)
		KEY_6: inspect(1)
		KEY_7: inspect(2)
		_: return
	get_viewport().set_input_as_handled()
