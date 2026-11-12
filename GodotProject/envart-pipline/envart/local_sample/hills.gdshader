shader_type spatial;
render_mode cull_disabled;
uniform vec4 near_grass : source_color = vec4(0.392157,0.447059,0.286275,1.0);
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
	float border_distance=max(abs(world_pos.x),abs(world_pos.z));
	vec3 grass=mix(near_grass.rgb,COLOR.rgb,smoothstep(16.0,23.0,border_distance));
	ALBEDO=grass*mix(0.76,1.14,macro)*(0.97+fine*0.06);
	ROUGHNESS=1.0;
}
