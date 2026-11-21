extends SceneTree
var errors: Array[String] = []
func _initialize() -> void:
	call_deferred("verify")
func verify() -> void:
	var args = OS.get_cmdline_user_args()
	if args.size() != 1:
		quit(2)
		return
	var saved = load("res://" + args[0]) as PackedScene
	if saved == null:
		quit(2)
		return
	var scene = saved.instantiate()
	root.add_child(scene)
	for i in range(3): await process_frame
	var original = load("res://source/whitebox.tscn").instantiate()
	root.add_child(original)
	var base = scene.get_node_or_null("BaseWhitebox")
	if base == null:
		errors.append("Missing BaseWhitebox instance")
	else:
		for body in original.get_node("World").get_children():
			if not body is StaticBody3D: continue
			var relative = NodePath("World/" + str(body.name))
			var actual = base.get_node_or_null(relative)
			if actual == null or not actual is StaticBody3D:
				errors.append(str(relative) + " missing body")
				continue
			if not actual.global_transform.is_equal_approx(body.global_transform): errors.append(str(relative) + " changed world transform")
			if actual.collision_layer != body.collision_layer or actual.collision_mask != body.collision_mask: errors.append(str(relative) + " changed collision layer/mask")
			for shape in body.get_children():
				if not shape is CollisionShape3D: continue
				var got = actual.get_node_or_null(NodePath(str(shape.name)))
				if got == null or not got is CollisionShape3D or got.disabled:
					errors.append(str(relative) + " missing/disabled shape")
				elif not got.global_transform.is_equal_approx(shape.global_transform) or not got.shape is BoxShape3D or not got.shape.size.is_equal_approx(shape.shape.size):
					errors.append(str(relative) + " changed collision geometry")
	print(JSON.stringify({"whitebox_bodies":17,"passed":errors.is_empty(),"errors":errors}))
	original.free()
	scene.free()
	quit(0 if errors.is_empty() else 2)
