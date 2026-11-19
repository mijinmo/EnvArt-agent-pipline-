class_name EAHumanoidVisual
extends Node3D
## Read-only presentation adapter: never writes velocity, transforms or collision.
@export var model_path: String = "res://characters/mixamo_local/humanoid.scn"
@export var reference_height: float = 1.765052
@export var walk_reference_speed: float = 1.60
@export var run_reference_speed: float = 4.5
var motor: EAPlayerMotor
var model: Node3D
var animation: AnimationPlayer
var state: StringName = &""
var airborne_time: float = 0.0
var available: bool = false

func _ready() -> void:
	# Parent is Visual; its parent is the controller. Defer until motor's onready completes.
	call_deferred("setup")

func setup() -> void:
	motor = get_parent().get_parent() as EAPlayerMotor
	if motor == null or not ResourceLoader.exists(model_path): return
	var packed := load(model_path) as PackedScene
	if packed == null: return
	model = packed.instantiate()
	add_child(model)
	model.rotation.y = PI # Mixamo faces +Z; the controller's forward is -Z.
	model.scale = Vector3.ONE * motor.profile.height / reference_height
	model.position.y = -0.004113 * model.scale.y
	animation = model.get_node_or_null("AnimationPlayer")
	if animation == null: return
	available = true
	motor.body_mesh.hide()
	motor.facing_marker.hide()
	set_state(&"idle")

func set_state(next: StringName) -> void:
	if state == next: return
	state = next
	animation.play(next,0.14)
	if next == &"jump":
		# Skip the anticipation: physics has already left the floor.
		animation.seek(0.5,true)

func _physics_process(delta: float) -> void:
	if not available: return
	var speed := Vector2(motor.velocity.x,motor.velocity.z).length()
	if not motor.is_on_floor():
		airborne_time += delta
		# Ignore very short floor contact gaps on slopes.
		if airborne_time > 0.05 or motor.velocity.y > 1.0:
			set_state(&"jump")
			animation.speed_scale = 1.7
			if animation.current_animation_position > 1.3:
				animation.seek(1.3,true)
				animation.speed_scale = 0.0
			return
	else:
		airborne_time = 0
	if speed < 0.12:
		set_state(&"idle")
		animation.speed_scale = 1.0
	elif speed < 2.6:
		set_state(&"walking")
		animation.speed_scale = clampf(speed/walk_reference_speed,0.4,1.7)
	else:
		set_state(&"running")
		animation.speed_scale = clampf(speed/run_reference_speed,0.55,1.8)
