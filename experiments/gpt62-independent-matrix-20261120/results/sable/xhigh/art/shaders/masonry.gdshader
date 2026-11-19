shader_type spatial;
render_mode diffuse_lambert, specular_disabled;
uniform sampler2D stone : source_color, repeat_enable, filter_linear_mipmap_anisotropic;
uniform float meters_per_tile = 3.0;
uniform vec4 tint : source_color = vec4(1.0);
varying vec3 world;
varying vec3 facing;
void vertex() {
    world = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
    facing = MODEL_NORMAL_MATRIX * NORMAL;
}
void fragment() {
    vec3 n = abs(normalize(facing));
    vec2 chart = n.y > 0.65 ? world.xz : vec2(n.x > n.z ? world.z : world.x, -world.y);
    ALBEDO = texture(stone, chart / meters_per_tile).rgb * tint.rgb;
    ROUGHNESS = 1.0;
}
