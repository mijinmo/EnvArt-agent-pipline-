shader_type spatial;
varying vec3 p;
uniform vec4 sand:source_color=vec4(0.93,0.65,0.35,1);
float hash(vec2 q){return fract(sin(dot(q,vec2(37.1,75.8)))*43758.5453);}
void vertex(){p=(MODEL_MATRIX*vec4(VERTEX,1)).xyz;}
void fragment(){
 vec2 uv=p.xz; vec2 cell=floor(uv*4.3); float h=hash(cell);
 vec2 grain=fract(uv*4.3)-vec2(h,hash(cell+17.1))*0.68-0.14;
 float nib=(1.-smoothstep(.42,.85,length(grain*vec2(4.8,17.))))*step(.62,h);
 float wind=sin(uv.x*3.1+uv.y*7.8+sin(uv.x*1.5)*.7);
 float ripple=smoothstep(.93,.99,wind)*smoothstep(.55,.9,sin(uv.x*.91+cos(uv.y*1.2)))*.08;
 ALBEDO=sand.rgb*(1.-.28*nib-ripple);ROUGHNESS=1.;
}
