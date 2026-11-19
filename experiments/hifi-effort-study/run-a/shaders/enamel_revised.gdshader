shader_type spatial;
render_mode ambient_light_disabled, specular_disabled;

uniform vec4 coat : source_color = vec4(0.5,0.6,0.7,1);
uniform vec4 shadow_ink : source_color = vec4(0.25,0.31,0.48,1);
uniform sampler2D original_trim : source_color, hint_default_white, filter_linear_mipmap_anisotropic;
uniform bool printed_atlas = false;
uniform float trim_strength : hint_range(0,1) = 0.18;
uniform float hatch_strength : hint_range(0,1) = 0.16;
uniform float key_threshold : hint_range(0,1) = 0.36;
uniform sampler2D relief : hint_normal, filter_linear_mipmap_anisotropic;
uniform float relief_strength : hint_range(0,1) = 0.0;
uniform sampler2D body_print : source_color, hint_default_white, filter_linear_mipmap_anisotropic;
uniform sampler2D display_print : source_color, hint_default_white, filter_linear_mipmap_anisotropic;
varying vec3 local_n;
uniform int paint_pattern : hint_enum("Solid","Blade tip","Tank band","Wall route","Shipping case","Terminal") = 0;
varying vec3 object_position;
varying vec3 world_position;
varying vec3 world_normal;

void vertex(){
    object_position = VERTEX;
    local_n = NORMAL;
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
    paint *= mix(1.0,0.16 + 0.84*smoothstep(0.035,0.38,original),trim_strength);
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

    // Use the asset's existing trim UVs to ink recessed bevels. Printed panels use the model's dimensions.
    vec2 grooves = texture(relief,UV).xy * 2.0 - 1.0;
    float groove = dot(grooves,vec2(-0.7,0.72));
    paint *= 1.0 - relief_strength*0.51*smoothstep(0.12,0.36,-groove);
    paint *= 1.0 + relief_strength*0.27*smoothstep(0.13,0.46,groove);
    if (paint_pattern == 4){
        vec2 panel = abs(local_n.y)>0.55 ? object_position.xz : vec2(abs(local_n.x)>0.6?object_position.z:object_position.x,object_position.y);
        vec3 crate_print=texture(body_print,vec2(panel.x,-panel.y)/1.121+0.5).rgb;
        paint = mix(paint,crate_print,0.94)*(0.83+0.17*smoothstep(0.061,0.32,original));
    }
    if (paint_pattern == 5){
        vec2 body_uv=vec2(object_position.x/0.49+0.5,1.0-object_position.y/1.34);
        if(local_n.z>0.62 && object_position.y<1.34 && all(greaterThanEqual(body_uv,vec2(0.0))) && all(lessThanEqual(body_uv,vec2(1.0)))){
            paint=texture(body_print,body_uv).rgb;
        }
        if (object_position.y>1.274 && local_n.y>0.40 && local_n.z>0.40){
            vec2 screen_uv=vec2(0.5+object_position.x/0.679,1.0-(object_position.y-1.274)/0.320);
            paint=texture(display_print,clamp(screen_uv,vec2(0.0),vec2(1.0))).rgb;
        }
    }
    if (paint_pattern == 3){
        bool back_wall=abs(n.z)>0.75;
        float along=back_wall?world_position.x:world_position.z;
        float at=back_wall?-0.69:-9.54;
        float drop=2.91-world_position.y;
        float delta=along-at-0.06*drop;
        float outer=drop*0.50+0.21-abs(delta);
        float inner=drop*0.38+0.14-abs(delta);
        float lit=step(0.0,drop)*smoothstep(-0.012,0.012,outer)*(1.0-smoothstep(2.15,2.40,drop));
        vec2 stamp=vec2(along,world_position.y)*43.0;
        vec2 station=fract(stamp+vec2(mod(floor(stamp.y),2.0)*0.5,0.0))-0.5;
        float dot_ink=(1.0-smoothstep(0.19,0.27,length(station)))*(1.0-smoothstep(0.14,0.64,max(fwidth(stamp.x),fwidth(stamp.y))));
        vec3 spill=back_wall?vec3(0.26,0.15,0.14):vec3(0.18,0.23,0.26);
        paint+=lit*spill*(0.53+0.35*step(0.0,inner))*(1.0-0.56*dot_ink);
    }
    vec2 plane=abs(n.y)>0.65?world_position.xz:vec2(abs(n.x)>0.65?world_position.z:world_position.x,world_position.y);
    float stroke=(plane.x*0.82-plane.y)*34.0;
    float hatch=smoothstep(0.68,0.96,cos(stroke*TAU))*(1.0-smoothstep(0.15,0.61,fwidth(stroke)));
    vec3 shade = mix(shadow_ink.rgb,vec3(0.43,0.48,0.60),middle);
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
    DIFFUSE_LIGHT=max(DIFFUSE_LIGHT,LIGHT_COLOR*band*0.076);
}
