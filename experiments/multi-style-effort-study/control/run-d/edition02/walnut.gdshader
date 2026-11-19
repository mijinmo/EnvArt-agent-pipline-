shader_type spatial;
uniform sampler2D veneer : source_color,filter_linear_mipmap_anisotropic,repeat_enable;
uniform sampler2D rough_scan : filter_linear_mipmap_anisotropic,repeat_enable;
uniform sampler2D normal_scan : hint_normal,filter_linear_mipmap_anisotropic,repeat_enable;
varying vec3 world; varying vec3 face;
void vertex(){world=(MODEL_MATRIX*vec4(VERTEX,1)).xyz;face=normalize(MODEL_NORMAL_MATRIX*NORMAL);}
void fragment(){
    bool east=abs(face.x)>abs(face.z);
    float along=east?world.z:world.x;
    float leaf=floor(along/0.67);
    vec2 uv=vec2(world.y*0.41+0.13*fract(leaf*0.618),
                 mix(along,-along,mod(leaf,2.0))*0.70+leaf*0.21);
    float g=dot(texture(veneer,uv).rgb,vec3(0.30,0.58,0.12));
    float ray=dot(texture(veneer,uv*vec2(0.39,1.9)+vec2(0.08,0.52)).rgb,vec3(0.30,0.58,0.12));
    ALBEDO=vec3(0.021,0.009,0.007)+vec3(0.63,0.316,0.195)*g+vec3(0.092,0.051,0.046)*ray;
    ROUGHNESS=0.33+texture(rough_scan,uv).r*0.215;
    vec2 n=(texture(normal_scan,uv).xy*2.0-1.0)*0.12;
    NORMAL=normalize(mat3(VIEW_MATRIX)*(face+(east?vec3(0,n.x,n.y):vec3(n.y,n.x,0))));
}
