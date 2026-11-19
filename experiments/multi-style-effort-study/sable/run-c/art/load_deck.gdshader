shader_type spatial;
varying vec3 p;
varying vec3 n;
uniform vec4 enamel:source_color=vec4(.33,.49,.47,1.);
uniform vec4 rail:source_color=vec4(.24,.26,.29,1.);
uniform vec4 stripe:source_color=vec4(.88,.68,.43,1.);
void vertex(){p=VERTEX;n=NORMAL;}
void fragment(){
 vec2 uv=UV; float top=step(.7,abs(n.y)); float horizontal=mix(p.x,p.z,step(.6,abs(n.x)));
 float rim=step(uv.y,.085)+step(.92,uv.y);
 vec3 col=mix(enamel.rgb,rail.rgb,clamp(rim,0.,1.));
 float vent=step(abs(horizontal),.31)*step(abs(uv.y-.47),.12)*step(fract(horizontal*15.),.42);
 col=mix(col,rail.rgb,vent);
 float bolt=1.-smoothstep(.014,.028,length(vec2(abs(uv.x-.5)-.44,abs(uv.y-.5)-.34)));
 col=mix(col,stripe.rgb,bolt);
 float tread=step(abs(fract((p.x+p.z)*5.)-.5),.095)*step(abs(fract((p.x-p.z)*3.)-.5),.24);
 vec3 topcol=mix(enamel.rgb*.80,enamel.rgb*.62,tread);
 float border=step(.455,max(abs(uv.x-.5),abs(uv.y-.5)));
 topcol=mix(topcol,stripe.rgb,border);
 ALBEDO=mix(col,topcol,top);ROUGHNESS=.94;
}
