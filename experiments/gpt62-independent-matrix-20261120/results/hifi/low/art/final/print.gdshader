shader_type spatial;
uniform sampler2D palette : source_color, filter_nearest;
uniform bool enclosure=false;
varying vec3 wp;
varying vec3 wn;
void vertex(){wp=(MODEL_MATRIX*vec4(VERTEX,1.)).xyz;wn=normalize(MODEL_NORMAL_MATRIX*NORMAL);}
void fragment(){
 vec3 c=texture(palette,UV).rgb;
 float value=dot(c,vec3(.3,.54,.16));
 if(enclosure){
 c=mix(vec3(.022,.032,.064),vec3(.22,.32,.39),value);
 }else{c=mix(c,c*vec3(.85,1.02,1.16),.7);}
 vec2 paper=vec2(wp.x+wp.z,wp.y+wp.z*.4);
 float diagonal=sin(dot(paper,vec2(130.,94.)));
 float hatch=smoothstep(.70,.98,diagonal)*(.12+.19*(1.-abs(wn.y)));
 vec2 dotuv=fract(paper*42.)-.5;
 float dots=1.-smoothstep(.10,.24,length(dotuv));
 ALBEDO=c*(1.-hatch-.12*dots); ROUGHNESS=.88;
}
void light(){float n=max(dot(NORMAL,LIGHT),0.);DIFFUSE_LIGHT+=ALBEDO*0.0+LIGHT_COLOR*ATTENUATION*(.09+.43*smoothstep(.17,.21,n)+.38*smoothstep(.72,.79,n))/3.14159;}