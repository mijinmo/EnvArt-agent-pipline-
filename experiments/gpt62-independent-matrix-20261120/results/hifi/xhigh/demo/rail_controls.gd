extends PanelContainer
## Optional inspection UI; the rail component has no dependency on this panel.

@export var director: EACameraRig
@onready var toggle: Button = $Margin/Rows/Buttons/Toggle
@onready var play_button: Button = $Margin/Rows/Buttons/Play
@onready var rewind_button: Button = $Margin/Rows/Buttons/Rewind
@onready var loop_button: CheckButton = $Margin/Rows/Buttons/Loop
@onready var timeline: HSlider = $Margin/Rows/Timeline/Slider
@onready var time_label: Label = $Margin/Rows/Timeline/Time
var _dragging: bool = false


func _ready() -> void:
	toggle.pressed.connect(director.toggle_rail_view)
	play_button.pressed.connect(func(): director.rail_camera.toggle_playback())
	rewind_button.pressed.connect(func(): director.rail_camera.rewind())
	loop_button.toggled.connect(func(enabled: bool): director.rail_camera.set_looping(enabled))
	timeline.drag_started.connect(func():
		_dragging = true
		director.rail_camera.pause())
	timeline.drag_ended.connect(func(_changed: bool): _dragging = false)
	timeline.value_changed.connect(func(value: float): director.rail_camera.scrub(value))


func _process(_delta: float) -> void:
	var rail := director.rail_camera
	var available := is_instance_valid(rail) and rail.is_usable()
	var inspecting := available and director.mode == EACameraRig.Mode.RAIL
	toggle.disabled = not available
	toggle.text = "4  Return to previous view" if inspecting else "4  Enter rail camera"
	play_button.disabled = not inspecting
	rewind_button.disabled = not inspecting
	loop_button.disabled = not inspecting
	timeline.editable = inspecting
	if not available:
		time_label.text = "Assign a valid rail"
		return
	play_button.text = "P  Pause" if rail.is_playing() else "P  Play"
	loop_button.set_pressed_no_signal(rail.is_looping())
	timeline.max_value = rail.duration()
	if not _dragging:
		timeline.set_value_no_signal(rail.playhead())
	time_label.text = "%05.2f / %.2f s" % [rail.playhead(), rail.duration()]
