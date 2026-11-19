shader_type spatial;
uniform sampler2D scan : source_color, filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D rough_scan : filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D normal_scan : hint_normal, filter_linear_mipmap_anisotropic, repeat_enable;
varying vec3 world;
void vertex() {world=(MODEL_MATRIX*vec4(VERTEX,1)).xyz;}
void fragment() {
    vec2 uv=world.xz*0.405;
    float aggregate=dot(texture(scan,uv).rgb,vec3(0.29,0.55,0.16));
    float flake=smoothstep(0.235,0.54,aggregate);
    float grind=texture(rough_scan,uv).r;
    vec2 spacing=vec2(2.46,2.81);
    vec2 joints=abs(mod(world.xz+vec2(0.19,0.73)+spacing*0.5,spacing)-spacing*0.5);
    float seam=1.0-smoothstep(0.0008,0.002+max(fwidth(world.x),fwidth(world.z))*0.58,min(joints.x,joints.y));
    ALBEDO=(vec3(0.031,0.032,0.043)+vec3(0.245,0.265,0.32)*aggregate+flake*vec3(0.109,0.116,0.124))*(1.0-0.31*seam);
    ROUGHNESS=0.16+0.24*grind+0.09*seam;
    SPECULAR=0.45;
    vec2 n=(texture(normal_scan,uv).xy*2.0-1.0)*0.103;
    NORMAL=normalize(mat3(VIEW_MATRIX)*vec3(n.x,1.0,n.y));
}
