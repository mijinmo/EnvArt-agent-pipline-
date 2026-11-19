shader_type spatial;
uniform vec4 coat : source_color = vec4(.64,.29,.22,1.);
uniform vec4 steel : source_color = vec4(.36,.32,.28,1.);
uniform float chips = .45;
varying vec3 pos;
float h(vec2 p){return fract(sin(dot(p,vec2(91.7,187.2)))*7327.4);}
void vertex(){pos=(MODEL_MATRIX*vec4(VERTEX,1.)).xyz;}
void fragment(){
 float cell=h(floor(pos.xy*vec2(44.,86.))+floor(pos.z*27.));float scratch=sin(pos.y*104.+sin(pos.x*42.+pos.z*29.)*1.4);
 float wear=smoothstep(.87,.95,cell)*smoothstep(.55,.87,scratch)*chips;
 ALBEDO=mix(coat.rgb,steel.rgb,wear);ROUGHNESS=mix(.70,.93,wear);
}
