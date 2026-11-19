shader_type spatial;
render_mode cull_disabled,specular_disabled;
void fragment(){
 ALBEDO=COLOR.rgb;
 EMISSION=COLOR.rgb*.043;
 ROUGHNESS=.94;
}
void light(){
 float n=max(dot(NORMAL,LIGHT),0.);
 float steps=.3*smoothstep(.09,.14,n)+.38*smoothstep(.38,.48,n)+.32*smoothstep(.7,.78,n);
 DIFFUSE_LIGHT+=LIGHT_COLOR*ATTENUATION*mix(n,steps,.63)/PI;
}
