shader_type spatial;
uniform sampler2D stone_color : source_color, filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D stone_normal : hint_normal, filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D stone_roughness : filter_linear_mipmap_anisotropic, repeat_enable;
uniform vec4 soil_color : source_color = vec4(0.32,0.26,0.17,1.0);
uniform vec4 grass_color : source_color = vec4(0.392157,0.447059,0.286275,1.0);
varying vec3 world_pos;
float hash(vec2 p) { return fract(sin(dot(p,vec2(127.1,311.7)))*43758.5453); }
float noise2(vec2 p) {
	vec2 i=floor(p),f=fract(p); f=f*f*(3.0-2.0*f);
	return mix(mix(hash(i),hash(i+vec2(1,0)),f.x),mix(hash(i+vec2(0,1)),hash(i+vec2(1,1)),f.x),f.y);
}
void vertex() {
	world_pos=(MODEL_MATRIX*vec4(VERTEX,1.0)).xyz;
	TANGENT=vec3(1,0,0); BINORMAL=vec3(0,0,-1);
}
void fragment() {
	vec2 uv=world_pos.xz*vec2(0.5,-0.5);
	float macro=noise2(world_pos.xz*0.33);
	float fine=noise2(world_pos.xz*11.0);
	float edge=max(abs(world_pos.x),abs(world_pos.z));
	float broken_edge=edge+(macro-0.5)*2.4;
	float paving=1.0-smoothstep(10.5,14.3,broken_edge);
	float grass=smoothstep(12.5,15.5,broken_edge);
	// Match the backdrop's world-space grass variation at the shared border.
	grass=max(grass,smoothstep(14.0,15.8,edge));
	float grass_macro=noise2(world_pos.xz*0.10)*0.65+noise2(world_pos.xz*0.39)*0.35;
	vec3 turf=grass_color.rgb*mix(0.76,1.14,grass_macro)*(0.97+noise2(world_pos.xz*1.7)*0.06);
	vec3 earth=mix(soil_color.rgb*(0.83+macro*0.25+fine*0.12),turf,grass);
	vec3 stone=texture(stone_color,uv).rgb*(0.91+macro*0.12);
	ALBEDO=mix(earth,stone,paving);
	NORMAL_MAP=mix(vec3(0.5,0.5,1.0),texture(stone_normal,uv).rgb,paving);
	NORMAL_MAP_DEPTH=0.35;
	ROUGHNESS=mix(0.98,texture(stone_roughness,uv).r,paving);
}
