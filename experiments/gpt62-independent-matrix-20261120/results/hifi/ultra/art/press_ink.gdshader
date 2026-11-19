shader_type spatial;
render_mode unshaded, cull_disabled, depth_draw_never, depth_test_disabled, fog_disabled, shadows_disabled;
uniform sampler2D page : hint_screen_texture, repeat_disable, filter_nearest;
uniform sampler2D z_buffer : hint_depth_texture, repeat_disable, filter_nearest;
uniform sampler2D normals : hint_normal_roughness_texture, repeat_disable, filter_nearest;
uniform float line_weight : hint_range(0.0,1.0) = 0.72;
uniform float print_strength : hint_range(0.0,1.0) = 0.16;

void vertex() {
    POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}

float distance_at(vec2 uv, mat4 inv_proj) {
    float z = texture(z_buffer, uv).r;
    vec4 v = inv_proj * vec4(uv * 2.0 - 1.0, z, 1.0);
    return -v.z / v.w;
}

void fragment() {
    vec2 uv = SCREEN_UV;
    vec2 pixel = 1.0 / VIEWPORT_SIZE;
    vec3 color = texture(page, uv).rgb;
    float d = distance_at(uv, INV_PROJECTION_MATRIX);
    vec3 n = texture(normals, uv).rgb;
    float silhouette = 0.0;
    float crease = 0.0;
    for(int i = 0; i < 4; i++) {
        vec2 dir = i == 0 ? vec2(1.,0.) : i == 1 ? vec2(-1.,0.) : i == 2 ? vec2(0.,1.) : vec2(0.,-1.);
        vec2 nb = clamp(uv + dir * pixel * 1.45, vec2(0.001), vec2(.999));
        float delta = distance_at(nb, INV_PROJECTION_MATRIX) - d;
        silhouette = max(silhouette, smoothstep(.022, .053, delta / max(d, .1)));
        crease = max(crease, smoothstep(.31,.53,length(n - texture(normals,nb).rgb)));
    }
    float luma = dot(color, vec3(.24,.64,.12));
    vec2 paper = FRAGCOORD.xy;
    vec2 lattice = vec2(paper.x + paper.y*.35, paper.y - paper.x*.35) / 5.5;
    float dot_mask = 1.0 - smoothstep(.12,.32,length(fract(lattice)-.5));
    float hatch = smoothstep(.80,.99,cos((paper.x + paper.y*1.37)*.85));
    color *= 1.0 - print_strength * (dot_mask + .47*hatch) * (1.0-smoothstep(.07,.36,luma));
    vec3 ink = vec3(.008,.011,.026);
    ALBEDO = mix(color,min(color*.44,ink),max(silhouette,crease*.71)*line_weight);
}
