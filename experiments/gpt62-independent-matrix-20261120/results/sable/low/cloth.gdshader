shader_type spatial;
render_mode cull_disabled, diffuse_lambert, specular_disabled;
uniform vec4 madder : source_color = vec4(0.78,0.27,0.18,1.0);
uniform vec4 linen : source_color = vec4(0.97,0.79,0.49,1.0);
void fragment(){
 float t=fract(UV.y*4.0);
 float sel=max(1.0-smoothstep(.05,.055,t),step(.97,t));
 sel=max(sel,step(.12,t)*(1.0-step(.14,t)));
 float diamond=abs(fract(UV.y*24.0)-.5)*2.0+abs(UV.x-.10)*16.0;
 sel=max(sel,step(.6,diamond)*(1.0-step(.88,diamond)));
 ALBEDO=mix(madder.rgb,linen.rgb,sel); ROUGHNESS=1.0;
}
