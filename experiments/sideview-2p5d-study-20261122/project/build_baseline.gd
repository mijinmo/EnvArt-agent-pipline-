extends SceneTree
func _initialize() -> void: call_deferred("run")
func run() -> void:
	var h=load("res://asset_helpers.gd").new()
	h.root=Node3D.new()
	h.root.name="WhiteboxBaseline"
	root.add_child(h.root)
	h.environment()
	var base=load("res://source/whitebox.tscn").instantiate()
	h.root.add_child(base)
	base.owner=h.root
	h.save("res://whitebox-baseline.tscn")
	quit()
