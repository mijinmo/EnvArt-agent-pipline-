shader_type spatial;
render_mode cull_disabled;
varying vec3 world_pos;
float hash(vec2 p) { return fract(sin(dot(p,vec2(127.1,311.7)))*43758.5453); }
float noise2(vec2 p) {
	vec2 i=floor(p), f=fract(p); f=f*f*(3.0-2.0*f);
	return mix(mix(hash(i),hash(i+vec2(1,0)),f.x),mix(hash(i+vec2(0,1)),hash(i+vec2(1,1)),f.x),f.y);
}
void vertex() { world_pos=(MODEL_MATRIX*vec4(VERTEX,1.0)).xyz; }
void fragment() {
	float macro=noise2(world_pos.xz*0.10)*0.65+noise2(world_pos.xz*0.39)*0.35;
	float fine=noise2(world_pos.xz*1.7);
	ALBEDO=COLOR.rgb*mix(0.76,1.14,macro)*(0.97+fine*0.06);
	ROUGHNESS=1.0;
}
