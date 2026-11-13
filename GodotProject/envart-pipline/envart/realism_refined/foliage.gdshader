shader_type spatial;
render_mode cull_disabled;
uniform sampler2D leaf_color : source_color, filter_linear_mipmap_anisotropic;
uniform sampler2D leaf_alpha : filter_linear_mipmap_anisotropic;
uniform sampler2D leaf_normal : hint_normal, filter_linear_mipmap_anisotropic;
uniform sampler2D leaf_arm : filter_linear_mipmap_anisotropic;
uniform vec4 tint : source_color = vec4(0.88,0.91,0.85,1.0);
void fragment(){
	ALBEDO=texture(leaf_color,UV).rgb*tint.rgb;
	ALPHA=texture(leaf_alpha,UV).r;
	ALPHA_SCISSOR_THRESHOLD=0.45;
	NORMAL_MAP=texture(leaf_normal,UV).rgb;
	NORMAL_MAP_DEPTH=0.65;
	vec3 arm=texture(leaf_arm,UV).rgb;
	AO=arm.r;ROUGHNESS=max(0.65,arm.g);SPECULAR=0.2;
}
