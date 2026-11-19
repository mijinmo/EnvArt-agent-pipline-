shader_type spatial;
render_mode unshaded, cull_disabled;
uniform vec4 shadow : source_color = vec4(.30,.285,.34,1.);
uniform vec4 sunlit : source_color = vec4(.58,.435,.41,1.);
void fragment() {
 ALBEDO=mix(shadow.rgb,sunlit.rgb,UV.x*.75);
}
