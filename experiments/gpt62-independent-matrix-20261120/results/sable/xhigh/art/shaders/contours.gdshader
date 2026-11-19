shader_type spatial;
render_mode unshaded, fog_disabled, depth_draw_never, depth_test_disabled, cull_disabled, shadows_disabled;
uniform sampler2D distance_buffer : hint_depth_texture, repeat_disable, filter_nearest;
uniform sampler2D surfaces : hint_normal_roughness_texture, repeat_disable, filter_nearest;
uniform vec4 ink : source_color = vec4(0.18,0.15,0.22,1.);
uniform float weight : hint_range(0.0,1.0) = 0.70;
void vertex() {
    POSITION = vec4(VERTEX.xy, 1., 1.);
}
void fragment() {
    vec2 pixel = 1.0 / VIEWPORT_SIZE;
    float depth = texture(distance_buffer, SCREEN_UV).r;
    vec3 normal = texture(surfaces, SCREEN_UV).xyz * 2. - 1.;
    float border = 0.;
    float fold = 0.;
    for (int axis = 0; axis < 4; axis++) {
        vec2 step_uv = axis == 0 ? vec2(1.,0.) : axis == 1 ? vec2(-1.,0.) : axis == 2 ? vec2(0.,1.) : vec2(0.,-1.);
        vec2 uv = SCREEN_UV + pixel * step_uv;
        float other = texture(distance_buffer, uv).r;
        border = max(border,(depth - other) / max(depth,.0001));
        vec3 next_normal = texture(surfaces, uv).xyz * 2. - 1.;
        if (axis == 0 || axis == 2) {
            fold = max(fold, 1. - dot(normal, next_normal));
        }
    }
    ALBEDO = ink.rgb;
    ALPHA = weight * max(smoothstep(.009,.023,border), .75 * smoothstep(.10,.50,fold)) * step(.0001, depth);
}
