shader_type spatial;
render_mode specular_disabled;
uniform vec4 enamel : source_color = vec4(.17,.39,.41,1.);
uniform vec4 ink : source_color=vec4(.095,.11,.21,1.);
uniform vec4 service_stripe : source_color=vec4(.95,.19,.48,1.);
uniform float tram : hint_range(0.0,1.0)=.70;
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
    
    // As the surface enters the shadow of the cable tray, let the printed dot field resolve.
    float high=smoothstep(2.43,2.83,pos.y);
    float angle=dot(vec2(across,pos.y),vec2(22.,-29.));
    float fine=(1.-smoothstep(.03,.14+fwidth(angle),abs(fract(angle)-.5)))*(1.-smoothstep(.32,.8,fwidth(angle)));
    base*=1.-high*(.17+.26*fine);
    bool side=abs(n.x)>.65;
    float lamp=side?min(abs(pos.z+9.72),abs(pos.z+3.52)):abs(pos.x+1.08);
    float drop=2.84-pos.y;
    float aperture=.07+drop*.49;
    float inside=step(0.,drop)*step(drop,1.68);
    float beam=(1.-smoothstep(aperture*.72,aperture+0.08,lamp))*inside;
    vec2 uv=vec2(across+pos.y*.26,pos.y-across*.26)*48.;
    vec2 halftone=fract(uv)-.5;
    float dotink=1.-smoothstep(.09,.24+length(fwidth(uv))*.24,length(halftone));
    beam*=mix(.78,1.,dotink)*(1.-smoothstep(1.1,1.68,drop));
    vec3 pilot=vec3(.46,.090,.09);
    base=mix(base,pilot,beam*.67);
    ALBEDO=base;ROUGHNESS=1.;SPECULAR=0.;EMISSION=base*.20+pilot*beam*.15;
}
void light(){
    float intensity=max(dot(NORMAL,LIGHT),0.)*ATTENUATION;
    float cut=.20*smoothstep(.025,.04,intensity)+.34*smoothstep(.18,.22,intensity);
    DIFFUSE_LIGHT=max(DIFFUSE_LIGHT,LIGHT_COLOR*cut/PI);
}
