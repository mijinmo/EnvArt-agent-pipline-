shader_type spatial;
render_mode unshaded, fog_disabled, shadows_disabled, cull_disabled, depth_draw_never, depth_test_disabled;

uniform sampler2D scene_color : hint_screen_texture, repeat_disable, filter_nearest;
uniform sampler2D scene_depth : hint_depth_texture, repeat_disable, filter_nearest;
uniform sampler2D normals : hint_normal_roughness_texture, repeat_disable, filter_nearest;
uniform float line_pixels : hint_range(0.5, 3.0) = 1.45;
uniform float crease_threshold : hint_range(0.05, 0.95) = 0.25;
uniform float band_strength : hint_range(0.0, 1.0) = 0.38;
uniform float ink_strength : hint_range(0.0, 1.0) = 0.77;
uniform float shadow_hatching : hint_range(0.0, 1.0) = 0.17;

void vertex() {
    POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}

void fragment() {
    vec2 uv = SCREEN_UV;
    vec2 px = line_pixels / VIEWPORT_SIZE;
    vec3 src = texture(scene_color, uv).rgb;
    float z = texture(scene_depth, uv).r;
    vec3 n = normalize(texture(normals,uv).xyz * 2.0 - 1.0);
    float edge = 0.0;
    for (int i=0; i<4; i++) {
        vec2 dir = i==0 ? vec2(1,0) : i==1 ? vec2(0,1) : i==2 ? vec2(-1,0) : vec2(0,-1);
        vec2 sample_uv = uv + px*dir;
        float dz = (z - texture(scene_depth,sample_uv).r) / max(z,0.0001);
        vec3 other_n = normalize(texture(normals,sample_uv).xyz * 2.0 - 1.0);
        float bend = 1.0-dot(n,other_n);
        edge = max(edge, max(smoothstep(0.009,0.035,dz), smoothstep(crease_threshold,crease_threshold+0.18,bend)));
    }
    float y = max(dot(src,vec3(0.2126,0.7152,0.0722)),0.001);
    float tone = sqrt(y);
    float cell = tone * 7.0;
    float band = (floor(cell)+smoothstep(0.40,0.64,fract(cell)))/7.0;
    vec3 col = src * mix(1.0,clamp(band*band/y,0.68,1.27),band_strength);
    float hatch = smoothstep(0.68,0.96,cos((FRAGCOORD.x+FRAGCOORD.y*1.7)*0.83));
    col *= 1.0-shadow_hatching*(1.0-smoothstep(0.15,0.39,tone))*hatch;
    ALBEDO = mix(col, vec3(0.012,0.014,0.032),edge*ink_strength);
}
