shader_type spatial;
uniform sampler2D atlas : source_color, filter_linear_mipmap;
varying vec3 wp;
void vertex(){ wp=(MODEL_MATRIX*vec4(VERTEX,1.0)).xyz; }
void fragment(){
 vec3 c=texture(atlas,UV).rgb;
 float iswall=smoothstep(.04,.15,c.r-c.g);
 vec3 plaster=vec3(.39,.40,.34)*(0.94+0.06*sin(wp.y*1.7+sin(wp.z*.8)));
 ALBEDO=mix(c*vec3(.40,.46,.43),plaster,iswall);ROUGHNESS=.85;
}
