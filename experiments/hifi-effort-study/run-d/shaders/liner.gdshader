shader_type spatial;
render_mode specular_disabled;
uniform vec4 enamel : source_color = vec4(.23,.53,.54,1.);
uniform vec4 ink : source_color=vec4(.095,.11,.21,1.);
uniform vec4 service_stripe : source_color=vec4(.95,.19,.48,1.);
uniform float tram : hint_range(0.0,1.0)=.84;
varying vec3 pos;
varying vec3 wn;
void vertex(){pos=(MODEL_MATRIX*vec4(VERTEX,1.)).xyz;wn=MODEL_NORMAL_MATRIX*NORMAL;}
void fragment(){
    vec3 n=normalize(wn); float across = abs(n.x)>.65 ? -pos.z : pos.x;
    float panel=fract((across+.13)*.60);
    vec3 base=enamel.rgb*mix(.80,1.04,step(.42,fract(floor((across+.13)*.60)*.619)));
    base=mix(base,ink.rgb,.74*(1.-smoothstep(.65,.68,pos.y)));
    float band=1.-smoothstep(.082,.092,abs(pos.y-1.85));
    float hashzone=step(.74,fract(across/5.0))*step(1.85,pos.y)*step(pos.y,2.68);
    float h=step(.54,fract(across*.84-pos.y*2.87));
    base=mix(base,service_stripe.rgb,tram*max(band,hashzone*h));
    base=mix(base,ink.rgb,(1.-smoothstep(.002,.009,min(panel,1.-panel)))*.64);
    float dark=1.-smoothstep(.0,.13,panel);
    float phase=dot(vec2(across,pos.y),vec2(36.,-28.));
    float hatch=(1.-smoothstep(.035,.12+fwidth(phase),abs(fract(phase)-.5)))*(1.-smoothstep(.3,.9,fwidth(phase)));
    base*=1.-.33*dark*hatch;
    ALBEDO=base;ROUGHNESS=1.;SPECULAR=0.;EMISSION=base*.28;
}
void light(){
    float intensity=max(dot(NORMAL,LIGHT),0.)*ATTENUATION;
    float cut=.20*smoothstep(.025,.04,intensity)+.34*smoothstep(.18,.22,intensity);
    DIFFUSE_LIGHT=max(DIFFUSE_LIGHT,LIGHT_COLOR*cut/PI);
}
