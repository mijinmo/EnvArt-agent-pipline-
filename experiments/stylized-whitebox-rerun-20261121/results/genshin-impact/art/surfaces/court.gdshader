shader_type spatial;

// Finish the original floor in world metres, including the flush sill.
uniform sampler2D flagstones : source_color, repeat_enable, filter_linear_mipmap_anisotropic;
uniform sampler2D sill_stone : source_color, repeat_enable, filter_linear_mipmap_anisotropic;
uniform vec4 apron : source_color = vec4(0.65, 0.65, 0.63, 1.0);
varying vec3 world_position;

void vertex() {
    world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
    vec2 p = world_position.xz;
    vec3 color = apron.rgb;
    if (p.x > -8.4 && p.x < 10.0 && p.y > -11.7 && p.y < 2.7 && world_position.y > -0.001) {
        color = texture(flagstones, p * 0.33).rgb;
        if (abs(p.x) < 0.60 && abs(p.y + 4.0) < 0.31) {
            color = texture(sill_stone, p * 0.8).rgb * 1.08;
        }
    }
    ALBEDO = color;
    ROUGHNESS = 0.92;
    SPECULAR = 0.18;
}
