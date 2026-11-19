shader_type spatial;
render_mode diffuse_burley, specular_schlick_ggx;

// UV0 stores barycentrics and three crease flags. Colour stores sampled source paint.
uniform float line_width : hint_range(0.0, 2.5) = 0.82;
uniform float hatch_strength : hint_range(0.0, 1.0) = 0.26;
uniform vec4 ink : source_color = vec4(0.065, 0.077, 0.14, 1.0);
varying vec3 position_world;
varying vec3 normal_world;

void vertex() {
	position_world = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	normal_world = normalize(MODEL_NORMAL_MATRIX * NORMAL);
}

void fragment() {
	int mask = int(floor((UV.x + 0.15) / 2.0));
	float a = UV.x - float(2 * mask);
	vec3 bary = vec3(a, UV.y, 1.0 - a - UV.y);
	vec3 dist = bary / max(fwidth(bary), vec3(0.00001));
	for (int i = 0; i < 3; i++) {
		if ((mask & (1 << i)) == 0) {
			dist[i] = 1000.0;
		}
	}
	float crease = 1.0 - smoothstep(line_width * 0.45, line_width + 0.55, min(dist.x, min(dist.y, dist.z)));
	vec3 n = normalize(normal_world);
	vec2 p = abs(n.y) > 0.7 ? position_world.xz : vec2(abs(n.x) > abs(n.z) ? position_world.z : position_world.x, position_world.y);
	float pen = dot(p, vec2(1.0, 0.65)) * 35.0;
	float aa = max(fwidth(pen), 0.015);
	float hatch = (1.0 - smoothstep(0.055, 0.10 + aa * 0.4, abs(fract(pen) - 0.5))) * (1.0 - smoothstep(0.28, 0.75, aa));
	float slope = 1.0 - smoothstep(-0.65, 0.30, dot(n, normalize(vec3(-0.4, 0.8, 0.35))));
	vec3 paint = COLOR.rgb * (COLOR.rgb * (0.305306 * COLOR.rgb + 0.682171) + 0.012523);
	ALBEDO = mix(paint, ink.rgb, max(crease * 0.86, hatch * hatch_strength * (0.35 + slope * 0.65)));
	ROUGHNESS = 0.67;
	SPECULAR = 0.25;
}
