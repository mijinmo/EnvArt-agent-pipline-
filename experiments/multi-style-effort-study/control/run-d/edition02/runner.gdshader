shader_type spatial;
uniform sampler2D scan : source_color, filter_linear_mipmap_anisotropic, repeat_enable;
varying vec3 world;
void vertex(){world=(MODEL_MATRIX*vec4(VERTEX,1.0)).xyz;}
void fragment(){
    vec2 p=world.xz;
    float nap=texture(scan,p*0.65).r;
    float wear=1.0-smoothstep(0.2,1.55,abs(p.x-0.09*sin(p.y*1.2)));
    float faint=texture(scan,p*vec2(1.1,0.21)).g;
    vec2 band=clamp(vec2(1.0)-fwidth(p)*380.0,vec2(0.0),vec2(1.0));
    float weave=(cos(p.x*1420.0)*band.x + cos(p.y*1000.0)*band.y)*0.008;
    ALBEDO=vec3(0.106,0.020,0.031)*(0.70+nap*0.97+wear*0.16+faint*0.49+weave);
    ROUGHNESS=0.88;SPECULAR=0.20;
}
