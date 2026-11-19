shader_type spatial;
uniform sampler2D veneer : source_color, filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D rough_scan : filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D normal_scan : hint_normal, filter_linear_mipmap_anisotropic, repeat_enable;
varying vec3 world;
varying vec3 face;
void vertex(){
	world=(MODEL_MATRIX*vec4(VERTEX,1.0)).xyz;
	face=normalize(MODEL_NORMAL_MATRIX*NORMAL);
}
void fragment(){
	bool east=abs(face.x)>abs(face.z);
	float along=east?world.z:world.x;
	float panel=floor((along+0.16)/0.87);
	vec2 uv=vec2(world.y*0.54,along*0.92 + fract(panel*0.317));
	vec3 wood=texture(veneer,uv).rgb;
	float grain=dot(wood,vec3(0.28,0.57,0.15));
	ALBEDO=vec3(0.058,0.024,0.018)+grain*vec3(0.65,0.38,0.232);
	ROUGHNESS=0.36+texture(rough_scan,uv).r*0.24;
	vec2 bump=(texture(normal_scan,uv).rg*2.0-1.0)*0.13;
	vec3 slope=east?vec3(0,bump.x,bump.y):vec3(bump.y,bump.x,0);
	NORMAL=normalize(mat3(VIEW_MATRIX)*(face+slope));
}
