shader_type spatial;
uniform sampler2D scan : source_color, filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D rough_scan : filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D normal_scan : hint_normal, filter_linear_mipmap_anisotropic, repeat_enable;
uniform bool concourse = false;
varying vec3 w;
void vertex(){ w=(MODEL_MATRIX*vec4(VERTEX,1.)).xyz; }
void fragment(){
 vec2 uv=w.xz*0.66;
 float v=texture(scan,uv).g;
 vec2 div=abs(fract((w.xz+0.78)/2.8+0.5)-0.5)*2.8;
 float distance_to_joint=min(div.x,div.y);
 float joint=1.-smoothstep(0.,0.003+fwidth(distance_to_joint),distance_to_joint);
 ALBEDO=(vec3(0.015,0.017,0.027)+vec3(0.42,0.42,0.47)*pow(v,1.35))*(1.-joint*0.48);
 ROUGHNESS=0.18+texture(rough_scan,uv).g*0.14;
 SPECULAR=0.48;
 vec2 bump=(texture(normal_scan,uv).xy*2.-1.)*0.095;
 if(concourse){
  float yarn=texture(scan,uv*1.9).g;
  ALBEDO=vec3(0.105,0.018,0.031)*(0.71+1.2*yarn);
  ROUGHNESS=0.93;
  SPECULAR=0.14;
 }
 NORMAL=normalize(mat3(VIEW_MATRIX)*vec3(bump.x,1.,bump.y));
}
