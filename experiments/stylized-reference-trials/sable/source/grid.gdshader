shader_type spatial;
render_mode diffuse_burley;

uniform vec4 base_color : source_color = vec4(0.14, 0.19, 0.24, 1.0);
uniform vec4 line_color : source_color = vec4(0.30, 0.39, 0.46, 1.0);
varying vec3 world_position;

void vertex() {
	world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
	vec2 coord = world_position.xz;
	vec2 edge = abs(fract(coord - 0.5) - 0.5);
	vec2 antialias = max(fwidth(coord), vec2(0.001));
	float grid = 1.0 - min(min(edge.x / antialias.x, edge.y / antialias.y), 1.0);
	ALBEDO = mix(base_color.rgb, line_color.rgb, grid * 0.8);
	ROUGHNESS = 0.85;
}
