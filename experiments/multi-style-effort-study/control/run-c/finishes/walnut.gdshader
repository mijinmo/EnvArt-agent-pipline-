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
	vec2 uv=vec2(world.y*0.32,along*0.67+0.17);
	vec3 wood=texture(veneer,uv).rgb;
	float brightness=dot(wood,vec3(0.28,0.57,0.15));
	ALBEDO=vec3(0.027,0.008,0.006)+pow(brightness,0.85)*vec3(0.39,0.137,0.085);
	ROUGHNESS=0.42+texture(rough_scan,uv).r*0.22;
	vec2 bump=(texture(normal_scan,uv).xy*2.0-1.0)*0.14;
	vec3 profile=east?vec3(0.0,bump.x,bump.y):vec3(bump.y,bump.x,0.0);
	NORMAL=normalize(mat3(VIEW_MATRIX)*(face+profile));
}
