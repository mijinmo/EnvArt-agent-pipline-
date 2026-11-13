shader_type spatial;
render_mode cull_disabled;
uniform sampler2D leaf_mask : source_color, filter_linear_mipmap_anisotropic;
varying vec3 world_pos;
void vertex(){world_pos=(MODEL_MATRIX*vec4(VERTEX,1.0)).xyz;}
void fragment(){vec4 source=texture(leaf_mask,UV);float variation=0.5+0.5*sin(world_pos.x*37.0+world_pos.y*29.0+world_pos.z*31.0);ALBEDO=mix(vec3(0.028,0.047,0.013),vec3(0.075,0.10,0.029),variation)*mix(0.85,1.15,source.r);ROUGHNESS=0.95;SPECULAR=0.2;ALPHA=source.a;ALPHA_SCISSOR_THRESHOLD=0.5;}
