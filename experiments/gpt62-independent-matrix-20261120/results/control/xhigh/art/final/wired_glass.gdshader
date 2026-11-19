shader_type spatial;
render_mode cull_disabled;
void fragment() {
    vec2 p = UV * vec2(46.0, 19.0);
    vec2 wires = abs(fract(vec2(p.x + p.y, p.x - p.y)) - 0.5);
    float wire = 1.0 - smoothstep(0.012,0.028 + fwidth(p.x)*0.36,min(wires.x,wires.y));
    ALBEDO = mix(vec3(0.17,0.26,0.24),vec3(0.075,0.10,0.094),wire);
    ROUGHNESS = 0.23;
    METALLIC = 0.22;
    ALPHA = 0.12 + wire * 0.42;
}
