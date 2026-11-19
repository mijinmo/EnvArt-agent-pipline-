shader_type sky;

uniform vec4 horizon : source_color = vec4(.91, .57, .35, 1.0);
uniform vec4 zenith : source_color = vec4(.32, .325, .42, 1.0);
uniform vec3 sun_direction = vec3(.25, .020, -.967);
float hash(vec2 p) {return fract(sin(dot(p,vec2(41.71,197.43)))*14567.32);}
float facet(vec2 p) {
 vec2 i=floor(p), f=fract(p);
 float a=hash(i), b=hash(i+vec2(1.,0.)), c=hash(i+vec2(0.,1.)), d=hash(i+1.);
 return f.x+f.y<1. ? a+(b-a)*f.x+(c-a)*f.y : d+(c-d)*(1.-f.x)+(b-d)*(1.-f.y);
}
void sky(){
 vec3 d=EYEDIR;
 float glow=max(0.,dot(d,normalize(sun_direction)));
 vec3 col=mix(horizon.rgb,zenith.rgb,smoothstep(-.05,.58,d.y));
 col+=vec3(.28,.085,.014)*pow(glow,20.);
 vec2 uv=d.xz/max(.035,.21+d.y);
 float clouds=facet(uv*vec2(1.28,3.7))*.76 + facet(uv*vec2(3.6,9.2))*.24;
 float opacity=smoothstep(.61,.625,clouds)*smoothstep(.014,.17,d.y);
 col=mix(col,mix(vec3(.27,.16,.18),vec3(.58,.32,.22),1.-smoothstep(.64,.82,clouds)),opacity*.55);
 float radius=length(d-normalize(sun_direction));
 col+=vec3(1.4,.78,.34)*(1.-smoothstep(.024,.026,radius));
 COLOR=col;
}
