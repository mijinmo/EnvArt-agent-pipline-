shader_type spatial;
varying vec2 ground;
void vertex(){ground=(MODEL_MATRIX*vec4(VERTEX,1.0)).xz;}
float seed(vec2 q){return fract(sin(dot(q,vec2(27.17,74.43)))*43758.5453);}
void fragment(){
 vec2 cells=ground*15.0;
 vec2 id=floor(cells);
 float k=seed(id);
 vec2 p=fract(cells)-vec2(.25+.5*k,.25+.5*seed(id+7.32));
 float mark=1.0-smoothstep(.065,.12,length(p*vec2(.78,1.85)));
 float drift=sin(ground.x*2.61+ground.y*3.98+.55*sin(ground.y*1.28));
 ALBEDO=mix(vec3(.80,.555,.315),vec3(.58,.365,.205),mark*step(.86,k)+.035*smoothstep(.88,1.,drift));
 ROUGHNESS=1.;
}
