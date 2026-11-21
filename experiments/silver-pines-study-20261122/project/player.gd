extends CharacterBody3D
## A deliberately small 2.5D controller: X movement, Y gravity, fixed Z lane.
const SPEED := 2.7
const JUMP := 5.1
const GRAVITY := 15.5
var timer := 0.0
var facing := 1.0
@onready var sprite: Sprite3D = $InkSprite
func _physics_process(delta: float) -> void:
	var axis := Input.get_axis("left", "right")
	velocity.x = move_toward(velocity.x, axis*SPEED, delta*18.0)
	velocity.z = 0
	if not is_on_floor(): velocity.y -= GRAVITY*delta
	elif Input.is_action_just_pressed("jump"): velocity.y = JUMP
	move_and_slide()
	position.z = 1.4
	position.x = clampf(position.x,-12.2,12.2)
	if position.y < -3: position = Vector3(-1.3,1.08,1.4)
	if absf(axis)>0.1: facing = signf(axis)
	sprite.flip_h = facing < 0
	timer += delta
	sprite.frame = 5 if not is_on_floor() else (1+int(timer*7.5)%4 if absf(velocity.x)>0.15 else 0)
	sprite.position.y = 0.93 if sprite.frame != 5 else 1.13
