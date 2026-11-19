shader_type spatial;
render_mode cull_disabled, specular_disabled;
varying vec3 p;
uniform vec4 slate : source_color = vec4(.32,.36,.38,1.);
uniform vec4 grit : source_color = vec4(.54,.52,.48,1.);
void vertex(){p=VERTEX;}
void fragment(){
 float radial=length(p.yz);
 float stria = fract(radial*265.0 + 0.13*sin(atan(p.z,p.y)*7.0));
 float edge = smoothstep(.077,.084,radial);
 ALBEDO=mix(slate.rgb,grit.rgb,.20+edge*.50+smoothstep(.76,.82,stria)*.14);
 ROUGHNESS=.97;
}
