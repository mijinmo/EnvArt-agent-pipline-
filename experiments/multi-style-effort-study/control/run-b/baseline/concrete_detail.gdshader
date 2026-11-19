shader_type spatial;
uniform sampler2D concrete_color : source_color, filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D concrete_rough : filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D concrete_normal : hint_normal, filter_linear_mipmap_anisotropic, repeat_enable;
uniform vec4 tint : source_color = vec4(0.42,0.40,0.36,1.0);
uniform float normal_strength = 0.48;
varying vec3 wp;
varying vec3 wn;
void vertex(){wp=(MODEL_MATRIX*vec4(VERTEX,1.0)).xyz;wn=normalize(MODEL_NORMAL_MATRIX*NORMAL);}
vec3 tri(sampler2D tex,vec3 p,vec3 w){return texture(tex,p.yz).rgb*w.x+texture(tex,p.xz).rgb*w.y+texture(tex,p.xy).rgb*w.z;}
void fragment(){
 vec3 w=pow(abs(wn),vec3(8.0));w/=max(dot(w,vec3(1.0)),0.001);
 vec3 p=wp*0.5;
 float a=dot(tri(concrete_color,p,w),vec3(0.299,0.587,0.114));
 float b=dot(tri(concrete_color,wp*0.371+vec3(0.37,0.71,0.23),w),vec3(0.299,0.587,0.114));
 float tone=sqrt(max(a*0.65+b*0.35,0.0));
 float base_wear=mix(0.88,1.0,smoothstep(0.1,1.2,wp.y));
 ALBEDO=tint.rgb*(0.53+tone*2.2)*base_wear;
 ROUGHNESS=clamp(0.56+tri(concrete_rough,p,w).r*0.36,0.0,1.0);
 vec3 nx=texture(concrete_normal,p.yz).xyz*2.0-1.0;
 vec3 ny=texture(concrete_normal,p.xz).xyz*2.0-1.0;
 vec3 nz=texture(concrete_normal,p.xy).xyz*2.0-1.0;
 nx.z=sqrt(max(1.0-dot(nx.xy,nx.xy),0.001));ny.z=sqrt(max(1.0-dot(ny.xy,ny.xy),0.001));nz.z=sqrt(max(1.0-dot(nz.xy,nz.xy),0.001));
 nx.xy*=normal_strength;ny.xy*=normal_strength;nz.xy*=normal_strength;
 vec3 n=normalize(vec3(nx.z*sign(wn.x),nx.x,nx.y)*w.x+vec3(ny.x,ny.z*sign(wn.y),ny.y)*w.y+vec3(nz.x,nz.y,nz.z*sign(wn.z))*w.z);
 NORMAL=normalize(mat3(VIEW_MATRIX)*n);
}
