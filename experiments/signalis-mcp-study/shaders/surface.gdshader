shader_type spatial;
render_mode diffuse_lambert, cull_disabled;
uniform sampler2D source_tex : source_color, filter_nearest_mipmap;
uniform bool has_texture = false;
uniform vec4 tint : source_color = vec4(0.66,0.68,0.62,1.0);
uniform float texture_saturation = 0.18;
uniform float texture_grid = 512.0;
uniform float grime = 0.1;
varying vec3 world_pos;
float hash(vec3 p){return fract(sin(dot(p,vec3(127.1,311.7,74.7)))*43758.5453);}
void vertex(){world_pos=(MODEL_MATRIX*vec4(VERTEX,1.0)).xyz;}
void fragment(){
 vec3 c=has_texture?texture(source_tex,(floor(UV*texture_grid)+0.5)/texture_grid).rgb:vec3(0.72);
 float l=dot(c,vec3(0.2126,0.7152,0.0722));
 c=mix(vec3(l),c,texture_saturation);
 float grain=hash(floor(world_pos*70.0));
 float mottling=hash(floor(world_pos*3.0));
 ALBEDO=clamp(c*tint.rgb*(0.94+grain*0.1)*(1.0-grime*mottling),vec3(0.018),vec3(0.85));
 ROUGHNESS=0.86;METALLIC=0.07;SPECULAR=0.25;
}
