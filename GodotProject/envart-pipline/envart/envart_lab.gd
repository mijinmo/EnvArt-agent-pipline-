extends Node3D
## The original lab owns all gameplay. Styles own visual surfaces and lighting only.
const TITLES := ["00 / WHITEBOX", "01 / VERDANT RELIQUARY", "02 / COURT OF ASH", "03 / FACILITY 07"]
@export_range(0, 3) var initial_style: int = 1
@onready var lab: Node3D = $BaseLab
@onready var styles: Node3D = $Styles
@onready var readout: Label = $HUD/Panel/Margin/Rows/Readout
var current_style: int = 0
var original_environment: Environment
var original_sun_color: Color
var original_sun_energy: float
var original_sun_rotation: Vector3

func _ready() -> void:
	original_environment = lab.get_node("WorldEnvironment").environment
	var sun: DirectionalLight3D = lab.get_node("Sun")
	original_sun_color = sun.light_color
	original_sun_energy = sun.light_energy
	original_sun_rotation = sun.rotation_degrees
	lab.get_node("HUD/Panel").hide()
	for i in 4:
		get_node("HUD/Panel/Margin/Rows/Buttons/Style%d" % i).pressed.connect(select_style.bind(i))
	select_style(initial_style)

func select_style(index: int) -> void:
	if index < 0 or index > 3: return
	current_style = index
	for i in styles.get_child_count():
		var layer: Node3D = styles.get_child(i)
		layer.visible = i == index - 1
		# Visibility does not stop lights; disable processing is insufficient for rendering.
		for light in layer.find_children("*", "Light3D", true, false):
			light.visible = layer.visible
	for mesh in lab.get_node("World").find_children("*", "MeshInstance3D", true, false):
		mesh.visible = index == 0
	for label in lab.find_children("*", "Label3D", true, false):
		label.visible = index == 0
	var sun: DirectionalLight3D = lab.get_node("Sun")
	if index == 0:
		lab.get_node("WorldEnvironment").environment = original_environment
		sun.light_color = original_sun_color
		sun.light_energy = original_sun_energy
		sun.rotation_degrees = original_sun_rotation
	else:
		var layer = styles.get_child(index-1)
		lab.get_node("WorldEnvironment").environment = layer.environment
		sun.light_color = layer.sun_color
		sun.light_energy = layer.sun_energy
		sun.rotation_degrees = layer.sun_rotation
	for i in 4:
		get_node("HUD/Panel/Margin/Rows/Buttons/Style%d" % i).button_pressed = i == index
	readout.text = TITLES[index] + "\n5 / 6 / 7 styles  ·  0 whitebox  ·  H hide guide\n1 first  ·  2 third  ·  3 free  ·  4 rail  ·  P play\nWASD move  ·  Shift run  ·  Space jump  ·  Esc cursor"

func _unhandled_key_input(event: InputEvent) -> void:
	if not event is InputEventKey or not event.pressed or event.echo: return
	match event.physical_keycode:
		KEY_0: select_style(0)
		KEY_5: select_style(1)
		KEY_6: select_style(2)
		KEY_7: select_style(3)
		KEY_H: $HUD/Panel.visible = not $HUD/Panel.visible
		_: return
	get_viewport().set_input_as_handled()
