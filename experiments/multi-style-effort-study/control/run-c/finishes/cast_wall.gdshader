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
		vec2 pitch=vec2(2.4,1.33);
        vec2 cast_pos=plane+vec2(0.47,0.11);
        vec2 edge=(0.5-abs(fract(cast_pos/pitch)-0.5))*pitch;
        float aa=max(max(fwidth(plane.x),fwidth(plane.y)),0.001);
        float joint=1.0-smoothstep(0.001,0.006+aa,min(edge.x,edge.y));
        vec2 pin=(fract(cast_pos/vec2(1.2,1.33))-0.5)*vec2(1.2,1.33);
        float hole=1.0-smoothstep(0.011,0.018+aa,length(pin));
        float cast_tone=1.0-0.23*joint-0.40*hole;
        float tone=clamp(0.06+fine*0.68+broad*0.64,0.07,0.68);
		ALBEDO=vec3(0.95,0.925,0.93)*tone*cast_tone*mix(0.80,1.0,smoothstep(0.1,1.1,world.y));
		ROUGHNESS=0.56+texture(rough_scan,uv).r*0.30;
	}
	vec2 bump=texture(normal_scan,uv).xy*2.0-1.0;
	float strength=floor_finish?0.22:0.59;
	vec3 n=axis.y>max(axis.x,axis.z)?vec3(bump.x,0,bump.y):(axis.x>axis.z?vec3(0,bump.y,bump.x):vec3(bump.x,bump.y,0));
	NORMAL=normalize(mat3(VIEW_MATRIX)*(face+n*strength));
}
