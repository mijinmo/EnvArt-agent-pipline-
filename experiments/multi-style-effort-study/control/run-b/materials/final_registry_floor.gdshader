shader_type spatial;
uniform sampler2D scan : source_color, filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D rough_scan : filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D normal_scan : hint_normal, filter_linear_mipmap_anisotropic, repeat_enable;
varying vec3 world;
void vertex() { world = (MODEL_MATRIX * vec4(VERTEX,1.0)).xyz; }
void fragment() {
	vec2 uv = world.xz * 0.60;
	float mineral = dot(texture(scan,uv).rgb,vec3(0.25,0.55,0.2));
	float r = texture(rough_scan,uv).r;
	vec2 seam = abs(fract((world.xz+vec2(0.71,0.32))/2.16 + 0.5)-0.5)*2.16;
	float joint = 1.0-smoothstep(0.001,0.003+length(fwidth(world.xz))*0.5,min(seam.x,seam.y));
	vec3 composite = vec3(0.019,0.020,0.027) + vec3(0.33,0.35,0.39)*mineral;
	ALBEDO = composite*(1.0-0.28*joint);
	ROUGHNESS = 0.285 + r*0.20;
	SPECULAR = 0.39;
	if (world.z > -3.70 && abs(world.x)<2.0) {
		float grain = texture(rough_scan,uv*3.2).r;
		float anti_alias = 1.0-smoothstep(0.0005,0.0028,length(fwidth(world.xz)));
		float pile = 0.5+0.5*sin(world.x*2150.0)*sin(world.z*1750.0);
		float hem = (1.0 - smoothstep(0.008,0.019,min(2.0-abs(world.x),world.z+3.70)));
		ALBEDO = vec3(0.090,0.022,0.038)*(0.61+grain*0.78)*(1.0-hem*0.33)*(1.0+anti_alias*(pile-0.5)*0.08);
		ROUGHNESS = 0.88;
		SPECULAR = 0.19;
	}
	vec2 bump=(texture(normal_scan,uv).rg*2.0-1.0)*0.09;
	NORMAL=normalize(mat3(VIEW_MATRIX)*vec3(bump.x,1.0,bump.y));
}
