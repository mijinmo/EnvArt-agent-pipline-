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
uniform sampler2D relief : hint_normal, repeat_enable, filter_linear_mipmap_anisotropic;
uniform sampler2D decal : source_color, repeat_disable, filter_linear_mipmap_anisotropic;
uniform sampler2D floor_shadow : repeat_disable, filter_linear_mipmap;
uniform sampler2D floor_print : source_color, repeat_disable, filter_linear_mipmap_anisotropic;
uniform int fitment : hint_enum("Plain","Parts case","Drum","Pedestal","Locker","Display","Deck","Threshold") = 0;
uniform float pressed_lines : hint_range(0.0,1.0) = 0.0;
uniform float cast_density : hint_range(0.0,1.0) = 0.86;
varying vec3 lp;
varying vec3 ln;
varying vec3 wp;
varying vec3 wn;

void vertex(){
    lp = VERTEX;
    ln = NORMAL;
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
    // The kit's normal atlas supplies engraved dark cuts and the opposing light lip.
    vec2 ridge = texture(relief, UV).rg * 2.0 - 1.0;
    float relief_floor = smoothstep(0.12,0.30,length(ridge));
    float engraved = smoothstep(0.095,0.37,dot(ridge,vec2(0.82,0.57)));
    paint *= 1.0 - pressed_lines * relief_floor * (0.21+0.47*engraved);
    paint += vec3(0.105,0.115,0.100) * pressed_lines * smoothstep(0.23,0.54,-dot(ridge,vec2(0.8,0.6)));
    vec2 decal_uv = vec2(-2.0);
    float show = 0.0;
    if(fitment==1){
        float band = step(0.352,abs(lp.x))*step(abs(lp.x),0.409);
        paint = mix(paint,vec3(0.050,0.083,0.115),band);
        paint *= mix(0.62,1.0,step(-0.35,lp.y));
        if(ln.z>0.70){decal_uv=vec2(lp.x/0.74+0.5,0.50-lp.y/0.285);show=1.0;}
    }
    if(fitment==2){
        float ring = step(0.316,lp.y)*step(lp.y,0.364) + step(0.718,lp.y)*step(lp.y,0.747);
        paint=mix(paint,vec3(0.07,0.11,0.15),ring);
    }
    if(fitment==3){
        paint=mix(paint*vec3(0.42,0.55,0.72),paint,step(0.52,lp.y));
        paint=mix(paint,vec3(0.10,0.38,0.37),step(1.02,lp.y)*step(lp.y,1.085));
    }
    if(fitment==4){
        paint=mix(paint*vec3(0.38,0.57,0.65),paint,step(0.42,lp.y));
        if(ln.z>0.8){decal_uv=vec2(lp.x/0.57+0.50,0.50-(lp.y-1.79)/0.21);show=1.0;}
    }
    if(fitment==5){paint=vec3(0.006,0.013,0.024);decal_uv=vec2(lp.x/0.674+0.5,1.0-(lp.y-1.277)/0.314);show=1.0;}
    if(show>0.5 && min(decal_uv.x,decal_uv.y)>=0.0 && max(decal_uv.x,decal_uv.y)<=1.0){
        vec4 mark=texture(decal,decal_uv);
        paint=mix(paint,mark.rgb,mark.a);
    }
    vec2 print_uv = (wp.xz+vec2(5.0,12.0))/vec2(15.0,10.0);
    if(fitment==6){
        vec4 marking = texture(floor_print,print_uv);
        paint=mix(paint,marking.rgb,marking.a);
    }
    if(fitment==7){
        vec2 frac_panel=fract(planar*vec2(1.35,1.60));
        float join=1.0-smoothstep(0.002,0.012,min(frac_panel.x,frac_panel.y));
        paint*=1.0-join*0.41;
        if (n.y<0.6){
            float tape=step(0.88,wp.y)*step(wp.y,1.005);
            float slash=step(.55,fract((planar.x+wp.y)*5.27));
            paint=mix(paint,mix(vec3(.075,.095,.13),vec3(.65,.39,.049),slash),tape);
        }
    }
    if(surface_role==3 && wp.y>4.97 && n.y<-.80){
        vec2 rib=abs(fract((wp.xz+vec2(0.3,-.17))/vec2(1.75,1.52)+0.5)-0.5);
        float joint=1.0-smoothstep(0.003,0.009,min(rib.x,rib.y));
        paint*=1.0-0.50*joint;
    }
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
    float ink_area=mix(0.35,1.0,smoothstep(-0.04,0.18,0.08-key));
    levels *= 1.0-hatch_strength*hatch*(1.0-light_face)*ink_area;
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
        vec3 lamp = wp.x < 2.33 ? result*vec3(0.62,1.04,0.86)+vec3(0.012,0.088,0.062) : result*vec3(1.03,0.63,0.68)+vec3(0.192,0.030,0.045);
        result = mix(result,lamp,graphic_light*bay*(0.75*core+0.54*shoulder*stipple));
    }
    if(fitment==6){
        vec3 cast=texture(floor_shadow,print_uv).rgb;
        float dots_border=dots(mat2(vec2(.82,.57),vec2(-.57,.82))*wp.xz*53.0,.23);
        float shadow=min(1.0,cast.r+0.73*cast.b*dots_border);
        vec3 shade=mix(vec3(1.0),vec3(.40,.44,.65),cast_density*shadow);
        shade*=mix(vec3(1.0),vec3(.56,.64,.77),cast.g*0.86);
        float pool=1.0-smoothstep(0.73,1.00,length((wp.xz-vec2(2.65,-8.75))/vec2(3.42,2.82)));
        result*=mix(vec3(.64,.72,.83),vec3(.96,1.00,.97),pool)*shade;
        paint*=shade;
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
