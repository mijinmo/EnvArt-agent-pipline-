shader_type spatial;
render_mode unshaded, cull_disabled, shadows_disabled, fog_disabled, depth_draw_never, depth_test_disabled;

uniform sampler2D scene_colour : hint_screen_texture, repeat_disable, filter_nearest;
uniform sampler2D depth_map : hint_depth_texture, repeat_disable, filter_nearest;
uniform sampler2D surface_map : hint_normal_roughness_texture, repeat_disable, filter_nearest;
uniform vec4 ink_colour : source_color = vec4(0.22, 0.16, 0.22, 1.0);
uniform float strength : hint_range(0.0, 1.0) = 0.70;

void vertex() {
    POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}
float view_depth(vec2 uv, mat4 inverse_projection) {
    vec4 point = inverse_projection * vec4(uv * 2.0 - 1.0, textureLod(depth_map, uv, 0.0).r, 1.0);
    return -point.z / point.w;
}
void fragment() {
    vec2 px = 1.0 / VIEWPORT_SIZE;
    float z = view_depth(SCREEN_UV, INV_PROJECTION_MATRIX);
    vec3 n = texture(surface_map, SCREEN_UV).rgb * 2.0 - 1.0;
    float line = 0.0;
    for (int i = 0; i < 4; i++) {
        vec2 dir = i == 0 ? vec2(1.,0.) : (i == 1 ? vec2(0.,1.) : (i == 2 ? vec2(-1.,0.) : vec2(0.,-1.)));
        vec2 uv = SCREEN_UV + px * dir;
        float dz = view_depth(uv, INV_PROJECTION_MATRIX) - z;
        vec3 other = texture(surface_map, uv).rgb * 2.0 - 1.0;
        line = max(line, smoothstep(0.009, 0.025, dz / max(z, 0.1)));
        float crease = dot(n - other, normalize(vec3(.55,.65,.28)));
        line = max(line, smoothstep(.22, .55, crease) * .83);
    }
    vec3 base = textureLod(scene_colour, SCREEN_UV, 0.0).rgb;
    ALBEDO = mix(base, min(base * .65, ink_colour.rgb), strength * line);
}
