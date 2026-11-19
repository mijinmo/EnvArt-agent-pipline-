shader_type spatial;
render_mode diffuse_lambert, specular_disabled;
uniform sampler2D sand : source_color,repeat_enable,filter_linear_mipmap_anisotropic;
uniform sampler2D wheel_ruts : source_color,repeat_disable,filter_linear_mipmap_anisotropic;
varying vec3 yard;
void vertex() {
    yard = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}
void fragment() {
    vec2 uv = (yard.xz + vec2(2.0, 10.0)) / 12.0;
    vec4 tracks = texture(wheel_ruts, uv);
    vec3 ground = texture(sand, yard.xz/3.7).rgb;
    float inside = step(0.0, min(uv.x,uv.y)) * step(max(uv.x,uv.y),1.0);
    ALBEDO = mix(ground, tracks.rgb, tracks.a * inside);
    ROUGHNESS = 1.0;
}
