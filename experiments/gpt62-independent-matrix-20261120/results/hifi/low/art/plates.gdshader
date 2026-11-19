shader_type spatial;
varying vec3 world;
void vertex(){world=(MODEL_MATRIX*vec4(VERTEX,1.0)).xyz;}
void fragment(){
 vec2 uv=world.xz/1.22;
 vec2 edge=min(fract(uv),1.-fract(uv));
 float seam=smoothstep(.003,.012,min(edge.x,edge.y));
 float band=step(.79,fract(uv.x*.3333));
 float tread=step(.72,cos((uv.x+uv.y)*120.))*step(.2,cos(uv.y*87.))*band;
 float variation=fract(sin(dot(floor(uv),vec2(12.31,74.21)))*431.66);
 ALBEDO=mix(vec3(.014,.021,.032),vec3(.085,.12,.157)*(.85+.25*variation-.23*tread),seam);
 ROUGHNESS=.83;
}