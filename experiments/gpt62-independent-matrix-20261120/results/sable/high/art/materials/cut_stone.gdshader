shader_type spatial;
render_mode specular_disabled;
uniform sampler2D atlas : source_color;
uniform vec4 stone : source_color = vec4(0.93,0.77,0.59,1.0);
varying vec3 world;
varying vec3 face;
float hash(vec2 v){return fract(sin(dot(v,vec2(127.1,311.7)))*43758.5453);}
float noise2(vec2 p){
 vec2 i=floor(p),f=fract(p); f=f*f*(3.0-2.0*f);
 return mix(mix(hash(i),hash(i+vec2(1,0)),f.x),mix(hash(i+vec2(0,1)),hash(i+1.0),f.x),f.y);
}
void vertex(){ world=(MODEL_MATRIX*vec4(VERTEX,1)).xyz; face=MODEL_NORMAL_MATRIX*NORMAL; }
void fragment(){
 vec2 p=abs(face.y)>0.7?world.xz:vec2(abs(face.x)>abs(face.z)?world.z:world.x,world.y);
 vec2 stone_uv=p+vec2(noise2(p*6.0)*0.009,noise2(p*3.8)*0.014);
 float row=floor(stone_uv.y/0.43);
 vec2 grid=vec2(stone_uv.x/0.92+row*0.49+0.14*hash(vec2(row)),stone_uv.y/0.43);
 vec2 c=fract(grid);float id=hash(floor(grid));
 vec2 d=min(c,1.0-c)*vec2(0.92,0.43);
 float edge=min(d.x,d.y);
 float chip=noise2(p*36.0)*0.012+smoothstep(0.6,0.92,noise2(p*12.0))*0.022;
 float seam=smoothstep(chip,chip+max(fwidth(edge),0.002),edge);
 float bevel=1.0-smoothstep(0.016,0.034,edge);
 float pit=step(0.82,noise2(p*vec2(90.0,134.0)))*step(0.52,noise2(p*12.0));
 float tone=texture(atlas,UV).r;
 ALBEDO=stone.rgb*mix(vec3(0.59,0.53,0.46),vec3(0.94+id*0.07+tone*0.07+bevel*0.12),seam)*(1.0-pit*0.22);
 ROUGHNESS=1.0;
}