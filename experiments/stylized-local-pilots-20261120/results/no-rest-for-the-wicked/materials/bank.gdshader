shader_type spatial;
uniform sampler2D soil : source_color, repeat_enable, filter_linear_mipmap_anisotropic;
uniform sampler2D grit : hint_normal, repeat_enable, filter_linear_mipmap_anisotropic;
varying vec3 p;
varying vec3 n;
void vertex(){p=(MODEL_MATRIX*vec4(VERTEX,1.0)).xyz;n=normalize(MODEL_NORMAL_MATRIX*NORMAL);}
void fragment(){
 vec2 uv=p.xz*.46+n.xz*.16;
 vec3 earth=texture(soil,uv).rgb;
 float deposit=texture(soil,p.xz*.126+vec2(.13,.56)).g;
 float bend=.57*sin(p.z*.47)+.24*cos(p.z*1.43);
 float trail=1.0-smoothstep(.68,1.72,abs(p.x-bend)+.25*sin(p.z*2.6)+deposit);
 float grass=smoothstep(.03,.18,deposit+.05*sin(p.x*1.44+p.z*.82))*(1.0-trail);
 float wet=1.0-smoothstep(-1.54,-.55,p.y);
 vec3 dry=earth*mix(vec3(.79,.74,.49),vec3(1.45,1.11,.78),trail);
 ALBEDO=mix(dry,mix(earth*vec3(.70,.93,.30),vec3(.075,.086,.025),.32),grass)*mix(1.0,.48,wet);
 ROUGHNESS=.92-.56*wet;
 vec2 r=texture(grit,uv).rg-.5;
 NORMAL=normalize(NORMAL+mat3(VIEW_MATRIX)*vec3(r.x*.31,0.0,r.y*.31));
}