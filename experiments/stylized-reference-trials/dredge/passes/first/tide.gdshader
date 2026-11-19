shader_type spatial;
uniform vec4 deep : source_color = vec4(.16,.31,.34,1.);
uniform float phase=0.36;
varying vec3 world;
float hash(vec2 p){return fract(sin(dot(p,vec2(127.1,311.7)))*43758.5);}
void vertex(){world=(MODEL_MATRIX*vec4(VERTEX,1.)).xyz;}
void fragment(){
 vec2 p=world.xz*vec2(.38,2.7);
 float line=sin(p.y+sin(p.x+phase)*1.14+phase);
 float cells=hash(floor(vec2(p.x*2.,p.y*.15)));
 float fleck=smoothstep(.91,.98,line)*smoothstep(.56,.7,cells);
 ALBEDO=deep.rgb*(.85+.12*step(.1,line))+vec3(.24,.24,.17)*fleck;
 ROUGHNESS=.7;
}
