shader_type spatial;
render_mode specular_disabled;
uniform vec4 sand : source_color = vec4(0.89,0.62,0.36,1.0);
uniform vec4 crest : source_color = vec4(0.94,0.72,0.45,1.0);
uniform vec4 lee : source_color = vec4(0.85,0.53,0.32,1.0);
varying vec2 ground;
void vertex(){ ground=(MODEL_MATRIX*vec4(VERTEX,1.0)).xz; }
void fragment(){
 vec2 p=ground;
 float wave=p.y*2.0+p.x*.59+0.64*sin(p.x*1.2)+0.4*sin(p.y*.87+p.x*0.53);
 float field=sin(p.x*.72-p.y*.32)+.62*sin(p.y*1.6+p.x*.66)+.38*sin(p.x*3.0);
 float stroke=smoothstep(.025,.09,fract(wave))*(1.0-smoothstep(.09,.16,fract(wave)));
 float ridges=smoothstep(.83,.98,field)*stroke;
 vec3 tint=mix(sand.rgb,crest.rgb,ridges*.69);
 tint=mix(tint,lee.rgb,(1.0-smoothstep(.0,.055,fract(wave)))*smoothstep(1.15,1.3,field)*.39);
 ALBEDO=tint;ROUGHNESS=1.0;
}