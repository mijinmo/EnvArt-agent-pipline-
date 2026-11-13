shader_type spatial;
uniform sampler2D stone_color : source_color,filter_linear_mipmap,repeat_enable;
uniform sampler2D stone_roughness : filter_linear_mipmap,repeat_enable;
uniform vec4 base_tint : source_color=vec4(.57,.59,.55,1);
varying vec3 wp;
varying vec3 wn;
void vertex(){wp=(MODEL_MATRIX*vec4(VERTEX,1.0)).xyz;wn=normalize(MODEL_NORMAL_MATRIX*NORMAL);}
void fragment(){
 vec3 w=pow(abs(wn),vec3(4));w/=w.x+w.y+w.z;
 vec3 c=texture(stone_color,wp.zy*.55).rgb*w.x+texture(stone_color,wp.xz*.55).rgb*w.y+texture(stone_color,wp.xy*.55).rgb*w.z;
 float gray=dot(c,vec3(.3,.59,.11));
 ALBEDO=base_tint.rgb*(.60+gray*1.7);
 ROUGHNESS=.82+.16*texture(stone_roughness,wp.xy*.55).r;
}
