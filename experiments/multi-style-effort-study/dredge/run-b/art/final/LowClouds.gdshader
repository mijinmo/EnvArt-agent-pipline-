shader_type sky;
uniform vec4 horizon : source_color = vec4(.89,.57,.39,1.);
uniform vec4 zenith : source_color = vec4(.35,.36,.44,1.);
uniform vec4 cloud : source_color = vec4(.55,.42,.43,1.);
uniform vec3 sun_direction = vec3(-.62,.42,.66);
float hash(vec2 p){return fract(sin(dot(p, vec2(141.1,237.3)))*7325.17);}
float cloud_bank(vec2 p,float seed){
 vec2 id=floor(p);
 vec2 f=fract(p);
 float j=hash(id+seed);
 vec2 c=vec2(.49+.12*(j-.5),.36+.28*hash(id+seed+8.));
 vec2 d=f-c;
 float endcap=abs(d.x)*2.75;
 float bottom=.115*(1.-endcap)+.040*(1.-abs(fract(f.x*4.+j)*2.-1.));
 float top=.083*(1.-endcap)+.038*(1.-abs(fract(f.x*5.+.3)*2.-1.));
 return step(.51,j)*step(0.,min(bottom+d.y,top-d.y))*step(endcap,1.);
}
void sky(){
 vec3 e=EYEDIR;
 float heading=atan(e.x,-e.z);
 vec2 p=vec2(heading,e.y);
 vec3 base=mix(horizon.rgb,zenith.rgb,smoothstep(-.06,.53,e.y));
 float distant=cloud_bank(p*vec2(5.2,32.)+vec2(.2,.61),3.7)*smoothstep(.016,.1,e.y);
 float high=cloud_bank(p*vec2(2.43,11.)+vec2(.83,1.31),8.3)*smoothstep(.05,.2,e.y);
 base=mix(base,cloud.rgb,.19*distant+.32*high);
 float d=distance(e,normalize(sun_direction));
 COLOR=base+vec3(.16,.066,.021)*pow(max(0.,dot(e,normalize(sun_direction))),6.)+vec3(1.4,.89,.43)*(1.-smoothstep(.031,.033,d));
}
