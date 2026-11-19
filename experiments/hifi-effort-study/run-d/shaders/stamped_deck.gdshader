shader_type spatial;
render_mode specular_disabled;
uniform sampler2D kit_trim : source_color, repeat_enable, filter_linear_mipmap_anisotropic;
uniform vec4 sheet : source_color = vec4(0.42,0.56,0.65,1);
uniform vec4 ink : source_color = vec4(0.083,0.096,0.18,1);
uniform vec4 route : source_color = vec4(0.98,0.39,0.35,1);
uniform float print_strength : hint_range(0,1) = 0.76;
varying vec3 w;
void vertex(){ w = (MODEL_MATRIX * vec4(VERTEX,1.0)).xyz; }
float line(float x,float width){return 1.0-smoothstep(width,width+max(fwidth(x),0.001),abs(x));}
float slot(vec2 p){return length(vec2(max(abs(p.x)-0.071,0.),p.y)) - 0.020;}
void fragment(){
    vec2 p=w.xz;
    vec2 panel=mod(p+vec2(0.95,0.35),vec2(2.0,1.20))-vec2(1.,0.6);
    float trim=dot(texture(kit_trim,UV).rgb,vec3(.21,.72,.07));
    vec3 c=sheet.rgb * mix(0.87,1.0,smoothstep(.09,.19,trim));
    c *= 0.94+0.06*mod(floor((p.x+0.95)/2.)+floor((p.y+0.35)/1.2),2.);
    float channel=line(abs(panel.x)-.985,.006)+line(abs(panel.y)-.584,.006);
    c=mix(c,ink.rgb,min(channel,1.)*0.78);
    c=mix(c,vec3(.53,.66,.68),line(abs(panel.y)-.563,.004)*.54);
    // Pressed drain slots only in alternating service strips. The inspection lane is clear.
    float strip=1.-smoothstep(.27,.32,abs(panel.y+.20));
    float row=floor((panel.y+.22)/.14);
    vec2 cell=vec2(mod(panel.x+row*.15,.32)-.16,mod(panel.y+.22,.14)-.07);
    float d=slot(cell);
    float aa=clamp(fwidth(d),.001,.019);
    float drive=1.-smoothstep(.53,.56,abs(p.x));
    float face=1.-smoothstep(-aa,aa,d);
    float bevel=1.-smoothstep(0.,aa,slot(cell-vec2(.003,.009))-.003);
    float mask=strip*(1.-drive)*smoothstep(.04,.10,1.-abs(panel.x));
    c=mix(c,vec3(.46,.60,.65),bevel*mask*.9);
    c=mix(c,ink.rgb,face*mask*print_strength);
    float stripe=line(abs(p.x)-.60,.026);
    c=mix(c,route.rgb,stripe);
    ALBEDO=c; ROUGHNESS=1.; SPECULAR=0.; EMISSION=c*.24;
}
void light(){
    float incidence=dot(NORMAL,LIGHT)*ATTENUATION;
    float key=.22*smoothstep(.035,.061,incidence)+.31*smoothstep(.16,.19,incidence);
    DIFFUSE_LIGHT=max(DIFFUSE_LIGHT,LIGHT_COLOR*key/PI);
}
