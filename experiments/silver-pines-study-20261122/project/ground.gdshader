shader_type spatial;
uniform vec3 base_color : source_color = vec3(0.09,0.12,0.12);
varying vec3 world;
float hash(vec2 p){return fract(sin(dot(p,vec2(127.1,311.7)))*43758.5453);}
float noise(vec2 p){vec2 i=floor(p),f=fract(p);f=f*f*(3.0-2.0*f);return mix(mix(hash(i),hash(i+vec2(1,0)),f.x),mix(hash(i+vec2(0,1)),hash(i+vec2(1,1)),f.x),f.y);}
void vertex(){world=(MODEL_MATRIX*vec4(VERTEX,1)).xyz;}
void fragment(){float n=noise(world.xz*1.7)*0.7+noise(world.xz*38.0)*0.3;float wet=smoothstep(0.48,0.62,noise(world.xz*0.65));ALBEDO=base_color*(0.3+n*0.16);ROUGHNESS=mix(0.85,0.24,wet);METALLIC=0.0;SPECULAR=0.22;NORMAL_MAP=vec3(0.5+(noise(world.xz*85.0)-0.5)*0.14,0.5,1.0);}
