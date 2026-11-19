shader_type sky;
float ridge(float a, float f){
 return .49+.22*sin(a*f)+.145*sin(a*(f+5.)+1.8)+.08*sin(a*(f+11.)+4.3)+.055*sin(a*(f+25.)+.3);
}
float skyline(float a,float k){
 float g=ridge(a+k,4.);
 float base=.016+.044*g;
 float ledges=.043*smoothstep(.26,.45,g)+.046*smoothstep(.46,.56,g)+.035*smoothstep(.62,.71,g);
 float fins=pow(max(0.,cos(17.*a+3.*sin(a*4.))),16.)*.041*smoothstep(.36,.58,g);
 return base+ledges+fins+.0034*sin(a*53.)+.002*sin(a*96.);
}
void sky(){
 float a=atan(EYEDIR.x,EYEDIR.z);float y=EYEDIR.y;
 vec3 skywash=mix(vec3(.85,.91,.78),vec3(.32,.72,.77),smoothstep(-.04,.53,y));
 float vapor=y-.034*sin(a*3.)-.017*sin(a*9.)-.006*sin(a*18.);
 float cloud=(smoothstep(.225,.229,vapor)-smoothstep(.24,.246,vapor))*smoothstep(.46,.67,ridge(a+1.,4.));
 skywash=mix(skywash,vec3(.96,.95,.82),cloud*.77);
 float farh=skyline(a+.86,2.)*1.20;
 vec3 farcol=mix(vec3(.57,.71,.68),vec3(.65,.77,.72),smoothstep(-.1,.22,sin(a*19.+sin(a*8.))));
 vec3 col=mix(skywash,farcol,1.-smoothstep(farh,farh+.0013,y));
 float rim=skyline(a,3.)*.96;
 float bend=.007*sin(13.*a)+.003*cos(26.*a)+.0009*sin(83.*a);
 float phase=y+bend;
 float shelf=step(.46,fract(phase*39.))*.048;
 float stria=1.-smoothstep(.0,.030,abs(fract(phase*87.)-.42));
 float side=smoothstep(.06,.18,sin(a*16.+1.9*sin(a*7.))+.65*sin(a*30.));
 vec3 rock=mix(vec3(.67,.51,.45),vec3(.80,.64,.52),side)+shelf-vec3(.080,.066,.060)*stria;
 float weather=step(.70,sin(a*151.+y*24.))*smoothstep(.045,.075,rim-y);
 rock-=weather*.018;
 col=mix(col,rock,1.-smoothstep(rim,rim+.0015,y));
 col=mix(col,vec3(.84,.60,.35),1.-smoothstep(-.021,-.006,y));
 COLOR=col;
}