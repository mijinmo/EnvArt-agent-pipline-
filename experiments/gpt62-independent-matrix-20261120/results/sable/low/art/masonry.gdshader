shader_type spatial;
render_mode specular_disabled;
varying vec3 world_p;
varying vec3 face;
void vertex(){world_p=(MODEL_MATRIX*vec4(VERTEX,1.)).xyz;face=MODEL_NORMAL_MATRIX*NORMAL;}
float rnd(vec2 p){return fract(sin(dot(p,vec2(15.71,77.23)))*4375.5);}
void fragment(){
 vec2 p=abs(face.y)>.7?world_p.xz:vec2(abs(face.x)>.7?world_p.z:world_p.x,world_p.y);
 p/=vec2(1.26,.46);p.x+=mod(floor(p.y),2.)*.5;
 vec2 d=min(fract(p),1.-fract(p));
 float joint=1.-smoothstep(.004,.018,min(d.x*1.6,d.y));
 float r=rnd(floor(p));vec3 c=mix(vec3(.65,.42,.24),vec3(.85,.65,.40),r*.65);
 ALBEDO=mix(c,vec3(.32,.23,.17),joint*.75);ROUGHNESS=1.;
}
