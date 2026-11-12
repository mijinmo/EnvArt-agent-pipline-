shader_type spatial;
render_mode cull_disabled;
varying vec3 p;
float noise2(vec2 q){vec2 i=floor(q),f=fract(q);f=f*f*(3.0-2.0*f);vec4 n=fract(sin(vec4(dot(i,vec2(127.1,311.7)),dot(i+vec2(1,0),vec2(127.1,311.7)),dot(i+vec2(0,1),vec2(127.1,311.7)),dot(i+vec2(1,1),vec2(127.1,311.7))))*43758.5453);return mix(mix(n.x,n.y,f.x),mix(n.z,n.w,f.x),f.y);}
void vertex(){p=(MODEL_MATRIX*vec4(VERTEX,1)).xyz;}
void fragment(){ALBEDO=mix(vec3(0.11,0.125,0.14),vec3(0.20,0.22,0.24),noise2(p.xz*0.17))*(0.91+noise2(p.xz*18.0)*0.18);ROUGHNESS=1.0;}
