shader_type spatial;
render_mode cull_disabled, diffuse_burley, specular_schlick_ggx;
uniform vec2 panel_metres = vec2(1.0,1.0);
uniform vec4 tint : source_color = vec4(0.37,0.48,0.43,1.0);
void fragment() {
    vec2 p=UV*panel_metres;
    vec2 wire=vec2(p.x+p.y*0.72,p.x-p.y*0.72)*20.0;
    vec2 gap=min(fract(wire),1.0-fract(wire));
    vec2 spread=max(fwidth(wire),vec2(0.003));
    vec2 safe=smoothstep(vec2(0.0),spread*0.85,gap);
    float mesh=(1.0-min(safe.x,safe.y))*clamp(0.06/max(max(spread.x,spread.y),0.06),0.0,1.0);
    float rib=sin(p.x*332.0)*0.5+0.5;
    ALBEDO = mix(tint.rgb*(0.90+0.10*rib), vec3(0.055,0.073,0.06), mesh*0.60);
    METALLIC=0.12;
    ROUGHNESS=0.25+0.1*rib;
    SPECULAR=0.57;
    ALPHA=0.76+mesh*0.16;
}
