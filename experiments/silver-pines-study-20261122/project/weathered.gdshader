shader_type spatial;
render_mode diffuse_burley, specular_schlick_ggx;
uniform sampler2D atlas : source_color, filter_linear_mipmap_anisotropic;
uniform sampler2D normal_atlas : hint_normal, filter_linear_mipmap_anisotropic;
uniform sampler2D siding : source_color, filter_linear_mipmap_anisotropic, repeat_enable;
uniform float cutout_threshold = 0.35;
varying vec3 world;
varying vec3 surface_normal;
void vertex(){world=(MODEL_MATRIX*vec4(VERTEX,1)).xyz;surface_normal=normalize(MODEL_NORMAL_MATRIX*NORMAL);}
uniform float normal_strength = 0.7;
uniform bool repaint_wood = false;
uniform vec3 tint : source_color = vec3(0.78,0.82,0.79);
void fragment() {
	vec4 c=texture(atlas,UV);
	float lum=dot(c.rgb,vec3(0.2126,0.7152,0.0722));
	vec3 col=mix(vec3(lum),c.rgb,0.30);
	bool is_wood=repaint_wood && c.r>c.g*1.18 && c.r>c.b*1.18;
	if(is_wood) col=texture(siding,vec2(abs(surface_normal.z)>0.5?world.x:world.z,-world.y)/1.8).rgb;
	else if(repaint_wood && lum>0.48) col*=0.57;
	ALBEDO=col*tint*0.78;
	ALPHA=c.a;
	ALPHA_SCISSOR_THRESHOLD=cutout_threshold;
	NORMAL_MAP=texture(normal_atlas,UV).rgb;
	NORMAL_MAP_DEPTH=is_wood?0.0:normal_strength;
	ROUGHNESS=0.76;
}
