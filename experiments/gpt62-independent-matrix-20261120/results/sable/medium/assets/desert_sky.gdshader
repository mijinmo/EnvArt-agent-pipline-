shader_type sky;
// Distant sedimentary benches and high cloud banks, painted by azimuth.
float wave(float a){ return sin(5.0*a+0.9)*0.42+sin(11.0*a)*0.26+sin(17.0*a+1.7)*0.20+sin(37.0*a)*0.09; }
void sky(){
 float a=atan(EYEDIR.z,EYEDIR.x);
 float h=EYEDIR.y;
 vec3 c=mix(vec3(.73,.89,.84),vec3(.29,.65,.72),smoothstep(-.02,.57,h));
 float wind=.37+.072*sin(3.*a)+.019*sin(11.*a);
 float lens=abs(h-wind)*36.+.64+.58*sin(6.*a+.4)+.20*sin(23.*a);
 c=mix(c,vec3(.87,.94,.88),1.-smoothstep(.94,1.,lens));
 float farline=.015+.115*smoothstep(-.44,.32,wave(a+.6))+.003*sin(55.*a);
 float midline=-.018+.106*smoothstep(-.21,.27,wave(a))+.003*sin(40.*a);
 c=mix(c,vec3(.64,.60,.63),1.-smoothstep(farline-.001,farline+.001,h));
 vec3 rock=mix(vec3(.74,.53,.41),vec3(.89,.68,.51),smoothstep(midline-.01,midline-.007,h));
 float layer=h+.006*sin(8.*a)+.003*sin(29.*a);
 rock*=1.-.092*(1.-smoothstep(.0004,.0014,abs(layer-.031)));
 c=mix(c,rock,1.-smoothstep(midline-.001,midline+.001,h));
 c=mix(c,vec3(.84,.61,.39),1.-smoothstep(-.026,-.022,h));
 COLOR=c;
}
