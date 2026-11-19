shader_type spatial;
uniform sampler2D veneer : source_color, filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D rough_scan : filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D normal_scan : hint_normal, filter_linear_mipmap_anisotropic, repeat_enable;
varying vec3 w;
varying vec3 f;
void vertex(){w=(MODEL_MATRIX*vec4(VERTEX,1.)).xyz; f=normalize(MODEL_NORMAL_MATRIX*NORMAL);}
void fragment(){
 bool east=abs(f.x)>abs(f.z);
 float along=east?w.z:w.x;
 float leaf=floor(along/0.90);
 vec2 uv=vec2(w.y*0.39,along*0.71+sin(leaf*13.782)*0.15);
 float lum=texture(veneer,uv).g;
 float tone=pow(lum,1.12);
 ALBEDO=vec3(0.046,0.018,0.014)+tone*vec3(0.52,0.25,0.145);
 ROUGHNESS=0.29+texture(rough_scan,uv).r*0.24;
 vec2 bump=(texture(normal_scan,uv).xy*2.-1.)*0.13;
 vec3 profile=east?vec3(0.,bump.x,bump.y):vec3(bump.y,bump.x,0.);
 NORMAL=normalize(mat3(VIEW_MATRIX)*(f+profile));
}
