shader_type spatial;
render_mode cull_disabled, specular_schlick_ggx;
uniform vec4 deep_water : source_color = vec4(0.105, 0.205, 0.235, 1.0);
uniform vec4 gold_water : source_color = vec4(0.68, 0.45, 0.22, 1.0);
varying vec3 world;
float h(vec2 p) {return fract(sin(dot(p,vec2(37.13,113.91)))*28631.159);}
float noise2(vec2 p){
 vec2 i=floor(p),f=fract(p);f=f*f*(3.0-2.0*f);
 return mix(mix(h(i),h(i+vec2(1,0)),f.x),mix(h(i+vec2(0,1)),h(i+vec2(1,1)),f.x),f.y);
}
void vertex(){world=(MODEL_MATRIX*vec4(VERTEX,1.0)).xyz;}
void fragment(){
 vec2 p=world.xz;
 float eddy=noise2(p*.76)+.3*noise2(p*2.3);
 vec2 wind=vec2(p.x*.84,p.y*11.0+eddy*1.7);
 float ripple=noise2(wind)*.74+noise2(wind*2.6)*.26;
 float light_path=exp(-pow((p.x+3.1+1.7*sin(p.y*.83)+2.0*eddy)/3.0,2.0));
 float pool=clamp(.12+.37*noise2(p*.31)+light_path*(.15+ripple*.75)+.14*(ripple-.5),0.0,1.0);
 float streak=smoothstep(.57,.77,ripple)*smoothstep(.38,.74,light_path);
 ALBEDO=mix(deep_water.rgb,gold_water.rgb,pow(pool,2.4))*(.66+.46*eddy)+vec3(.28,.156,.054)*streak;
 ROUGHNESS=.32+.15*eddy;
 METALLIC=.16;
 SPECULAR=.22;
 vec3 slope=vec3((noise2(wind+.25)-ripple)*.19,1.0,(noise2(wind+vec2(0,.35))-ripple)*.28);
 EMISSION=deep_water.rgb*(.40+.72*ripple)+gold_water.rgb*streak*.09;
 NORMAL=normalize(mat3(VIEW_MATRIX)*slope);
}