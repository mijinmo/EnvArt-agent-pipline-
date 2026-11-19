shader_type spatial;
uniform sampler2D scan : source_color, filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D rough_scan : filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D normal_scan : hint_normal, filter_linear_mipmap_anisotropic, repeat_enable;
varying vec3 world;
void vertex(){
	world=(MODEL_MATRIX*vec4(VERTEX,1.0)).xyz;
}
void fragment(){
	vec2 uv=world.xz*0.53;
	float grain=dot(texture(scan,uv).rgb,vec3(0.25,0.55,0.20));
	ALBEDO=vec3(0.041,0.047,0.053)+vec3(0.48,0.52,0.54)*grain;
	ROUGHNESS=0.30+texture(rough_scan,uv).r*0.30;
	SPECULAR=0.32;
	vec2 bump=texture(normal_scan,uv).xy*2.0-1.0;
	NORMAL=normalize(mat3(VIEW_MATRIX)*vec3(0.16*bump.x,1.0,0.16*bump.y));
}
