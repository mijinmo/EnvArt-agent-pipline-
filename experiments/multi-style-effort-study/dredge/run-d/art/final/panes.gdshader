shader_type spatial;
uniform vec4 shadow : source_color = vec4(.21,.31,.33,1.);
uniform vec4 glint : source_color = vec4(.50,.56,.53,1.);
varying vec3 p;
void vertex(){p=(MODEL_MATRIX*vec4(VERTEX,1.)).xyz;}
void fragment(){
 float u=p.x*.72+p.z*.44+p.y*1.3;
 float band=smoothstep(.72,.73,fract(u*.83))*.43+smoothstep(.91,.92,fract(u*.83))*.26;
 ALBEDO=mix(shadow.rgb,glint.rgb,band);
 ROUGHNESS=.62;
}
