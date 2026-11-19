shader_type sky;
uniform vec4 horizon : source_color = vec4(0.91,0.94,0.90,1.0);
uniform vec4 zenith : source_color = vec4(0.60,0.88,0.90,1.0);
uniform vec4 cloud : source_color = vec4(1.0,0.985,0.92,1.0);
float cirrus(vec2 p, vec2 center, vec2 size){
 vec2 q=(p-center)/size;
 float w=clamp(1.0-abs(q.x),0.0,1.0);
 float ridge=q.y-.15*sin(q.x*3.2)-.10*q.x;
 float thickness=w*(.7+.28*sin(q.x*6.2+1.7)+.12*sin(q.x*12.5));
 return smoothstep(-.028,.028,thickness-abs(ridge));
}
void sky(){
 vec2 p=vec2(atan(EYEDIR.x,-EYEDIR.z),asin(EYEDIR.y));
 vec3 base=mix(horizon.rgb,zenith.rgb,smoothstep(-.04,.52,p.y));
 float a=max(cirrus(p,vec2(.04,.24),vec2(.31,.028)),cirrus(p,vec2(.14,.216),vec2(.19,.010)));
 a=max(a,cirrus(p,vec2(.92,.27),vec2(.29,.021)));
 a=max(a,cirrus(p,vec2(1.38,.15),vec2(.21,.008)));
 a=max(a,cirrus(p,vec2(.55,.11),vec2(.09,.005)));
 COLOR=mix(base,cloud.rgb,a*.88);
}