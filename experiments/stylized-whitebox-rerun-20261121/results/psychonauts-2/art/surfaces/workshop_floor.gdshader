shader_type spatial;

uniform sampler2D wear : source_color, repeat_enable, filter_linear_mipmap_anisotropic;
uniform vec4 limestone : source_color = vec4(0.72,0.66,0.49,1.0);
uniform vec4 inlay : source_color = vec4(0.21,0.41,0.37,1.0);
uniform vec4 vermilion : source_color = vec4(0.73,0.36,0.22,1.0);
uniform vec4 straw : source_color = vec4(0.91,0.76,0.50,1.0);
varying vec3 world_pos;
void vertex(){world_pos = (MODEL_MATRIX * vec4(VERTEX,1.0)).xyz;}
float band(float d,float a,float b){
 float w=max(fwidth(d),0.002);
 return smoothstep(a-w,a+w,d)*(1.0-smoothstep(b-w,b+w,d));
}
void fragment(){
 vec2 p=world_pos.xz;
 vec2 seams=abs(fract((p+vec2(0.41,0.67))/vec2(2.7,1.8))-0.5)*vec2(2.7,1.8);
 float joint=1.0-smoothstep(.003,.009,min(seams.x,seams.y));
 float orbit=length((p-vec2(-1.3,-5.9))*vec2(.76,1.0));
 vec3 c=mix(limestone.rgb,inlay.rgb,band(orbit,5.27,5.60)+band(orbit,5.77,5.82));
 c=mix(c,vermilion.rgb,band(orbit,5.60,5.70));
 c=mix(c,straw.rgb,band(orbit,5.70,5.76));
 float border=min(min(p.x+8.7,10.25-p.x),min(p.y+11.8,2.85-p.y));
 c=mix(c,inlay.rgb,1.0-smoothstep(.01,.035,border-.12));
 c=mix(c,inlay.rgb,band(border,.23,.255));
 float grain=texture(wear,p/3.0).r*.68+texture(wear,p.yx/6.73).r*.32;
 c*=clamp(.70+grain*2.78,.72,1.34);
 ALBEDO=c*(1.0-.20*joint); ROUGHNESS=.7+grain*.35;
}
