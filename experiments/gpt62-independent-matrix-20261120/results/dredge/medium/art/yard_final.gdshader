shader_type spatial;
varying vec3 world;
void vertex(){world=(MODEL_MATRIX*vec4(VERTEX,1.0)).xyz;}
float hash(vec2 p){return fract(sin(dot(p,vec2(127.1,311.7)))*4375.5453);}
float noise2(vec2 p){vec2 i=floor(p),f=fract(p); f=f*f*(3.0-2.0*f);return mix(mix(hash(i),hash(i+vec2(1,0)),f.x),mix(hash(i+vec2(0,1)),hash(i+1.0),f.x),f.y);}
void fragment(){
 vec2 p=world.xz*vec2(1.75,3.2);
 p+=.12*vec2(noise2(p*.8),noise2(p*1.1));p.x+=.5*mod(floor(p.y),2.);
 vec2 cell=floor(p),f=fract(p);
 float value=hash(cell);
 vec2 edge=min(f,1.-f);
 float seam=smoothstep(.012,.053,min(edge.x,edge.y)+.027*noise2(p*8.));
 vec3 stone=mix(vec3(.101,.106,.105),vec3(.185,.183,.163),value);
 float tide=noise2(world.xz*.63);
 stone*=.90+.12*step(.52,noise2(p*2.))+.09*tide;
 ALBEDO=mix(vec3(.079,.082,.08),stone,seam);ROUGHNESS=.81+.17*tide;
}