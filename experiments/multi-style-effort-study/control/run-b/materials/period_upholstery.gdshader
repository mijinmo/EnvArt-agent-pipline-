shader_type spatial;
uniform sampler2D fabric : source_color, filter_linear_mipmap_anisotropic;
uniform sampler2D arm : filter_linear_mipmap_anisotropic;
uniform sampler2D relief : hint_normal, filter_linear_mipmap_anisotropic;
void fragment(){
	vec3 c = texture(fabric,UV).rgb;
	vec3 p = texture(arm,UV).rgb;
	float luma=dot(c,vec3(0.26,0.58,0.16));
	float warm=smoothstep(0.012,0.09,c.r-c.b);
	ALBEDO=mix(c,vec3(0.019,0.024,0.041) + luma*vec3(0.18,0.21,0.28),warm*0.93);
	METALLIC=p.b;
	ROUGHNESS=clamp(0.13+0.77*p.g,0.20,0.90);
	AO=p.r;
	NORMAL_MAP=texture(relief,UV).rgb;
}
