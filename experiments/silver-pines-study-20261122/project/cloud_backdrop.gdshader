shader_type spatial;
render_mode unshaded, fog_disabled, cull_disabled;
float hash(vec2 p){return fract(sin(dot(p,vec2(127.1,311.7)))*43758.5453);}
float noise(vec2 p){vec2 i=floor(p),f=fract(p);f=f*f*(3.0-2.0*f);return mix(mix(hash(i),hash(i+vec2(1,0)),f.x),mix(hash(i+vec2(0,1)),hash(i+vec2(1,1)),f.x),f.y);}
void fragment(){vec2 p=UV*vec2(11,5);float f=noise(p)*0.48+noise(p*2.04)*0.27+noise(p*4.03)*0.15+noise(p*8.0)*0.07+noise(p*19.0)*0.03;ALBEDO=mix(vec3(0.08,0.105,0.11),vec3(0.28,0.32,0.31),smoothstep(0.2,0.8,f));}
