shader_type spatial;
render_mode specular_disabled;
uniform int build = 0; // deck, painted crate, or tall jamb
varying vec3 world;
varying vec3 world_normal;
void vertex() {
 world=(MODEL_MATRIX*vec4(VERTEX,1.)).xyz;
 world_normal=normalize(MODEL_NORMAL_MATRIX*NORMAL);
}
float hash(vec2 p){return fract(sin(dot(p,vec2(91.1,33.7)))*19867.77);}
void fragment(){
 bool top=abs(world_normal.y)>.65;
 vec2 p=top?world.xz:vec2(abs(world_normal.x)>.65?world.z:world.x,world.y);
 if(build==2&&!top) p=p.yx;
 float width=build==0?.25:.22; float row=floor(p.y/width);
 float t=fract(p.y/width); float joint=(p.x+hash(vec2(row,19.))*2.4)/2.85;
 vec2 id=vec2(floor(joint),row); float rand=hash(id);
 float edge=min(min(t,1.-t)*width,min(fract(joint),1.-fract(joint))*2.85);
 vec3 a=build==0?vec3(.083,.088,.080):(build==1?vec3(.045,.093,.100):vec3(.050,.100,.107));
 vec3 b=build==0?vec3(.161,.157,.130):(build==1?vec3(.101,.153,.149):vec3(.107,.170,.156));
 vec3 wood=mix(a,b,.18+.70*rand);
 float split=abs(sin(t*19.+sin(p.x*3.+rand)*.65+rand*4.));
 wood*=1.-.085*(1.-smoothstep(.03,.09,split))*(.35+.65*step(.1,sin(p.x*3.+t)));
 float wear=smoothstep(.85,.96,sin(19.*p.y+sin(p.x*2.3)+3.*rand)*.5+.5);
 wood=mix(wood,wood*1.15,wear);
 wood*=mix(.34,1.,smoothstep(.002,.009+fwidth(edge)*.28,edge));
 ALBEDO=wood; ROUGHNESS=.94;
}
