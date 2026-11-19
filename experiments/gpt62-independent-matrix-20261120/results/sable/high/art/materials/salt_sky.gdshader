shader_type sky;
float h(float v){return fract(sin(v*68.57)*5374.53);}
float n(float v){float i=floor(v);return mix(h(i),h(i+1.),smoothstep(0.,1.,fract(v)));}
float crest(float a){return .016+n(a*2.7)*.045+clamp((n(a*8.)-.39)*1.5,0.,.082)+n(a*43.)*.006;}
void sky(){
 float a=atan(EYEDIR.x,EYEDIR.z);float y=EYEDIR.y;
 vec3 col=mix(vec3(.77,.91,.81),vec3(.32,.73,.76),smoothstep(-.06,.62,y));
 float cloud=y+.04*n(a*4.)+.024*n(a*15.);
 col=mix(col,vec3(.93,.94,.82),smoothstep(.22,.223,cloud)*(1.-smoothstep(.234,.237,cloud)) * smoothstep(.40,.78,n(a*6.)));
 float farh=crest(a+6.)*1.60;
 col=mix(col,vec3(.58,.69,.65),1.-smoothstep(farh,farh+.0017,y));
 float rim=crest(a)*.88;
 if(y<rim){float layer=fract((rim-y+ .007*n(a*8.))*73.);
 col=mix(vec3(.65,.54,.45),vec3(.78,.65,.49),smoothstep(.1,.16,layer));}
 if(y<-.014){col=vec3(.85,.60,.34);}
 COLOR=col;
}