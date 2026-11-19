shader_type spatial;
render_mode specular_disabled;
uniform vec4 plank_a : source_color = vec4(.26,.27,.26,1.);
uniform vec4 plank_b : source_color = vec4(.47,.40,.32,1.);
uniform vec4 seam_colour : source_color = vec4(.17,.18,.20,1.);
uniform float width_m = .245;
uniform float length_m = 3.4;
varying vec3 wp;
varying vec3 wn;
float h(vec2 p){return fract(sin(dot(p,vec2(129.,271.1)))*4275.3);}
void vertex(){wp=(MODEL_MATRIX*vec4(VERTEX,1.)).xyz;wn=normalize(MODEL_NORMAL_MATRIX*NORMAL);}
void fragment(){
 vec2 uv=abs(wn.y)>.6?wp.xz:(abs(wn.z)>.55?wp.xy:wp.zy);
 vec2 p=uv/vec2(length_m,width_m);
 float row=floor(p.y);p.x+=h(vec2(row,15.));
 vec2 id=floor(p),f=fract(p),m=min(f,1.-f)*vec2(length_m,width_m);
 float grain=.5+.5*sin(f.y*42.+h(id)*51.+sin(f.x*11.+h(id)*7.)*.6);
 float value=.13+.69*h(id)+.035*grain;
 vec3 c=mix(plank_a.rgb,plank_b.rgb,value);
 float gap=min(m.x,m.y),w=max(fwidth(gap),.0005);
 c=mix(seam_colour.rgb,c,smoothstep(.0015-w,.004+w,gap));
 vec2 nail=vec2(min(f.x,1.-f.x)*length_m-.050,abs(f.y-.5)*width_m-.071);
 c=mix(c,seam_colour.rgb,.75*(1.-smoothstep(.004,.009+fwidth(nail.x),length(nail))));
 ROUGHNESS=.95;ALBEDO=c;
}
