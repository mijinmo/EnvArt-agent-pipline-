shader_type spatial;
render_mode unshaded, cull_disabled, fog_disabled, depth_draw_never, depth_test_disabled, shadows_disabled;
uniform sampler2D frame : hint_screen_texture, repeat_disable, filter_nearest;
uniform sampler2D depth_buffer : hint_depth_texture, repeat_disable, filter_nearest;
uniform sampler2D geometry : hint_normal_roughness_texture, repeat_disable, filter_nearest;
uniform float ink_density : hint_range(0.0, 1.0) = 0.78;
uniform float bend_threshold : hint_range(0.0, 1.0) = 0.25;
uniform float screen_tint : hint_range(0.0, 0.5) = 0.13;
void vertex() {
    POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}
float view_depth(vec2 uv, mat4 inv_p) {
    float d = texture(depth_buffer, uv).r;
    vec4 p = inv_p * vec4(uv * 2.0 - 1.0, d, 1.0);
    return -p.z / p.w;
}
void fragment() {
    vec2 uv = SCREEN_UV;
    vec2 step_uv = 1.0 / VIEWPORT_SIZE;
    vec3 base = texture(frame, uv).rgb;
    float z = view_depth(uv, INV_PROJECTION_MATRIX);
    vec3 n = normalize(texture(geometry, uv).xyz * 2.0 - 1.0);
    float crease = 0.0;
    float gap = 0.0;
    for (int i = 0; i < 4; i++) {
        vec2 offset = i == 0 ? vec2(1.,0.) : (i == 1 ? vec2(-1.,0.) : (i == 2 ? vec2(0.,1.) : vec2(0.,-1.)));
        vec2 pos = uv + offset * step_uv * 1.28;
        float zd = view_depth(pos, INV_PROJECTION_MATRIX) - z;
        vec3 other = normalize(texture(geometry, pos).xyz * 2.0 - 1.0);
        gap = max(gap, zd / max(0.4,z));
        crease = max(crease, (1.0 - dot(n,other)) * step(-.006, zd));
    }
    float edge = max(smoothstep(.012,.031,gap), smoothstep(bend_threshold,bend_threshold + .22,crease));
    float value = dot(base,vec3(.24,.65,.11));
    vec2 paper = mat2(vec2(.94,.342),vec2(-.342,.94)) * FRAGCOORD.xy / 4.2;
    float dot_ink = (1.0 - smoothstep(.14,.34,length(fract(paper) - .5))) * (1.0 - smoothstep(.09,.35,value));
    base *= 1.0 - screen_tint * dot_ink;
    ALBEDO = mix(base, min(base, vec3(.006,.009,.023)), ink_density * edge);
}
