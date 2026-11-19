shader_type spatial;
render_mode unshaded;
uniform float phase=0.36;
varying vec3 wp;
void vertex(){wp=(MODEL_MATRIX*vec4(VERTEX,1.)).xyz;}
float rand2(vec2 p){return fract(sin(dot(p,vec2(77.1,184.3)))*6318.47);}
void fragment(){
 vec2 p=wp.xz;
 float d=length(p-CAMERA_POSITION_WORLD.xz);
 vec2 eye=normalize(p-CAMERA_POSITION_WORLD.xz);
 float path=pow(max(dot(eye,normalize(vec2(.97,-.45))),0.),28.);
 float f=sin(p.y*1.8+sin(p.x*.36+phase)+.45*sin(p.x*.94-p.y*.37));
 float cell=rand2(floor(p*vec2(.24,1.7)));
 float wave=step(.77,f)*step(.53,cell);
 vec3 c=mix(vec3(.041,.109,.122),vec3(.151,.142,.143),smoothstep(12.,125.,d));
 c=mix(c,c*1.24,step(-.08,f)*.7);c+=wave*(vec3(.037,.052,.058)+vec3(.45,.23,.09)*path);
 ALBEDO=c;
}
