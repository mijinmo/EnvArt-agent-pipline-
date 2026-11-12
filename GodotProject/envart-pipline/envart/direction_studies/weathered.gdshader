shader_type spatial;
uniform sampler2D source_color_tex : source_color, filter_linear_mipmap_anisotropic, repeat_enable;
uniform vec4 tint : source_color = vec4(0.58,0.61,0.63,1.0);
varying vec3 world_pos;
float hash(vec2 p) { return fract(sin(dot(p,vec2(127.1,311.7)))*43758.5453); }
float noise2(vec2 p) {
 vec2 i=floor(p),f=fract(p);f=f*f*(3.0-2.0*f);
 return mix(mix(hash(i),hash(i+vec2(1,0)),f.x),mix(hash(i+vec2(0,1)),hash(i+vec2(1,1)),f.x),f.y);
}
void vertex(){world_pos=(MODEL_MATRIX*vec4(VERTEX,1.0)).xyz;}
void fragment(){
 vec3 raw=texture(source_color_tex,UV).rgb;
 float grime=noise2(world_pos.xz*1.4+world_pos.y*0.29);
 float grain=noise2(world_pos.xz*29.0+world_pos.y*19.0);
 ALBEDO=raw*tint.rgb*(0.77+grime*0.30+grain*0.09);
 ROUGHNESS=0.92;
}
