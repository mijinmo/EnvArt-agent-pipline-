shader_type spatial;
render_mode diffuse_lambert;
uniform vec4 base_color : source_color = vec4(0.27,0.29,0.27,1.0);
uniform float wear = 0.16;
varying vec3 world_pos;
float h(vec2 p){return fract(sin(dot(p,vec2(127.1,311.7)))*43758.5453);}
void vertex(){world_pos=(MODEL_MATRIX*vec4(VERTEX,1.0)).xyz;}
void fragment(){
 vec2 p=world_pos.xz/0.72;vec2 q=fract(p);vec2 cell=floor(p);
 float grout=1.0-smoothstep(0.012,0.032,min(min(q.x,q.y),min(1.0-q.x,1.0-q.y)));
 float n=h(floor(world_pos.xz*70.0));
 float scuff=step(0.94,h(floor(world_pos.xz*18.0)))*step(0.45,h(floor(world_pos.xz*2.0)));
 vec3 c=base_color.rgb*(0.82+0.26*h(cell)+0.04*n);
 c=mix(c,c*0.5,grout);c+=scuff*wear*0.45;
 ALBEDO=c;ROUGHNESS=0.72+0.18*h(cell);SPECULAR=0.3;
}
