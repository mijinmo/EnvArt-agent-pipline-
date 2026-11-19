shader_type spatial;
render_mode cull_disabled, specular_disabled;
uniform vec4 ink : source_color;
uniform vec4 light_ink : source_color;
void fragment(){
 ALBEDO = mix(ink.rgb, light_ink.rgb, UV.x);
 ROUGHNESS=1.0;
}
