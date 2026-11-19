shader_type spatial;
render_mode cull_disabled, specular_disabled;
uniform sampler2D pigment : source_color, hint_default_white, repeat_enable, filter_linear_mipmap_anisotropic;
uniform vec4 wash : source_color = vec4(1.0);
uniform float grain_relief : hint_range(0.0,1.0) = 0.42;
uniform float band_strength : hint_range(0.0,1.0) = 0.78;
uniform vec2 tiling = vec2(1.);
uniform bool use_vertex = false;
varying vec3 wp;
void vertex(){wp=(MODEL_MATRIX*vec4(VERTEX,1.)).xyz;}
void fragment(){
 vec3 tex=texture(pigment,UV*tiling).rgb*wash.rgb;
 if(use_vertex){tex*=COLOR.rgb;}
 float l=max(0.008,dot(tex,vec3(.299,.587,.114)));
 float key=floor(sqrt(l)*8.+.5)/8.;
 ALBEDO=mix(tex,tex*clamp(key*key/l,.66,1.38),grain_relief);
 ROUGHNESS=.92;
}
void light(){
 float n=max(dot(NORMAL,LIGHT),0.);
 float a=smoothstep(.13,.21,n)*.28+smoothstep(.45,.52,n)*.35+smoothstep(.75,.81,n)*.37;
 DIFFUSE_LIGHT+=LIGHT_COLOR*ATTENUATION*mix(n,a,band_strength)/PI;
}
