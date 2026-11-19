shader_type spatial;
render_mode specular_disabled;
varying vec3 w;
void vertex(){w=(MODEL_MATRIX*vec4(VERTEX,1.0)).xyz;}
void fragment(){
    vec2 p=w.xz;
    vec2 cell=fract((p+vec2(0.13,.8))/vec2(2.6,1.5));
    vec2 edge=min(cell,1.-cell);
    float joint=1.-smoothstep(.003,.008,min(edge.x,edge.y));
    float lip=(1.-smoothstep(.009,.017,edge.y))*(1.-joint);
    vec3 paint=mix(vec3(.063,.082,.137),vec3(.044,.051,.102),step(.46,fract(floor(p.x/2.6)*.19+floor(p.y/1.5)*.33)));
    float soffit=(1.-smoothstep(.08,.32,cell.y))*.49;
    float phase=dot(p,vec2(22.,-29.));
    float hatch=(1.-smoothstep(.03,.12+fwidth(phase),abs(fract(phase)-.5)))*(1.-smoothstep(.30,.85,fwidth(phase)));
    paint*=1.-soffit*(.27+.55*hatch);
    paint=mix(paint,vec3(.014,.015,.033),joint);
    ALBEDO=mix(paint,vec3(.10,.12,.19),lip*.56);
    ROUGHNESS=1.; SPECULAR=0.; EMISSION=ALBEDO*.32;
}
