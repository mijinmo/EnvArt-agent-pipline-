shader_type spatial;
uniform sampler2D albedo_map : source_color, filter_linear_mipmap_anisotropic;
uniform vec4 tint : source_color = vec4(0.70,0.70,0.60,1.0);
uniform float saturation = 0.38;
uniform float contrast = 0.47;
varying vec3 world_p;
void vertex(){ world_p=(MODEL_MATRIX*vec4(VERTEX,1.0)).xyz; }
void fragment(){
 vec3 c=texture(albedo_map,UV).rgb;
 float y=dot(c,vec3(.299,.587,.114));
 c=mix(vec3(y),c,saturation);
 c=(c-vec3(.42))*contrast+vec3(.42);
 float foot=1.0-.23*(1.0-smoothstep(.2,1.5,world_p.y));
 ALBEDO=c*tint.rgb*foot; ROUGHNESS=.88;
}
