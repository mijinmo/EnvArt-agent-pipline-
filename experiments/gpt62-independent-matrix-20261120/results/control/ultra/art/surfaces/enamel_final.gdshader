shader_type spatial;

uniform sampler2D finish_color : source_color, repeat_enable, filter_linear_mipmap_anisotropic;
uniform sampler2D finish_normal : hint_normal, repeat_enable, filter_linear_mipmap_anisotropic;
uniform sampler2D finish_roughness : repeat_enable, filter_linear_mipmap_anisotropic;
uniform float repeat_m = 1.8;
uniform float saturation : hint_range(0, 1) = 0.6;
uniform vec4 stain : source_color = vec4(1.0);
uniform float value_gain = 1.0;
uniform float relief : hint_range(0, 1) = 0.32;
uniform float polish : hint_range(0, 1) = 0.0;
varying vec3 world_point;
varying vec3 world_normal;

void vertex() {
    world_point = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
    world_normal = normalize(MODEL_NORMAL_MATRIX * NORMAL);
}
void fragment() {
    vec3 n = abs(world_normal);
    vec2 metric_uv;
    if (n.y > max(n.x, n.z)) {
        metric_uv = world_point.xz;
    } else if (n.x > n.z) {
        metric_uv = vec2(world_point.z * -sign(world_normal.x), -world_point.y);
    } else {
        metric_uv = vec2(world_point.x * sign(world_normal.z), -world_point.y);
    }
    vec2 uv = metric_uv / repeat_m;
    vec3 base = texture(finish_color, uv).rgb;
    float wear = dot(base, vec3(0.2126, 0.7152, 0.0722));
    ALBEDO = stain.rgb * (0.53 + 2.8 * wear) + vec3(0.12, 0.095, 0.064) * smoothstep(0.19, 0.44, wear);
    METALLIC = 0.17 + 0.22 * smoothstep(0.2, 0.48, wear);
    ROUGHNESS = 0.32 + 0.42 * texture(finish_roughness, uv).r;

    // Construct the tangent frame from the same metric projection as the colour.
    vec3 q1 = dFdx(VERTEX);
    vec3 q2 = dFdy(VERTEX);
    vec2 t1 = dFdx(uv);
    vec2 t2 = dFdy(uv);
    vec3 a = cross(q2, NORMAL);
    vec3 b = cross(NORMAL, q1);
    vec3 tu = a * t1.x + b * t2.x;
    vec3 tv = a * t1.y + b * t2.y;
    float mag = inversesqrt(max(max(dot(tu, tu), dot(tv, tv)), 0.00000000001));
    vec2 slope = (texture(finish_normal, uv).rg * 2.0 - 1.0) * relief;
    NORMAL = normalize(NORMAL + mag * (tu * slope.x - tv * slope.y));
}
