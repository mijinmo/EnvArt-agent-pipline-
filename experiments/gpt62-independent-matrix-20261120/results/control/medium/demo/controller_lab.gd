extends Node3D
## Test harness only. Production levels do not need this scene or its HUD.

@onready var player: EAPlayerMotor = $Player
@onready var cameras: EACameraRig = $CameraRig
@onready var input_adapter: EAPlayerInput = $PlayerInput
@onready var spawn: Marker3D = $Spawn
@onready var status: Label = $HUD/Panel/Margin/Readout
@onready var crosshair: Label = $HUD/Crosshair


func _ready() -> void:
	input_adapter.reset_requested.connect(reset_player)
	reset_player()


func reset_player() -> void:
	player.teleport_to(spawn.global_transform)
	cameras.reset_view(spawn.global_rotation.y)


func _process(_delta: float) -> void:
	if player.global_position.y < -15.0:
		reset_player()
	var names := ["FIRST PERSON", "THIRD PERSON", "FREE OBSERVER", "RAIL INSPECTION"]
	var captured := Input.mouse_mode == Input.MOUSE_MODE_CAPTURED
	var camera_detail := "Fly %.1f m/s  |  E / Q up / down" % cameras.free_speed if cameras.mode == EACameraRig.Mode.FREE_LOOK else "Body %.2f m  |  Eye %.2f m  |  Jump %.2f m" % [player.profile.height, player.eye.position.y, player.profile.jump_height]
	if cameras.mode == EACameraRig.Mode.RAIL:
		camera_detail = "Rail %s  |  P play / pause  |  Home rewind" % ("PLAYING" if cameras.rail_camera.is_playing() else "PAUSED")
	status.text = "ENVART / CONTROLLER LAB\n%s   |   %s\n\nW A S D move   /   Mouse look   /   Shift fast\nSpace jump   /   V perspective   /   F observer\n1 first   /   2 third   /   3 observer   /   4 rail\nWheel: orbit distance / fly speed   /   R respawn\nEsc release cursor   /   Click to capture\n\n%s\nPlayer (%.1f, %.1f, %.1f)   Speed %.1f m/s" % [
		names[cameras.mode], "ACTIVE" if captured else "CLICK TO EXPLORE", camera_detail,
		player.global_position.x, player.global_position.y, player.global_position.z,
		Vector2(player.velocity.x, player.velocity.z).length()]
	crosshair.visible = captured and cameras.mode == EACameraRig.Mode.FIRST_PERSON
