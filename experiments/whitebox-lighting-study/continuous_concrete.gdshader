shader_type spatial;
uniform sampler2D concrete_color : source_color, filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D concrete_rough : filter_linear_mipmap_anisotropic, repeat_enable;
uniform vec4 tint : source_color = vec4(0.48,0.49,0.47,1.0);
varying vec3 wp;
varying vec3 wn;
void vertex(){wp=(MODEL_MATRIX*vec4(VERTEX,1.0)).xyz;wn=normalize(MODEL_NORMAL_MATRIX*NORMAL);}
vec3 tri(sampler2D tex, vec3 p, vec3 w){return texture(tex,p.yz).rgb*w.x+texture(tex,p.xz).rgb*w.y+texture(tex,p.xy).rgb*w.z;}
void fragment(){
 vec3 w=pow(abs(wn),vec3(8.0));w/=max(dot(w,vec3(1.0)),0.001);
 vec3 c=tri(concrete_color,wp*0.5,w);
 vec3 d=tri(concrete_color,wp*0.371+vec3(0.37,0.71,0.23),w);
 float tone=dot(c*0.65+d*0.35,vec3(0.299,0.587,0.114));
 ALBEDO=tint.rgb*(0.80+sqrt(tone)*0.65);
 ROUGHNESS=clamp(0.77+tri(concrete_rough,wp*0.5,w).r*0.13,0.0,1.0);
 float micro=dot(c,vec3(0.333));
 NORMAL=normalize(NORMAL+vec3(-dFdx(micro),-dFdy(micro),0.0)*0.18);
}
