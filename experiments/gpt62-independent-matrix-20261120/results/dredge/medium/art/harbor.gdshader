shader_type spatial;
uniform sampler2D palette : source_color, filter_nearest;
uniform int surface_role = 0;
varying vec3 world;
void vertex(){world=(MODEL_MATRIX*vec4(VERTEX,1.)).xyz;}
float h(vec2 p){return fract(sin(dot(p,vec2(43.17,83.41)))*4375.37);}
float noise2(vec2 p){vec2 i=floor(p),f=fract(p);f=f*f*(3.-2.*f);return mix(mix(h(i),h(i+vec2(1,0)),f.x),mix(h(i+vec2(0,1)),h(i+1.),f.x),f.y);}
void fragment(){
 vec3 base=texture(palette,UV).rgb;
 float l=dot(base,vec3(.28,.55,.17));
 vec3 wood=vec3(.38,.27,.195)*(l*1.43+.12);
 vec3 col=wood;
 if(surface_role==1 && base.b>base.r*.84){col=mix(vec3(.27,.25,.21),vec3(.82,.70,.51),smoothstep(.02,.65,l));}
 if(surface_role==2){col=mix(vec3(.14,.044,.042),vec3(.36,.105,.082),smoothstep(.03,.68,l));}
 if(surface_role==3 && base.b>base.r*.87){col=vec3(.095,.125,.128)*(l+.65);}
 vec2 uv=vec2(world.z+world.x,world.y);
 if(abs(NORMAL.y)>.8){uv=world.xz;}
 float grain=noise2(uv*vec2(3.,48.)+3.*noise2(uv*vec2(.7,4.)));
 float wash=noise2(uv*vec2(2.,3.));
 col*=.91+.09*step(.48,wash)+.06*step(.64,grain)-.07*step(.78,grain);
 ALBEDO=col;ROUGHNESS=.88;
}