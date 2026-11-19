shader_type spatial;
uniform sampler2D paint : source_color, filter_linear_mipmap_anisotropic;
uniform sampler2D surface : filter_linear_mipmap_anisotropic, repeat_enable;
uniform vec3 body = vec3(0.072,0.105,0.124);
varying vec3 w;
varying vec3 face;
void vertex() {
 w=(MODEL_MATRIX*vec4(VERTEX,1.)).xyz;
 face=normalize(MODEL_NORMAL_MATRIX*NORMAL);
}
void fragment() {
 vec2 p=abs(face.x)>0.7?w.zy:(abs(face.y)>0.7?w.xz:w.xy);
 float age=texture(surface,p*1.17).g;
 float original=texture(paint,UV).g;
 ALBEDO=body*(0.84+original*0.45+age*0.33);
 METALLIC=0.26;
 ROUGHNESS=0.25+age*0.32;
}
