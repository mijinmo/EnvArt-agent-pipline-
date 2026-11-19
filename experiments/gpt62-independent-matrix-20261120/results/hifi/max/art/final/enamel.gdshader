shader_type spatial;
render_mode specular_schlick_ggx;

// The downloaded module palette and the additional pressings share the same
// ink response. Only adapted modules carry the UV crease mask.
uniform bool module_colours = true;
uniform vec4 base_paint : source_color = vec4(0.29, 0.37, 0.45, 1.0);
uniform vec4 ink_colour : source_color = vec4(0.075, 0.078, 0.15, 1.0);
uniform float line_width = 0.86;
uniform float ink_density : hint_range(0, 1) = 0.72;
uniform float pipe_paint : hint_range(0, 1) = 0.0;
varying vec3 world_pos;
varying vec3 world_normal;

void vertex() {
	world_pos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	world_normal = normalize(MODEL_NORMAL_MATRIX * NORMAL);
}

float crease_at(vec2 uv) {
	int mask = int(floor((uv.x + 0.15) / 2.0));
	float u = uv.x - 2.0 * float(mask);
	vec3 bary = vec3(u, uv.y, 1.0 - u - uv.y);
	vec3 dist = bary / max(fwidth(bary), vec3(0.00001));
	for (int i = 0; i < 3; i++) {
		if ((mask & (1 << i)) == 0) { dist[i] = 1000.0; }
	}
	return 1.0 - smoothstep(line_width * 0.48, line_width + 0.55, min(dist.x, min(dist.y, dist.z)));
}

void fragment() {
	vec3 n = normalize(world_normal);
	vec2 p = abs(n.y) > 0.705 ? world_pos.xz : vec2(abs(n.x) > abs(n.z) ? world_pos.z : world_pos.x, world_pos.y);
	// World-space print fades away below pixel resolution.
	vec2 grid = vec2(dot(p, vec2(0.866, 0.5)), dot(p, vec2(-0.5, 0.866))) * 38.0;
	float footprint = max(fwidth(grid.x), fwidth(grid.y));
	float dots = (1.0 - smoothstep(0.15, 0.23 + footprint * 0.32, length(fract(grid) - 0.5))) * (1.0 - smoothstep(0.35, 0.79, footprint));
	float pen = dot(p, vec2(1.0, 0.67)) * 30.0;
	float aa = max(fwidth(pen), 0.01);
	float hatch = (1.0 - smoothstep(0.045, 0.09 + aa * 0.5, abs(fract(pen) - 0.5))) * (1.0 - smoothstep(0.26, 0.67, aa));
	float shade = 1.0 - smoothstep(-0.62, 0.44, dot(n, normalize(vec3(-0.36, 0.85, 0.26))));
	vec3 paint = base_paint.rgb;
	float edge = 0.0;
	if (module_colours) {
		vec3 c = COLOR.rgb;
		float enamel = smoothstep(0.035, 0.15, c.g - c.r);
		c = mix(c, clamp(vec3(0.26, 0.57, 0.55) + 0.81 * (c - vec3(0.19, 0.40, 0.43)), vec3(0.0), vec3(1.0)), enamel * pipe_paint);
		paint = c * (c * (0.305306 * c + 0.682171) + 0.012523);
		edge = crease_at(UV);
	}
	float print_ink = ink_density * (dots * (0.09 + 0.24 * shade) + hatch * (0.08 + 0.24 * shade));
	ALBEDO = mix(paint, ink_colour.rgb, max(0.90 * edge, print_ink));
	ROUGHNESS = 0.68;
	SPECULAR = 0.23;
}

void light() {
	float value = max(dot(NORMAL, LIGHT), 0.0);
	float steps = 0.14 * smoothstep(0.01, 0.13, value) + 0.39 * smoothstep(0.28, 0.42, value) + 0.43 * smoothstep(0.66, 0.81, value);
	DIFFUSE_LIGHT += LIGHT_COLOR * ATTENUATION * mix(value, steps, 0.45) / PI;
	float glint = pow(max(0.0, dot(NORMAL, normalize(LIGHT + VIEW))), 42.0);
	SPECULAR_LIGHT += LIGHT_COLOR * ATTENUATION * glint * 0.027;
}
