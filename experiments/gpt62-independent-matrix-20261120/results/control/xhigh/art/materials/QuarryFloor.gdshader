shader_type spatial;
uniform sampler2D chips : source_color, filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D arm_map : filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D normals : hint_normal, filter_linear_mipmap_anisotropic, repeat_enable;
varying vec3 world_pos;
void vertex() {
    world_pos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}
void fragment() {
    vec2 uv = world_pos.xz * 0.5;
    vec2 cell = (world_pos.xz + vec2(0.14,0.2)) / 0.64;
    vec2 to_edge = (0.5 - abs(fract(cell) - 0.5)) * 0.64;
    float dist = min(to_edge.x, to_edge.y);
    float joint = smoothstep(0.001, 0.0025 + fwidth(dist), dist);
    float variation = fract(sin(dot(floor(cell),vec2(72.317,54.81))) * 4313.7);
    vec3 photo = texture(chips, uv).rgb;
    float levels = dot(photo,vec3(0.23,0.64,0.13));
    vec3 stone = (0.035 + 0.51 * levels) * vec3(0.72,0.98,0.96);
    ALBEDO = stone * mix(0.73,1.0,joint) * mix(0.92,1.06,variation);
    ROUGHNESS = mix(0.74,0.40 + 0.38 * texture(arm_map,uv).g,joint);
    NORMAL_MAP = texture(normals,uv).rgb;
    NORMAL_MAP_DEPTH = 0.16;
}
