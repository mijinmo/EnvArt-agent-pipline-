shader_type spatial;
uniform sampler2D rock_color : source_color, repeat_enable, filter_linear_mipmap_anisotropic;
uniform sampler2D rock_normal : hint_normal, repeat_enable, filter_linear_mipmap_anisotropic;
uniform vec4 hue : source_color = vec4(0.53, 0.49, 0.43, 1.0);
uniform float moss_amount : hint_range(0.0,1.0) = 0.42;
varying vec3 place;
varying vec3 face;
void vertex() {
 place = (MODEL_MATRIX * vec4(VERTEX,1.0)).xyz;
 face = normalize(MODEL_NORMAL_MATRIX * NORMAL);
}
void fragment() {
 vec3 w = pow(abs(normalize(face)),vec3(5.0));
 w /= max(.001,w.x+w.y+w.z);
 vec3 p=place*.87;
 vec3 pat=texture(rock_color,p.zy).rgb*w.x+texture(rock_color,p.xz).rgb*w.y+texture(rock_color,p.xy).rgb*w.z;
 vec3 relief=texture(rock_normal,p.zy).rgb*w.x+texture(rock_normal,p.xz).rgb*w.y+texture(rock_normal,p.xy).rgb*w.z;
 float grain=dot(pat,vec3(.25,.59,.16));
 float patch=sin(place.x*1.9+sin(place.z*1.8))+sin(place.z*3.5+place.y*2.4)+6.0*grain;
 float moss=moss_amount*smoothstep(.7,1.95,patch)*smoothstep(-.08,.78,face.y);
 ALBEDO=mix(hue.rgb*(.24+1.86*grain)*mix(vec3(.93,.87,.79),vec3(1.07,1.05,1.0),smoothstep(.07,.40,grain)),vec3(.085,.096,.032)*(.48+grain),moss);
 ROUGHNESS=mix(.64,.93,moss);
 NORMAL=normalize(NORMAL + (VIEW_MATRIX*vec4(vec3((relief.r-.5)*.17,0.0,(relief.g-.5)*.17),0.0)).xyz);
}