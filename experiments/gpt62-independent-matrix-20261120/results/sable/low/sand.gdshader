shader_type spatial;
render_mode specular_disabled;
varying vec2 ground;
void vertex(){ground=(MODEL_MATRIX*vec4(VERTEX,1.)).xz;}
float hash(vec2 p){return fract(sin(dot(p,vec2(127.1,311.7)))*4375.5453);}
void fragment(){
 vec2 p=ground*8.;vec2 id=floor(p);float n=hash(id);
 vec2 st=fract(p)-vec2(.2+.6*n,.2+.6*hash(id+4.));
 float grain=(1.-smoothstep(.05,.10,length(st*vec2(.85,1.8))))*step(.86,n);
 ALBEDO=mix(vec3(.79,.49,.255),vec3(.36,.22,.14),grain);
 ROUGHNESS=1.;
}
