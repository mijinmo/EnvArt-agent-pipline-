shader_type sky;
uniform vec4 horizon : source_color = vec4(.84,.49,.31,1.);
uniform vec4 zenith : source_color = vec4(.32,.37,.48,1.);
float hash(vec2 p){return fract(sin(dot(p,vec2(127.1,311.7)))*43758.5453);}
float tri(vec2 p){
 vec2 c=floor(p), f=fract(p);
 float a=hash(c),b=hash(c+vec2(1,0)),d=hash(c+vec2(0,1)),e=hash(c+1.);
 return f.x+f.y<1.?a+(b-a)*f.x+(d-a)*f.y:e+(d-e)*(1.-f.x)+(b-e)*(1.-f.y);
}
void sky(){
 vec3 e=EYEDIR;
 vec3 col=mix(horizon.rgb,zenith.rgb,smoothstep(-.08,.55,e.y));
 vec2 plane=e.xz/max(.02,e.y+.035);
 float cloud=tri(plane*vec2(1.05,2.4))*.7+tri(plane*vec2(2.,4.1))*.3;
 float mask=smoothstep(.42,.43,cloud)*smoothstep(.02,.13,e.y);
 col=mix(col,mix(vec3(.20,.155,.18),vec3(.49,.295,.23),smoothstep(.54,.55,cloud)),mask*.72);
 float sun=length(e-normalize(vec3(.71,.10,-.70)));
 col+=vec3(1.9,1.15,.56)*(1.-smoothstep(.051,.053,sun));
 COLOR=col;
}
