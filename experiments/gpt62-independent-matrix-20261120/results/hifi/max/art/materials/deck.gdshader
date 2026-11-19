shader_type spatial;
render_mode diffuse_burley, specular_schlick_ggx;
uniform sampler2D plate_print : source_color, filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D tread : source_color, filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D relief : hint_normal, filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D microrough : filter_linear_mipmap_anisotropic, repeat_enable;
varying vec3 world_point;

void vertex() {
	world_point = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
	vec2 p = world_point.xz;
	vec3 plate = texture(plate_print, p / 4.8).rgb;
	float threshold = step(0.84, abs(p.x)) * (1.0 - step(1.40, abs(p.x))) * step(-8.6, p.y) * (1.0 - step(1.6, p.y));
	float bench = step(8.05, p.x) * (1.0 - step(9.78, p.x)) * step(-7.25, p.y) * (1.0 - step(-1.28, p.y));
	float grip = max(threshold, bench);
	vec3 raised = texture(tread, p * 1.29).rgb;
	float join = min(plate.g * 7.3, 1.0);
	ALBEDO = mix(plate, raised * mix(0.53, 1.0, join), grip * 0.82);
	// Flush drain in the transfer portal. Its surface stays at whitebox floor height.
	float sill = (1.0 - step(0.59, abs(p.x))) * (1.0 - step(0.145, abs(p.y + 4.0)));
	float slot = step(0.33, fract((p.x + 0.002) * 12.0)) * (1.0 - step(0.73, fract((p.x + 0.002) * 12.0))) * (1.0 - step(0.09, abs(p.y + 4.0)));
	ALBEDO = mix(ALBEDO, mix(vec3(0.24, 0.29, 0.30), vec3(0.033, 0.054, 0.08), slot), sill);
	float local_floor = step(-7.5, p.x) * step(p.x, 11.4) * step(-12.1, p.y) * step(p.y, 4.55);
	ALBEDO = mix(vec3(0.061, 0.078, 0.107), ALBEDO, local_floor);
	NORMAL_MAP = texture(relief, p * 1.29).rgb;
	NORMAL_MAP_DEPTH = grip * 0.26;
	ROUGHNESS = mix(0.79, clamp(texture(microrough, p * 1.29).r, 0.48, 0.90), grip);
	SPECULAR = 0.24;
}
