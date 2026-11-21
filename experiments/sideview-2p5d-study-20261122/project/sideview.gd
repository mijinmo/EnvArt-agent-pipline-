extends Node3D
# Camera/input adapter only. Movement, slopes and jump physics use EAPlayerMotor unchanged.
var following := true
var views: Array
func _ready() -> void:
	views = JSON.parse_string(FileAccess.get_file_as_string("res://views.json"))
	process_physics_priority = -10
func _physics_process(_delta: float) -> void:
	var axis := Input.get_vector("ea_left","ea_right","ea_forward","ea_back")
	$Player.set_motion(Vector3(axis.x,0,axis.y),Input.is_action_pressed("ea_sprint"),Input.is_action_just_pressed("ea_jump"))
	if Input.is_action_just_pressed("ea_reset") or $Player.position.y < -8:
		$Player.teleport_to(Transform3D(Basis.IDENTITY,Vector3(-3,0.1,2)))
func _process(delta: float) -> void:
	if not following: return
	var x := clampf($Player.position.x,-8,8)
	$SideCamera.position = $SideCamera.position.lerp(Vector3(x,4.4,22),1.0-exp(-4.5*delta))
	$SideCamera.look_at(Vector3($SideCamera.position.x,1.8,-2))
func _unhandled_key_input(event: InputEvent) -> void:
	if not event is InputEventKey or not event.pressed or event.echo: return
	if event.physical_keycode == KEY_4:
		following = true
		$SideCamera.fov = 32
	elif event.physical_keycode in [KEY_5,KEY_6,KEY_7,KEY_8]:
		following = false
		var v = views[event.physical_keycode-KEY_5]
		$SideCamera.position = Vector3(v.position[0],v.position[1],v.position[2])
		$SideCamera.look_at(Vector3(v.target[0],v.target[1],v.target[2]))
		$SideCamera.fov = v.fov
