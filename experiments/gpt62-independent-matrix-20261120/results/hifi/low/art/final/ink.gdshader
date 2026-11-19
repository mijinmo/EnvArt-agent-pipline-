shader_type spatial;
render_mode unshaded,cull_front;
void vertex(){VERTEX+=NORMAL*.0035;}
void fragment(){ALBEDO=vec3(.008,.012,.025);}