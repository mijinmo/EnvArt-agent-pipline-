shader_type spatial;
render_mode diffuse_lambert, specular_disabled;
uniform sampler2D stone : source_color,repeat_enable,filter_linear_mipmap_anisotropic;
uniform sampler2D print_layer : source_color,repeat_disable,filter_linear_mipmap_anisotropic;
varying vec3 wall;
varying vec3 facing;
void vertex() {
    wall = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
    facing = MODEL_NORMAL_MATRIX * NORMAL;
}
void fragment() {
    vec3 n = abs(normalize(facing));
    vec2 chart = n.y > .65 ? wall.xz : vec2(n.x > n.z ? wall.z : wall.x, -wall.y);
    vec3 blocks = texture(stone, chart/3.2).rgb;
    vec2 uv = vec2((9.52-wall.x)/3.18,(2.76-wall.y)/1.79);
    vec4 motif = texture(print_layer,uv);
    float mask = step(0.0,min(uv.x,uv.y))*step(max(uv.x,uv.y),1.0)*step(facing.z,-.9);
    ALBEDO = mix(blocks, motif.rgb * (.60 + blocks*.55), mask*motif.a*.86);
    ROUGHNESS = 1.;
}
