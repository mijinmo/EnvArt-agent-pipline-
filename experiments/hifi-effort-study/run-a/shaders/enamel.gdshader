shader_type spatial;
render_mode ambient_light_disabled, specular_disabled;

uniform vec4 coat : source_color = vec4(0.5,0.6,0.7,1);
uniform vec4 shadow_ink : source_color = vec4(0.25,0.31,0.48,1);
uniform sampler2D original_trim : source_color, hint_default_white, filter_linear_mipmap_anisotropic;
uniform bool printed_atlas = false;
uniform float trim_strength : hint_range(0,1) = 0.18;
uniform float hatch_strength : hint_range(0,1) = 0.16;
uniform float key_threshold : hint_range(0,1) = 0.36;
uniform int paint_pattern : hint_enum("Solid","Blade tip","Tank band","Wall route") = 0;
varying vec3 object_position;
varying vec3 world_position;
varying vec3 world_normal;

void vertex(){
    object_position = VERTEX;
    world_position = (MODEL_MATRIX * vec4(VERTEX,1.0)).xyz;
    world_normal = normalize(MODEL_NORMAL_MATRIX * NORMAL);
}

void fragment(){
    vec3 n = normalize(world_normal);
    float facing = dot(n,normalize(vec3(-0.48,0.74,0.54)));
    float middle = smoothstep(-0.12,-0.06,facing);
    float top = smoothstep(0.52,0.55,facing);
    vec3 paint = coat.rgb;
    vec3 sampled = texture(original_trim,UV).rgb;
    if (printed_atlas) { paint *= sampled; }
    float original = dot(sampled,vec3(0.2126,0.7152,0.0722));
    paint *= mix(1.0,0.53 + 0.47*smoothstep(0.04,0.15,original),trim_strength);
    if(paint_pattern == 1){
        float radius = length(object_position.xz);
        paint = mix(paint,vec3(0.89,0.60,0.15),step(0.442,radius));
        paint *= 1.0 - 0.69*(step(0.462,radius)-step(0.474,radius));
    }
    if(paint_pattern == 2){
        float y = object_position.y;
        paint = mix(paint, vec3(0.85,0.68,0.32), step(0.47,y)-step(0.65,y));
        paint *= 1.0-0.60*(step(0.52,y)-step(0.54,y));
    }
    if(paint_pattern == 3){
        float y = world_position.y;
        paint = mix(paint,vec3(0.65,0.042,0.19),step(1.58,y)-step(1.72,y));
        paint *= 1.0-0.16*step(2.48,y);
    }
    vec2 plane=abs(n.y)>0.65?world_position.xz:vec2(abs(n.x)>0.65?world_position.z:world_position.x,world_position.y);
    float stroke=(plane.x*0.82-plane.y)*34.0;
    float hatch=smoothstep(0.68,0.96,cos(stroke*TAU))*(1.0-smoothstep(0.15,0.61,fwidth(stroke)));
    vec3 shade = mix(shadow_ink.rgb,vec3(0.48,0.53,0.64),middle);
    shade = mix(shade,vec3(0.88,0.88,0.83),top);
    shade *= 1.0 - hatch*hatch_strength*(1.0-top);
    ALBEDO=paint;
    EMISSION=paint*shade;
    ROUGHNESS=0.98;
    SPECULAR=0.0;
}
void light(){
    float light_mask=max(dot(NORMAL,LIGHT),0.0)*ATTENUATION;
    float band=smoothstep(key_threshold-0.015,key_threshold+0.015,light_mask);
    DIFFUSE_LIGHT=max(DIFFUSE_LIGHT,LIGHT_COLOR*band*0.13);
}
