shader_type spatial;
render_mode ambient_light_disabled, specular_disabled;

uniform vec4 coat : source_color = vec4(1.0);
uniform sampler2D artwork : source_color, filter_linear_mipmap_anisotropic, repeat_enable, hint_default_white;
uniform sampler2D source_trim : source_color, filter_linear_mipmap, repeat_enable, hint_default_white;
uniform float trim_ink : hint_range(0.0, 1.0) = 0.0;
uniform int surface_role : hint_enum("Equipment","Floor plate","Wall panel","Overhead steel") = 0;
uniform float hatch_strength : hint_range(0.0,1.0) = 0.24;
uniform float local_light : hint_range(0.0,1.0) = 0.34;
uniform float graphic_light : hint_range(0.0,1.0) = 0.0;
varying vec3 wp;
varying vec3 wn;

void vertex(){
    wp = (MODEL_MATRIX * vec4(VERTEX,1.0)).xyz;
    wn = normalize(MODEL_NORMAL_MATRIX * NORMAL);
}

// Fade printed screens under their pixel footprint at grazing angles.
float dots(vec2 p, float radius){
    float footprint = max(fwidth(p.x), fwidth(p.y));
    float d = length(fract(p + vec2(0.5))-0.5);
    return (1.0-smoothstep(radius-0.035, radius+0.035+footprint*0.42,d))*(1.0-smoothstep(0.27,0.84,footprint));
}

void fragment(){
    vec3 n = normalize(wn);
    vec2 planar = abs(n.y)>0.67 ? wp.xz : (abs(n.x)>abs(n.z) ? wp.zy : wp.xy);
    vec2 coords = surface_role==1 ? wp.xz/4.0 : UV;
    vec3 paint = coat.rgb * COLOR.rgb * texture(artwork,coords).rgb;
    vec3 src = texture(source_trim,UV).rgb;
    float tone = dot(src,vec3(0.28,0.53,0.19));
    paint *= mix(1.0, 0.74 + 0.20*smoothstep(0.036,0.075,tone) + 0.12*smoothstep(0.19,0.23,tone),trim_ink);
    if (surface_role==2 && wp.y>0.81 && wp.y<2.85){
        float stripe = 1.0-smoothstep(0.07,0.079,abs(wp.y-1.42));
        paint = mix(paint,vec3(0.63,0.035,0.21),stripe);
        paint *= mix(vec3(0.77,0.81,0.91),vec3(1.0),step(2.27,wp.y));
        float panel_edge = 1.0-smoothstep(0.003,0.012,abs(fract((planar.x+0.03)/1.98+0.5)-0.5));
        paint *= 1.0-0.48*panel_edge;
    }
    float key = dot(n,normalize(vec3(-0.53,0.74,0.41)));
    float face = smoothstep(-0.14,-0.09,key);
    float light_face = smoothstep(0.43,0.48,key);
    vec3 levels = mix(vec3(0.34,0.36,0.57),vec3(0.66,0.66,0.81),face);
    levels = mix(levels,vec3(0.96,0.97,1.02),light_face);
    float hatch_coord = (planar.x*0.82+planar.y*0.60)*47.0;
    float hatch = smoothstep(0.53,0.83,sin(hatch_coord*6.283))*(1.0-smoothstep(0.23,0.79,fwidth(hatch_coord)));
    levels *= 1.0-hatch_strength*hatch*(1.0-light_face);
    vec3 result = paint * levels;
    if(graphic_light>0.0){
        // Two bay inspection lamps throw a wedge down the wall and across the deck.
        float travel = max(0.0,3.07-wp.y);
        float fan_center = wp.x < 2.33 ? 1.25 : 3.40;
        float width = 0.12+0.21*travel;
        float inside = width - abs(wp.x-fan_center+0.05*travel);
        float reach = (surface_role==1) ? (-wp.z-8.72) : (wp.z+11.96);
        float field = min(inside,reach);
        float core = smoothstep(0.075,0.105,field);
        float stipple = dots(mat2(vec2(0.82,0.57),vec2(-0.57,0.82))*planar*46.0,0.22);
        float shoulder = smoothstep(-0.31,-0.015,field);
        float bay = step(-11.95,wp.z)*step(wp.z,-8.45)*step(wp.y,3.10);
        vec3 lamp = result*vec3(1.03,0.69,0.76)+vec3(0.135,0.028,0.050);
        result = mix(result,lamp,graphic_light*bay*(0.54*core+0.59*shoulder*stipple));
    }
    ALBEDO = paint;
    EMISSION = result;
    ROUGHNESS = 1.0;
    SPECULAR = 0.0;
}

void light(){
    float wrap = dot(NORMAL,LIGHT);
    float patch = smoothstep(0.19,0.28,wrap);
    DIFFUSE_LIGHT += LIGHT_COLOR * (local_light / 3.14159) * ATTENUATION * patch;
}
