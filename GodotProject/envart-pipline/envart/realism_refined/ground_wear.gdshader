shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_disabled;
varying vec3 world_pos;
float hash(vec2 p){return fract(sin(dot(p,vec2(127.1,311.7)))*43758.5453);}
float noise2(vec2 p){vec2 i=floor(p),f=fract(p);f=f*f*(3.0-2.0*f);return mix(mix(hash(i),hash(i+vec2(1,0)),f.x),mix(hash(i+vec2(0,1)),hash(i+vec2(1,1)),f.x),f.y);}
void vertex(){world_pos=(MODEL_MATRIX*vec4(VERTEX,1.0)).xyz;}
void fragment(){float n=noise2(world_pos.xz*5.0);float radial=length((UV-0.5)*2.0);ALBEDO=mix(vec3(0.10,0.078,0.043),vec3(0.19,0.17,0.085),n);ROUGHNESS=1.0;SPECULAR=0.15;ALPHA=(1.0-smoothstep(0.35,1.0,radial+(n-0.5)*0.28))*0.58;}
