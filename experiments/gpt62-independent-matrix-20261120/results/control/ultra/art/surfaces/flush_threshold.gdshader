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
    // Flush stainless saddle and engraved anti-slip channels on the structural floor.
    if (abs(coord.x) <= 0.60001 && abs(coord.y + 4.0) <= 0.30001) {
        float z = abs(coord.y + 4.0);
        float groove = min(abs(z - 0.23), abs(z - 0.19));
        float coverage = 1.0 - smoothstep(0.002, 0.006 + fwidth(z), groove);
        ALBEDO = mix(vec3(0.19, 0.235, 0.215), vec3(0.045, 0.065, 0.059), coverage);
        METALLIC = 0.58;
        ROUGHNESS = 0.43 + 0.12 * coverage;
    }
}
