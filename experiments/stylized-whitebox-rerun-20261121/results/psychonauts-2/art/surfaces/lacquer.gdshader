shader_type spatial;
uniform sampler2D grain : repeat_enable, filter_linear_mipmap_anisotropic;
uniform vec4 pigment : source_color = vec4(0.25,0.4,0.35,1.0);
uniform float frequency = 0.68;
uniform float contrast = 0.65;
uniform float gloss = 0.45;
uniform float metal = 0.16;
uniform bool timber = false;
varying vec3 surface_pos;
varying vec3 surface_normal;
void vertex(){
 surface_pos = (MODEL_MATRIX * vec4(VERTEX,1.0)).xyz;
 surface_normal = normalize(MODEL_NORMAL_MATRIX * NORMAL);
}
void fragment(){
 vec3 q=surface_pos*frequency;
 vec3 w=pow(abs(normalize(surface_normal)),vec3(6.0)); w/=max(dot(w,vec3(1.0)),.001);
 vec2 a=q.zy; vec2 b=q.xz; vec2 c=q.xy;
 if(timber){a=a.yx;b=b.yx;c=c.yx;}
 float v=dot(w,vec3(texture(grain,a).r,texture(grain,b).r,texture(grain,c).r));
 float shift=timber ? .29 : .335;
 ALBEDO=pigment.rgb*clamp(1.0+(v-shift)*contrast,0.47,1.54);
 ROUGHNESS=clamp(gloss+(v-shift)*.32,.16,.94); METALLIC=metal;
}
