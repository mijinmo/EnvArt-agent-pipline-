extends SceneTree
func _initialize():call_deferred('run')
func run():
 var s=load('res://main.tscn').instantiate();root.add_child(s)
 var out='round-01'
 for a in OS.get_cmdline_user_args():
  if a.begins_with('round='):out=a.trim_prefix('round=')
 DirAccess.make_dir_recursive_absolute('res://captures/'+out)
 for name in ['overall','detail','transition']:
  s.get_node(name).make_current()
  await create_timer(1.0).timeout
  RenderingServer.force_draw()
  var img=root.get_texture().get_image();img.save_png('res://captures/'+out+'/'+name+'.png');print('CAPTURE ',name)
 quit()
