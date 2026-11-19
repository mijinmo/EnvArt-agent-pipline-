shader_type spatial;
render_mode specular_disabled;
varying vec2 p;
float h(vec2 v){return fract(sin(dot(v,vec2(127.1,311.7)))*43758.545);}
float n(vec2 v){vec2 i=floor(v),f=fract(v); f=f*f*(3.-2.*f);return mix(mix(h(i),h(i+vec2(1,0)),f.x),mix(h(i+vec2(0,1)),h(i+1.),f.x),f.y);}
void vertex(){p=(MODEL_MATRIX*vec4(VERTEX,1)).xz;}
void fragment(){
 float wind=n(p*vec2(.55,1.5)); float rip=abs(sin(19.*p.y+3.5*p.x+wind*5.));
 float trace=(1.-smoothstep(.015,.10,rip))*smoothstep(.63,.76,wind);
 vec2 cell=p*25.; float dotgrain=(1.-smoothstep(.04,.17,length(fract(cell)-vec2(.5))))*step(.92,h(floor(cell)));
 ALBEDO=mix(vec3(.84,.54,.29),vec3(.90,.64,.37),smoothstep(.31,.73,n(p*.82)))-vec3(.14,.13,.11)*(trace+dotgrain);

 vec2 path_vec=normalize(vec2(.94,-.34));
 vec2 offset=p-vec2(-.65,-3.27);
 float walk=dot(offset,path_vec);
 float across=dot(offset,vec2(-path_vec.y,path_vec.x))-.32*sin(walk*.92);
 float pace=floor(walk/.43);
 float side=mod(pace,2.)*2.-1.;
 vec2 sole=vec2(fract(walk/.43)*.43-.215,across-side*(.092+.022*sin(pace*3.6)));
 sole.y+=sole.x*.16*side;
 float toe=length((sole-vec2(.037,.0))/vec2(.099,.057));
 float heel=length((sole+vec2(.090,.0))/vec2(.043,.046));
 float track=(1.-smoothstep(.72,1.12,min(toe,heel)))*smoothstep(.14,.56,n(p*15.5))*
    smoothstep(-.2,.5,walk)*(1.-smoothstep(7.8,8.7,walk));
 ALBEDO*=1.-track*.22;
 ROUGHNESS=1.;
}