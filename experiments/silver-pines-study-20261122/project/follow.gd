extends Camera3D
@export var target: NodePath
func _process(delta: float) -> void:
	var p = get_node_or_null(target)
	if p:
		position.x = lerpf(position.x, clampf(p.position.x*0.50,-4.8,4.8), 1.0-exp(-delta*3.0))
