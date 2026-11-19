shader_type spatial;
render_mode specular_disabled;
varying vec2 p;
float h(vec2 v){return fract(sin(dot(v,vec2(127.1,311.7)))*43758.545);}
float n(vec2 v){vec2 i=floor(v),f=fract(v); f=f*f*(3.-2.*f);return mix(mix(h(i),h(i+vec2(1,0)),f.x),mix(h(i+vec2(0,1)),h(i+1.),f.x),f.y);}
void vertex(){p=(MODEL_MATRIX*vec4(VERTEX,1)).xz;}
void fragment(){
 float wind=n(p*vec2(.55,1.5)); float rip=abs(sin(19.*p.y+3.5*p.x+wind*5.));
 float trace=(1.-smoothstep(.015,.10,rip))*smoothstep(.63,.76,wind);
 vec2 cell=p*25.; float dotgrain=(1.-smoothstep(.04,.17,length(fract(cell)-vec2(.5))))*step(.92,h(floor(cell)));
 ALBEDO=mix(vec3(.84,.54,.29),vec3(.90,.64,.37),smoothstep(.31,.73,n(p*.82)))-vec3(.14,.13,.11)*(trace+dotgrain);
 ROUGHNESS=1.;
}