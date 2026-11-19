shader_type spatial;
render_mode specular_disabled;
uniform vec4 stone : source_color = vec4(0.82, 0.58, 0.47, 1.0);
uniform vec4 seam : source_color = vec4(0.65, 0.41, 0.36, 1.0);
uniform vec4 salt : source_color = vec4(0.91, 0.71, 0.56, 1.0);
uniform float relief : hint_range(0.,1.) = 0.67;
varying vec3 site_position;
void vertex(){ site_position=(MODEL_MATRIX*vec4(VERTEX,1.)).xyz; }
float h(float x){return fract(sin(x*157.3)*43758.545);}
float undulate(float x){float i=floor(x);return mix(h(i),h(i+1.),smoothstep(0.,1.,fract(x)));}
void fragment(){
 float x=site_position.x+site_position.z*.77;
 float y=site_position.y+.092*undulate(x*1.18)+.11*sin(x*.65)+.055*sin(x*.91+.4);
 float height=y*1.35+.17*undulate(x*.37);
 float bed=floor(height);
 float t=fract(height);
 float layers=(1.-smoothstep(.018,.053,t))*smoothstep(.14,.48,undulate(x*1.4+bed*17.));
 float strata=step(.67,t)*step(t,.83)*smoothstep(.3,.68,undulate(x*.73+bed*22.));
 vec3 hue=mix(stone.rgb,seam.rgb,(.09+.14*h(bed*18.))*relief);
 hue=mix(hue,seam.rgb,(layers*.8+strata*.17)*relief);
 hue=mix(hue,salt.rgb,(1.-smoothstep(.04,.14,abs(t-.49)))*smoothstep(.4,.7,undulate(x*1.2+bed))*relief*.44);
 ALBEDO=hue;ROUGHNESS=1.;
}
