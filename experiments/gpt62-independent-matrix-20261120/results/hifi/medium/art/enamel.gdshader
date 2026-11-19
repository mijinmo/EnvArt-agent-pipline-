shader_type spatial;
uniform sampler2D palette : source_color, filter_nearest;
uniform vec4 paint : source_color = vec4(0.33, 0.47, 0.61, 1.0);
uniform float grain = 0.13;
varying vec3 world_pos;
varying vec3 world_norm;
void vertex(){
 world_pos=(MODEL_MATRIX*vec4(VERTEX,1.0)).xyz;
 world_norm=normalize(MODEL_NORMAL_MATRIX*NORMAL);
}
void fragment(){
 vec3 swatch=texture(palette,UV).rgb;
 float level=dot(swatch,vec3(0.25,0.6,0.15));
 vec3 pigment=paint.rgb*(0.19+1.3*level);
 if(swatch.r>swatch.b*1.6 && swatch.r>0.23){pigment=mix(vec3(0.70,0.17,0.025),vec3(1.0,0.58,0.08),level);}
 vec3 n=abs(world_norm);
 vec2 p=n.y>0.65?world_pos.xz:(n.x>n.z?world_pos.zy:world_pos.xy);
 float lines=(p.x+p.y*0.68)*46.0;
 float ink=smoothstep(0.77,0.96,cos(lines*6.283))*clamp(1.0-fwidth(lines)*1.4,0.0,1.0);
 ALBEDO=pigment*(1.0-grain*ink); ROUGHNESS=0.84;
}
void light(){
 float facing=dot(NORMAL,LIGHT);
 DIFFUSE_LIGHT+=LIGHT_COLOR*ATTENUATION*(0.06+0.4*smoothstep(0.04,0.12,facing)+0.4*smoothstep(0.53,0.62,facing))/3.14159;
}
