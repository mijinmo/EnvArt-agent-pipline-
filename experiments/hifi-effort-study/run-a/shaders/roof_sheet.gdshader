shader_type spatial;
render_mode specular_disabled;
varying vec2 p;
void vertex(){p = (MODEL_MATRIX*vec4(VERTEX,1.0)).xz;}
void fragment(){
    vec2 uv=mod(p+vec2(0.32,0.2),vec2(2.40,3.0));
    vec2 edge=min(uv,vec2(2.40,3.0)-uv);
    float seam=min(edge.x,edge.y);
    float ink=1.0-smoothstep(0.006,0.013,seam);
    float emboss=smoothstep(0.017,0.027,seam)*(1.0-smoothstep(0.029,0.038,seam));
    float rivet=1.0-smoothstep(0.012,0.023,length(edge-vec2(0.072,0.093)));
    vec3 sheet=mix(vec3(0.030,0.051,0.088),vec3(0.051,0.072,0.109),step(0.6,mod(floor(p.x/2.4)+floor(p.y/3.0),2.0)));
    ALBEDO=mix(sheet,vec3(0.009,0.016,0.035),max(ink,rivet))+emboss*vec3(0.012,0.017,0.023);
    ROUGHNESS=1.0;
}
