shader_type sky;
uniform vec4 upper : source_color = vec4(.39,.34,.42,1.);
uniform vec4 dusk : source_color = vec4(.89,.53,.32,1.);
float hash(vec2 p){return fract(sin(dot(p,vec2(89.5,203.3)))*3573.4);}
float facet(vec2 p){vec2 i=floor(p),f=fract(p);float a=hash(i),b=hash(i+vec2(1,0)),c=hash(i+vec2(0,1)),d=hash(i+1.);
return f.x+f.y<1.?a+(b-a)*f.x+(c-a)*f.y:d+(c-d)*(1.-f.x)+(b-d)*(1.-f.y);}
void sky(){
 vec3 e=EYEDIR; vec3 s=normalize(vec3(.97,.078,-.45));
 vec3 col=mix(dusk.rgb,upper.rgb,smoothstep(-.025,.54,e.y));
 float towards=max(dot(e,s),0.);
 col+=vec3(.26,.093,.025)*pow(towards,12.);
 vec2 p=e.xz/max(.047,e.y+.11);
 float f=facet(p*vec2(1.2,2.5))*.72+facet(p*vec2(2.3,4.8))*.28;
 float clouds=smoothstep(.53,.543,f)*smoothstep(.01,.14,e.y);
 col=mix(col,mix(vec3(.31,.175,.16),vec3(.45,.255,.19),step(.61,f)),clouds*.68);
 col=mix(col,vec3(1.8,1.06,.46),1.-smoothstep(.032,.033,length(e-s)));
 COLOR=col;
}
