shader_type spatial;
uniform vec4 deep : source_color = vec4(.16,.31,.34,1.);
uniform float phase = 0.36;
varying vec3 world;
float hash(vec2 p){return fract(sin(dot(p,vec2(127.1,311.7)))*43758.5);}
void vertex(){world=(MODEL_MATRIX*vec4(VERTEX,1.)).xyz;}
void fragment(){
 vec2 p=world.xz*vec2(.15,1.12);
 float wave=sin(p.y+sin(p.x*.87+phase)*1.34+sin(.29*p.y)+phase);
 float cells=hash(floor(vec2(p.x*1.27,p.y*.15)));
 float fade=1.-smoothstep(25.,95.,length(world.xz-CAMERA_POSITION_WORLD.xz));
 float fleck=smoothstep(.91,.98,wave)*smoothstep(.68,.82,cells)*fade;
 ALBEDO=deep.rgb*(.88+.19*smoothstep(.0,.15,wave))+vec3(.21,.19,.16)*fleck;
 ROUGHNESS=.78;
}
