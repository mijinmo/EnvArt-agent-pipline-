shader_type spatial;
uniform sampler2D scan : source_color, filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D rough_scan : filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D normal_scan : hint_normal, filter_linear_mipmap_anisotropic, repeat_enable;
uniform bool floor_finish = false;
varying vec3 world;
varying vec3 face;
void vertex(){
	world = (MODEL_MATRIX*vec4(VERTEX,1.0)).xyz;
	face = normalize(MODEL_NORMAL_MATRIX*NORMAL);
}
void fragment(){
	vec3 axis=abs(face);
	vec2 plane=axis.y>max(axis.x,axis.z)?world.xz:(axis.x>axis.z?world.zy:world.xy);
	vec2 uv=plane*(floor_finish?0.38:0.42);
	float fine=dot(texture(scan,uv).rgb,vec3(0.25,0.55,0.20));
	vec2 variation=mat2(vec2(0.81,0.59),vec2(-0.59,0.81))*uv*0.35+vec2(0.24,0.36);
	float broad=dot(texture(scan,variation).rgb,vec3(0.25,0.55,0.20));
	if(floor_finish){
		ALBEDO=vec3(0.72,0.79,0.84)*pow(max(fine,0.001),1.09)*0.95;
		ROUGHNESS=clamp(0.19+texture(rough_scan,uv).r*0.24,0.18,0.48);
	}else{
		float tone=clamp(0.06+fine*0.68+broad*0.64,0.07,0.68);
		ALBEDO=vec3(0.91,0.94,0.92)*tone*mix(0.80,1.0,smoothstep(0.1,1.1,world.y));
		ROUGHNESS=0.56+texture(rough_scan,uv).r*0.30;
	}
	vec2 bump=texture(normal_scan,uv).xy*2.0-1.0;
	float strength=floor_finish?0.22:0.59;
	vec3 n=axis.y>max(axis.x,axis.z)?vec3(bump.x,0,bump.y):(axis.x>axis.z?vec3(0,bump.y,bump.x):vec3(bump.x,bump.y,0));
	NORMAL=normalize(mat3(VIEW_MATRIX)*(face+n*strength));
}
