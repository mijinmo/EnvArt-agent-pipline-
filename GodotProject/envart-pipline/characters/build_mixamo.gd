extends SceneTree
## Local conversion: consumes the user's licensed Mixamo FBX downloads.
## Output remains local; scripts and acquisition instructions are versioned.
const DIR := "res://characters/mixamo_local/"
func _initialize() -> void:
	call_deferred("build")
func build() -> void:
	for file in ["mannequin", "idle", "walking", "running", "jump"]:
		if not ResourceLoader.exists(DIR+file+".fbx"):
			push_error("Import required Mixamo FBX first: " + file)
			quit(1)
			return
	var model: Node3D = load(DIR+"mannequin.fbx").instantiate()
	model.name = "Mannequin"
	var skeleton: Skeleton3D = model.get_node("Skeleton3D")
	var player: AnimationPlayer = model.get_node("AnimationPlayer")
	for lib in player.get_animation_library_list(): player.remove_animation_library(lib)
	var library := AnimationLibrary.new()
	var skin := StandardMaterial3D.new()
	skin.albedo_color = Color("b6b2a3")
	skin.roughness = 0.8
	for mesh in model.find_children("*", "MeshInstance3D", true, false):
		# Keep silhouette / skinned mesh, use a restrained shared finish for all three studies.
		mesh.material_override = skin
	for file in ["idle", "walking", "running", "jump"]:
		var imported: Node3D = load(DIR+file+".fbx").instantiate()
		var source_player: AnimationPlayer = imported.get_node("AnimationPlayer")
		var clip: Animation = source_player.get_animation("mixamo_com").duplicate(true)
		clip.resource_name = file
		clip.loop_mode = Animation.LOOP_LINEAR if file != "jump" else Animation.LOOP_NONE
		for track in range(clip.get_track_count()-1,-1,-1):
			var path := clip.track_get_path(track)
			if path.get_subname_count() == 0:
				clip.remove_track(track)
				continue
			var bone_name := str(path.get_subname(0))
			var bone := skeleton.find_bone(bone_name)
			if bone < 0:
				push_error("Unknown bone: "+bone_name)
				quit(1)
				return
			clip.track_set_path(track,NodePath("Skeleton3D:"+bone_name))
			if clip.track_get_type(track) == Animation.TYPE_POSITION_3D and bone == 0:
				var rest := skeleton.get_bone_rest(0).origin
				for key in clip.track_get_key_count(track):
					var value: Vector3 = clip.track_get_key_value(track,key)
					# Root travel belongs to CharacterBody3D. Keep locomotion hip bob only.
					value.x = rest.x
					value.z = rest.z
					if file == "jump": value.y = rest.y
					clip.track_set_key_value(track,key,value)
		library.add_animation(file,clip)
		print("Prepared ",file," / ",clip.length," seconds / ",clip.get_track_count()," tracks")
		imported.free()
	player.add_animation_library("",library)
	player.play("idle")
	player.advance(0)
	player.stop()
	var packed := PackedScene.new()
	assert(packed.pack(model)==OK)
	assert(ResourceSaver.save(packed,DIR+"humanoid.scn",ResourceSaver.FLAG_COMPRESS)==OK)
	model.free()
	print("MIXAMO BUILD RESULT: PASS")
	quit()
