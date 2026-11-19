shader_type spatial;
render_mode specular_disabled;
uniform sampler2D atlas : source_color;
varying vec3 local_pos;
void vertex(){local_pos=VERTEX;}
void fragment(){
 vec3 rgb=texture(atlas,UV).rgb;
 float hi=max(max(rgb.r,rgb.g),rgb.b);
 float lo=min(min(rgb.r,rgb.g),rgb.b);
 float ferrous=(1.-smoothstep(.028,.082,hi-lo))*smoothstep(.07,.23,hi)*(1.-smoothstep(.65,.91,hi));
 vec3 metal=mix(vec3(.12,.23,.22),vec3(.34,.48,.39),smoothstep(.1,.47,hi));
 vec3 paint=mix(rgb,metal,ferrous*.90);
 float warm=smoothstep(.04,.22,rgb.r-rgb.b);
 paint=mix(paint,paint*vec3(.88,1.02,1.10)+vec3(.026,.025,.016),warm*.96);
 ALBEDO=paint; ROUGHNESS=.97;
}