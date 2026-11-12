extends Node3D
## Load one playable variant at a time; inactive variants cannot leave collisions/lights behind.
const SCENES := ["res://envart/local_sample/local_sample.tscn","res://envart/direction_studies/ashen.tscn","res://envart/direction_studies/facility.tscn"]
const TITLES := ["SUNLIT DELIVERY YARD","COURT OF ASH","FACILITY 07"]
@export_range(0,2) var initial_direction: int=0
var current_direction: int=-1
var sample: Node3D
func _ready() -> void:
	select_direction(initial_direction)
func select_direction(index: int) -> void:
	if index<0 or index>=SCENES.size() or current_direction==index:return
	var state: Dictionary={}
	if is_instance_valid(sample):
		var player: EAPlayerMotor=sample.get_node("BaseLab/Player")
		var rig: EACameraRig=sample.get_node("BaseLab/CameraRig")
		state={"player":player.global_transform,"mode":rig.mode,"yaw":rig.yaw,"pitch":rig.pitch,"free":rig.free_camera.global_transform,"fov":rig.free_camera.fov,"rail_time":rig.rail_camera.playhead(),"loop":rig.rail_camera.is_looping(),"whitebox":sample.whitebox,"backdrop":sample.backdrop_enabled,"hud":sample.get_node("HUD").visible}
		# Remove the old physics bodies before installing the replacement scene.
		remove_child(sample);sample.free()
	sample=load(SCENES[index]).instantiate();add_child(sample);current_direction=index
	if not state.is_empty():
		var player: EAPlayerMotor=sample.get_node("BaseLab/Player")
		var rig: EACameraRig=sample.get_node("BaseLab/CameraRig")
		player.teleport_to(state.player)
		rig.yaw=state.yaw;rig.pitch=state.pitch
		rig.set_free_pose(state.free,state.fov);rig.set_mode(state.mode,true)
		rig.rail_camera.scrub(state.rail_time);rig.rail_camera.set_looping(state.loop)
		sample.backdrop_enabled=state.backdrop;sample.set_whitebox(state.whitebox);sample.get_node("HUD").visible=state.hud
	$HUD/Hint.text="Z Sunlit  /  X Ashen  /  C Facility    —    "+TITLES[index]
	$HUD.visible=sample.get_node("HUD").visible
func _unhandled_key_input(event: InputEvent) -> void:
	if not event is InputEventKey or not event.pressed or event.echo:return
	match event.physical_keycode:
		KEY_Z: select_direction(0)
		KEY_X: select_direction(1)
		KEY_C: select_direction(2)
		_:return
	get_viewport().set_input_as_handled()
func _process(_delta: float) -> void:
	if is_instance_valid(sample):$HUD.visible=sample.get_node("HUD").visible
