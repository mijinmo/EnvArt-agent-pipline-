shader_type spatial;
uniform sampler2D stone : source_color, filter_linear_mipmap_anisotropic, repeat_enable;
varying vec3 world;
void vertex(){world=(MODEL_MATRIX*vec4(VERTEX,1.0)).xyz;}
float noise(vec2 p){return fract(sin(dot(p,vec2(12.9898,78.233)))*43758.5453);}
void fragment(){
 vec2 p=world.xz;
 float lane=1.0-smoothstep(1.2,2.1,abs(p.y-1.0+0.15*sin(p.x)));
 float gate=(1.0-smoothstep(0.8,1.3,abs(p.x)))*step(-9.0,p.y)*(1.0-smoothstep(1.0,2.0,p.y));
 float ramp=1.0-smoothstep(1.35,1.8,abs(p.x+6.0));
 float path=max(lane,max(gate,ramp*step(-8.0,p.y)*step(p.y,2.0)));
 vec3 dirt=mix(vec3(0.16,0.20,0.13),vec3(0.29,0.31,0.17),0.5+0.24*sin(p.x*1.2)*sin(p.y*1.5));
 vec3 cobble=texture(stone,p*0.32).rgb*vec3(0.72,0.79,0.70);
 ALBEDO=mix(dirt,cobble,path);
 ROUGHNESS=0.91;
}
