shader_type spatial;
render_mode diffuse_lambert,specular_disabled;
uniform vec4 limestone : source_color=vec4(.89,.66,.49,1.);
uniform vec4 earth : source_color=vec4(.75,.46,.35,1.);
uniform vec4 seam : source_color=vec4(.51,.36,.33,1.);
varying vec3 wpos;
void vertex(){wpos=(MODEL_MATRIX*vec4(VERTEX,1.)).xyz;}
void fragment(){
 float x=wpos.x+wpos.z*.80;float y=wpos.y;float a=sin(x*.61)*.085+sin(x*1.45+.2)*.018;
 float layer=y+a+sin(x*.30+y*1.9)*.07;float warm=(1.-smoothstep(.34,.38,layer))*.64+(1.-smoothstep(.91,.93,layer))*.19;
 float s=abs(fract(layer*1.52+sin(x*.32)*.17)-.5);float bit=smoothstep(-.42,.31,sin(x*.75+y*3.4)+.64*sin(x*.53-y*2.0));
 float grain=(1.-smoothstep(.005,.012+fwidth(layer)*1.1,s))*bit;
 vec3 stone=mix(limestone.rgb,earth.rgb,warm+step(.66,fract(layer*1.52))*.045);ALBEDO=mix(stone,seam.rgb,grain*.40);ROUGHNESS=1.;
}
