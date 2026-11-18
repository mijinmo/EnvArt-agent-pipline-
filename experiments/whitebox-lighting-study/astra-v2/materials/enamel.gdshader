shader_type spatial;
uniform sampler2D paint : source_color, filter_linear_mipmap_anisotropic;
void fragment(){
	float value=dot(texture(paint,UV).rgb,vec3(0.30,0.55,0.15));
	ALBEDO=vec3(0.100,0.135,0.119)*(0.88+value*1.60);
	METALLIC=0.12;
	ROUGHNESS=0.42+value*0.17;
}
