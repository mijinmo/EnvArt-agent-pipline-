shader_type spatial;
render_mode specular_disabled;
uniform sampler2D sand_print : source_color, repeat_enable, filter_linear_mipmap_anisotropic;
varying vec3 yard_position;
varying vec3 yard_normal;

bool within_inlay(vec2 p, vec2 center, vec2 half_size) {
    return all(lessThan(abs(p-center),half_size));
}

void vertex() {
    yard_position = (MODEL_MATRIX * vec4(VERTEX,1.0)).xyz;
    yard_normal = MODEL_NORMAL_MATRIX * NORMAL;
}
void fragment() {
    vec2 p = yard_position.xz;
    // The paving has a recessed mortar bed and its highest points meet y = 0.
    // Keep the original floor body and its side walls all the way to the boundary.
    if (yard_normal.y > .9 && (
        within_inlay(p,vec2(0.,-2.94),vec2(.784,.709)) ||
        within_inlay(p,vec2(0.,-4.30),vec2(.639,.644)) ||
        within_inlay(p,vec2(0.,-5.47),vec2(.719,.509)) ||
        within_inlay(p,vec2(-1.26,-3.22),vec2(.279,.304)))) {
        discard;
    }
    vec2 uv = mat2(vec2(.974,.225),vec2(-.225,.974)) * p / 7.8;
    ALBEDO = texture(sand_print,uv).rgb;
    ROUGHNESS = .96;
    SPECULAR = 0.0;
}
void light() {
    float f = dot(NORMAL,LIGHT);
    float bands = .21*smoothstep(-.06,.03,f)+.48*smoothstep(.15,.24,f)+.21*smoothstep(.58,.69,f);
    DIFFUSE_LIGHT += LIGHT_COLOR * ATTENUATION * mix(max(0.,f),bands,.84)/PI;
}
