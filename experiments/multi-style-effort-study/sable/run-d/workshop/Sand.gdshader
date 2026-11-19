shader_type spatial;
render_mode specular_disabled;
uniform sampler2D sand_sheet : source_color,filter_linear_mipmap_anisotropic,repeat_disable;
varying vec2 survey;
void vertex(){survey=(MODEL_MATRIX*vec4(VERTEX,1.)).xz/32.+.5;}
void fragment(){ALBEDO=texture(sand_sheet,survey).rgb;ROUGHNESS=1.;}
