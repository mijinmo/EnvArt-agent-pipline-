shader_type spatial;
render_mode cull_disabled,specular_disabled;
uniform sampler2D pigment:source_color,hint_default_white,repeat_enable,filter_linear_mipmap_anisotropic;
uniform vec4 wash:source_color=vec4(1.);
uniform vec2 tiling=vec2(1.);
uniform bool use_vertex=false;
uniform int surface_role=0;
varying vec3 wp;
varying vec3 wn;
void vertex(){wp=(MODEL_MATRIX*vec4(VERTEX,1.)).xyz;wn=MODEL_NORMAL_MATRIX*NORMAL;}
float hash(vec2 p){return fract(sin(dot(p,vec2(25.17,89.21)))*7532.96);}
void fragment(){
 vec3 c=texture(pigment,UV*tiling).rgb*wash.rgb;
 if(use_vertex){c*=COLOR.rgb;}
 if(surface_role==1){
  float along=abs(wn.z)>abs(wn.x)?wp.x:wp.z;
  float course=floor(wp.y/.245);
  float seam=1.-smoothstep(.005,.019,abs(fract(wp.y/.245+.5)-.5)*.245);
  float chips=hash(floor(vec2(along*15.,wp.y*64.)));
  vec3 chalk=c*vec3(.99,.74,.64);
  vec3 low=mix(vec3(.095,.105,.096),vec3(.158,.17,.149),hash(vec2(course,floor(along/2.))));
  c=mix(low*(1.-.35*seam),chalk,step(.714+.04*step(.93,chips),wp.y));
  c=mix(c,vec3(.31,.12,.072),step(.754,wp.y)*step(wp.y,.82)*step(.12,chips));
 }else if(surface_role==2){c*=vec3(.47,.34,.34);}
 else if(surface_role==3){c*=vec3(.70,.58,.52);}
 else if(surface_role==4){c*=vec3(.31,.40,.43);}
 else if(surface_role==5){c*=vec3(.52,.55,.58);}
 float v=max(.01,dot(c,vec3(.299,.587,.114)));
 float tone=floor(sqrt(v)*13.+.5)/13.;
 ALBEDO=mix(c,c*clamp(tone*tone/v,.76,1.24),.43);
 ROUGHNESS=.93;
}
void light(){float n=max(dot(NORMAL,LIGHT),0.);float a=smoothstep(.09,.18,n)*.36+smoothstep(.43,.5,n)*.35+smoothstep(.76,.84,n)*.29;
 DIFFUSE_LIGHT+=LIGHT_COLOR*ATTENUATION*mix(n,a,.8)/PI;}
