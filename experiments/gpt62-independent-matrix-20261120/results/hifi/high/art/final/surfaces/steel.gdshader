shader_type spatial;
render_mode diffuse_lambert, specular_disabled;

uniform vec4 shell_dark : source_color = vec4(.13,.17,.24,1.);
uniform vec4 shell_light : source_color = vec4(.47,.55,.64,1.);
uniform vec4 trim : source_color = vec4(.96,.60,.14,1.);
uniform vec4 glass : source_color = vec4(.14,.62,.69,1.);
uniform float ink_weight = 0.72;
uniform float paper = 1.0;
uniform float deck = 0.;
varying vec3 surface_pos;
varying vec3 world_n;

float hash(vec2 p) { return fract(sin(dot(p,vec2(41.17,79.31)))*4375.315); }
void vertex() {
 surface_pos=(MODEL_MATRIX * vec4(VERTEX,1.)).xyz;
 world_n=normalize(MODEL_NORMAL_MATRIX*NORMAL);
}
void fragment() {
 vec2 data=UV*vec2(32.,8.);
 float code=floor(data.x);
 float value=mod(code,8.)/7.;
 float group=floor(code/8.);
 vec3 col=mix(shell_dark.rgb,shell_light.rgb,value);
 if(group==1.) col=trim.rgb*(.47+.53*value);
 if(group==2.) col=vec3(.014,.021,.036);
 if(group==3.) col=glass.rgb*(.5+.5*value);
 vec2 xy=(fract(data)-.15)/.7;
 vec3 bc=vec3(xy,1.-xy.x-xy.y);
 int mask=int(floor(data.y));
 vec3 d=bc/max(fwidth(bc),vec3(.0001));
 float edge=100.;
 if ((mask&1)!=0) edge=min(edge,d.x);
 if ((mask&2)!=0) edge=min(edge,d.y);
 if ((mask&4)!=0) edge=min(edge,d.z);
 vec3 face=normalize(cross(dFdx(surface_pos),dFdy(surface_pos)));
 face*=sign(dot(face,world_n));
 NORMAL=normalize(mat3(VIEW_MATRIX)*face);
 vec3 dir=abs(face);
 vec2 plane=dir.y>max(dir.x,dir.z)?surface_pos.xz:(dir.x>dir.z?surface_pos.zy:surface_pos.xy);
 float band=plane.x*57.+plane.y*79.;
 float aa=max(fwidth(band),.001);
 float hatch=(1.-smoothstep(.07,.22,abs(fract(band)-.5)))*(1.-smoothstep(.26,.65,aa));
 float cells=hash(floor(plane*vec2(2.,3.)));
 float shade=1.-smoothstep(.05,.58,value);
 col*=1.-paper*hatch*(.10+.26*shade)*smoothstep(.26,.88,cells);
 vec2 sc=plane*vec2(3.4,8.); vec2 id=floor(sc);
 vec2 st=fract(sc)-.5; st.y+=st.x*.72;
 float abrasion=(1.-smoothstep(.005,.035,abs(st.y)))*(1.-smoothstep(.10,.36,abs(st.x)))*step(.90,hash(id));
 col=mix(col,col*1.8+vec3(.012),abrasion*paper*.65);
 if(deck>.5 && dir.y>.8) {
   vec2 tc=fract(surface_pos.xz/1.5); vec2 seam=min(tc,1.-tc)*1.5;
   float joint=1.-smoothstep(.004,.012,min(seam.x,seam.y));
   float bolt=1.-smoothstep(.010,.019,length(seam-vec2(.055)));
   col*=1.-.68*max(joint,bolt);
 }
 col=mix(col,vec3(.011,.016,.032),ink_weight*(1.-smoothstep(.16,1.05,edge)));
 ALBEDO=col; ROUGHNESS=.84;
}
void light() {
 float angle=max(0.,dot(NORMAL,LIGHT));
 float band=mix(angle,floor(angle*4.+.5)/4.,.27);
 DIFFUSE_LIGHT+=LIGHT_COLOR*ATTENUATION*band/PI;
}
