shader_type sky;
uniform vec4 horizon : source_color = vec4(0.86,0.53,0.34,1.0);
uniform vec4 high_sky : source_color = vec4(0.34,0.30,0.36,1.0);
uniform vec4 cloud_shadow : source_color = vec4(0.43,0.32,0.34,1.0);
uniform vec4 cloud_light : source_color = vec4(0.86,0.60,0.43,1.0);
uniform vec3 sun_direction = vec3(-0.49,0.12,-0.86);
float hash(vec2 p){return fract(sin(dot(p,vec2(127.7,257.2)))*15343.13);}
float facet(vec2 p){
 vec2 i=floor(p),f=fract(p);
 float a=hash(i),b=hash(i+vec2(1.,0.)),c=hash(i+vec2(0.,1.)),d=hash(i+1.);
 return f.x+f.y<1.?a+(b-a)*f.x+(c-a)*f.y:d+(b-d)*(1.-f.y)+(c-d)*(1.-f.x);
}
void sky(){
 vec3 e=EYEDIR;
 float glow=pow(max(0.,dot(e,normalize(sun_direction))),9.);
 vec3 base=mix(horizon.rgb,high_sky.rgb,smoothstep(-.09,.48,e.y));
 base+=glow*vec3(.15,.044,.009);
 vec2 uv=e.xz/max(.035,e.y+.075);
 float c=facet(uv*vec2(.61,1.9))*.67+facet(uv*vec2(1.62,3.85)+3.7)*.33;
 float mask=smoothstep(.57,.575,c)*smoothstep(.002,.13,e.y);
 vec3 pigment=mix(cloud_light.rgb,cloud_shadow.rgb,smoothstep(.59,.72,c));
 base=mix(base,pigment,mask*.70);
 float radius=distance(e,normalize(sun_direction));
 COLOR=base+vec3(1.15,.68,.25)*(1.-smoothstep(.030,.033,radius));
}
