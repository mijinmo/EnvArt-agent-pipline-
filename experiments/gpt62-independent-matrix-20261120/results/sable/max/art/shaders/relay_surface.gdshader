shader_type spatial;
render_mode cull_disabled, specular_disabled;

uniform vec4 pigment : source_color = vec4(1.0);
uniform sampler2D surface_map : source_color, filter_linear_mipmap_anisotropic, repeat_enable, hint_default_white;
uniform int mapping : hint_enum("Swatch","Asset UV","World courses","Sand") = 0;
uniform float meters_per_tile : hint_range(0.2,24.0,0.05) = 3.0;
uniform float band_mix : hint_range(0.0,1.0) = 0.8;
uniform float tooth : hint_range(0.0,0.16) = 0.0;
uniform float sheen : hint_range(0.0,0.7) = 0.0;
varying vec3 world_p;
varying vec3 world_n;

float hash_cell(vec2 p) {
    return fract(sin(dot(p, vec2(39.83, 57.17))) * 14375.315);
}
void vertex() {
    world_p = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
    world_n = normalize(MODEL_NORMAL_MATRIX * NORMAL);
}
void fragment() {
    vec3 weights = abs(world_n);
    vec2 plane = weights.y > max(weights.x,weights.z) ? world_p.xz :
            (weights.x > weights.z ? vec2(world_p.z,-world_p.y) : vec2(world_p.x,-world_p.y));
    vec2 map_uv = UV;
    if (mapping == 2) { map_uv = plane / meters_per_tile; }
    if (mapping == 3) { map_uv = mat2(vec2(.974,.225),vec2(-.225,.974)) * world_p.xz / meters_per_tile; }
    vec3 paint = pigment.rgb;
    if (mapping != 0) { paint *= texture(surface_map,map_uv).rgb; }
    vec2 cell = plane * 99.0;
    float grain = hash_cell(floor(cell));
    float printed = smoothstep(.963,.985,grain) * (1.0-smoothstep(.22,.5,length(fract(cell)-.5)));
    float fade = 1.0 - smoothstep(.22,.85,max(fwidth(cell.x),fwidth(cell.y)));
    ALBEDO = paint * (1.0-tooth*printed*fade);
    ROUGHNESS = 0.94 - sheen * 0.65;
    SPECULAR = 0.0;
}
void light() {
    float facing = dot(NORMAL,LIGHT);
    float graphic = .21*smoothstep(-.06,.03,facing) + .48*smoothstep(.15,.24,facing) + .21*smoothstep(.58,.69,facing);
    DIFFUSE_LIGHT += (LIGHT_COLOR/PI) * ATTENUATION * mix(max(facing,0.0),graphic,band_mix);
    float rim = dot(NORMAL,normalize(LIGHT+VIEW));
    SPECULAR_LIGHT += (LIGHT_COLOR/PI) * ATTENUATION * sheen * .26 * smoothstep(.945,.965,rim);
}
