shader_type spatial;
varying vec3 p;
varying vec3 n;
uniform vec3 half_size=vec3(.75,.45,.75);
uniform vec4 enamel:source_color=vec4(.62,.55,.43,1);
uniform vec4 rail:source_color=vec4(.42,.39,.34,1);
uniform vec4 stripe:source_color=vec4(.84,.67,.43,1);
void vertex(){p=VERTEX;n=NORMAL;}
void fragment(){
 float face=step(.6,abs(n.x)); float u=mix(p.x,p.z,face); float w=mix(half_size.x,half_size.z,face);
 float fromtop=half_size.y-p.y;float side= w-abs(u);
 vec3 col=mix(enamel.rgb,rail.rgb,step(fromtop,.055));
 float corner=step(side,.075)*step(fromtop,.28);
 col=mix(col,rail.rgb,corner);
 float socket=1.-smoothstep(.019,.03,length(vec2(side-.045,fromtop-.15)));
 col=mix(col,stripe.rgb,socket);
 float slats=step(abs(u+.27*w),.15)*step(abs(fromtop-.18),.039)*step(fract(u*23.),.45);
 col=mix(col,rail.rgb,slats);
 float top=step(.6,n.y);vec2 margin=half_size.xz-abs(p.xz);
 float grip=step(abs(fract((p.x+p.z)*7.)-.5),.12)*step(abs(fract((p.x-p.z)*3.6)-.5),.18);
 vec3 lid=mix(enamel.rgb*1.08,enamel.rgb*.89,grip);
 float lip=step(min(margin.x,margin.y),.021);
 ALBEDO=mix(col,mix(lid,rail.rgb,lip),top);ROUGHNESS=.98;
}
