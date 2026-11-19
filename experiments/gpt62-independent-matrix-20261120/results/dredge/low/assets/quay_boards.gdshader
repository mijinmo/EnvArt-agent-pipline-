shader_type spatial;
varying vec3 world;
float hash(vec2 p){return fract(sin(dot(p,vec2(41.7,113.5)))*43758.5453);}
void vertex(){world=(MODEL_MATRIX*vec4(VERTEX,1.0)).xyz;}
void fragment(){
 float row=floor(world.z/.26);
 vec2 p=vec2(world.x+hash(vec2(row,2.0))*3.0,world.z);
 vec2 id=vec2(floor(p.x/3.1),row);
 vec2 uv=fract(p/vec2(3.1,.26));
 float seed=hash(id);
 vec2 edge=min(uv,1.0-uv)*vec2(3.1,.26);
 float seam=smoothstep(.002,.009,min(edge.x,edge.y));
 float grain=sin(uv.y*68.0+sin(uv.x*7.0+seed*33.0)*1.5);
 vec3 wood=mix(vec3(.14,.10,.078),vec3(.27,.215,.159),seed);
 ALBEDO=wood*mix(.52,1.0,seam)*(1.0+.035*grain);
 ROUGHNESS=.9;
}
