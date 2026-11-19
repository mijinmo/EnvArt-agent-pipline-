shader_type spatial;
varying vec3 p;
uniform vec4 clay:source_color=vec4(.82,.56,.39,1);
void vertex(){p=(MODEL_MATRIX*vec4(VERTEX,1)).xyz;}
void fragment(){
 float x=p.x*.85+p.z*.76;
 float y=p.y+.048*sin(1.8*x)+.083*sin(.56*x)+.011*sin(7.5*x);
 float strata=fract(y*.82+.056*sin(x*.81));
 float line=1.-smoothstep(.009,.021,min(strata,1.-strata));
 float dark=step(.64,strata)*.09+step(.85,strata)*.10+line*.28;
 ALBEDO=clay.rgb*(1.-dark);ROUGHNESS=1.;
}
