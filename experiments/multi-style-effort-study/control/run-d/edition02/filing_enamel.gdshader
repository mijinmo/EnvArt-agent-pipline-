shader_type spatial;
uniform sampler2D paint : source_color,filter_linear_mipmap_anisotropic;
uniform sampler2D roller : filter_linear_mipmap_anisotropic,repeat_enable;
varying vec3 world;
varying vec3 face;
void vertex(){
    world = (MODEL_MATRIX * vec4(VERTEX,1.0)).xyz;
    face = normalize(MODEL_NORMAL_MATRIX * NORMAL);
}
void fragment(){
    vec3 a=abs(face);
    vec2 p=a.y>max(a.x,a.z)?world.xz:(a.x>a.z?world.zy:world.xy);
    float brush=texture(roller,p*vec2(2.2,0.67)).r;
    float age=texture(roller,p*0.44+vec2(0.42,0.17)).r;
    float zinc=dot(texture(paint,UV).rgb,vec3(0.30,0.59,0.11));
    ALBEDO=vec3(0.060,0.088,0.096)*(0.76+0.18*age+0.35*brush+0.82*zinc);
    ROUGHNESS=0.27+brush*0.24;
    METALLIC=0.24;
}
