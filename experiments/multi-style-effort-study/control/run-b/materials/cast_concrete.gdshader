shader_type spatial;
uniform sampler2D scan : source_color, repeat_enable, filter_linear_mipmap_anisotropic;
uniform sampler2D rough_scan : repeat_enable, filter_linear_mipmap_anisotropic;
uniform sampler2D normal_scan : hint_normal, repeat_enable, filter_linear_mipmap_anisotropic;
uniform float form_width = 2.45;
uniform float lift_height = 2.72;
varying vec3 pos;
varying vec3 face;
void vertex() {
	pos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	face = normalize(MODEL_NORMAL_MATRIX * NORMAL);
}
void fragment() {
	vec3 axis = abs(face);
	bool horizontal_face = axis.y > max(axis.x, axis.z);
	bool side = axis.x > axis.z;
	vec2 wall = horizontal_face ? pos.xz : (side ? pos.zy : pos.xy);
	vec2 uv = wall * 0.39;
	float scanned = dot(texture(scan, uv).rgb, vec3(0.27, 0.56, 0.17));
	vec2 crossed = mat2(vec2(0.84,0.54),vec2(-0.54,0.84)) * uv * 0.63 + vec2(0.18,0.79);
	float bloom = dot(texture(scan, crossed).rgb, vec3(0.27,0.56,0.17));
	float tone = 0.104 + scanned * 0.58 + bloom * 0.47;
	vec2 bay = wall + vec2(0.37,0.035);
	vec2 delta = abs(fract(bay / vec2(form_width,lift_height) + 0.5) - 0.5) * vec2(form_width,lift_height);
	float width = max(0.0008, length(fwidth(wall))*0.6);
	float groove = (1.0 - smoothstep(0.001,0.003+width,min(delta.x,delta.y)));
	vec2 anchor = (fract((bay+vec2(0.32,0.44))/vec2(form_width*0.5,lift_height*0.5))-0.5)*vec2(form_width*0.5,lift_height*0.5);
	float plug = (1.0 - smoothstep(0.008,0.012+width,length(anchor)));
	float rim = (1.0 - smoothstep(0.0015,0.005+width,abs(length(anchor)-0.014)));
	float construction = horizontal_face ? 1.0 : (1.0 - groove*0.19 - plug*0.22 - rim*0.14);
	ALBEDO = vec3(0.98,0.947,0.925) * tone * construction * mix(0.86,1.0,smoothstep(0.0,0.72,pos.y));
	ROUGHNESS = 0.59 + texture(rough_scan,uv).r * 0.20;
	vec2 bump = (texture(normal_scan,uv).rg*2.0-1.0)*0.26;
	vec3 slope = horizontal_face ? vec3(bump.x,0,bump.y) : (side ? vec3(0,bump.y,bump.x) : vec3(bump.x,bump.y,0));
	NORMAL = normalize(mat3(VIEW_MATRIX) * (face+slope));
}
