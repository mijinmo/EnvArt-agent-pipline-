shader_type spatial;
render_mode specular_disabled;
// UV.x on each island identifies its enamel, inset, bolt or marking.
uniform sampler2D inks : source_color, repeat_disable, filter_nearest;
uniform float hatch_density = 66.0;
uniform float ink_load : hint_range(0,1) = 0.27;
varying vec3 local_pos;
varying vec3 world_n;
void vertex(){
    local_pos = VERTEX;
    world_n = normalize(MODEL_NORMAL_MATRIX * NORMAL);
}
void fragment(){
    vec3 pigment = texture(inks, vec2(UV.x,0.5)).rgb;
    float incidence = dot(normalize(world_n), normalize(vec3(-0.52,0.76,0.42)));
    float shade = smoothstep(-0.13,-0.085,incidence);
    float highlight = smoothstep(0.66,0.69,incidence);
    vec3 exposed = pigment * mix(0.80,1.14,highlight);
    vec3 underside = pigment * vec3(0.38,0.42,0.64) + vec3(0.008,0.003,0.018);
    float phase = dot(local_pos,vec3(0.91,0.58,0.37)) * hatch_density;
    float aa = fwidth(phase);
    float hatch = (1.0-smoothstep(0.04,0.12+aa,abs(fract(phase)-0.5))) * (1.0-smoothstep(0.3,0.8,aa));
    ALBEDO = mix(underside*(1.0-ink_load*hatch),exposed,shade);
    ROUGHNESS=1.0;
    SPECULAR=0.0;
    EMISSION=ALBEDO*0.32;
}
void light(){
    float key = dot(NORMAL,LIGHT);
    float band = smoothstep(0.23,0.29,key)*0.49 + smoothstep(0.78,0.81,key)*0.24;
    DIFFUSE_LIGHT=max(DIFFUSE_LIGHT,LIGHT_COLOR*ATTENUATION*band/PI);
}
