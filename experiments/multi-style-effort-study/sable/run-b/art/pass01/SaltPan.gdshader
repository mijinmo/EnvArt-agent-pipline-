shader_type spatial;
render_mode diffuse_lambert,specular_disabled;
uniform vec4 sand : source_color=vec4(0.91,0.64,0.37,1.0);
uniform vec4 drift : source_color=vec4(0.98,0.73,0.46,1.0);
uniform vec4 ochre : source_color=vec4(0.72,0.44,0.29,1.0);
varying vec3 wpos;
float hash(vec2 p){return fract(sin(dot(p,vec2(127.1,311.7)))*43758.5453);}
float noise2(vec2 p){vec2 i=floor(p),f=fract(p);f=f*f*(3.0-2.0*f);return mix(mix(hash(i),hash(i+vec2(1.,0.)),f.x),mix(hash(i+vec2(0.,1.)),hash(i+1.),f.x),f.y);}
void vertex(){wpos=(MODEL_MATRIX*vec4(VERTEX,1.0)).xyz;}
void fragment(){
 vec2 p=wpos.xz;float patch=noise2(p*vec2(.22,.43));float ripple=fract(p.y*1.44+sin(p.x*0.45+p.y*.39)*.4+noise2(p*.6)*.5);
 float width=fwidth(ripple);float wisps=(1.-smoothstep(.012,.028+width,ripple))*smoothstep(.57,.72,patch);
 vec2 s=p*vec2(5.,10.);vec2 cell=floor(s);float seed=hash(cell);vec2 q=fract(s)-vec2(.25+.44*seed,.36+.20*hash(cell+3.));
 float pebble=(1.-smoothstep(.085,.13+length(fwidth(q))*.33,length(q*vec2(.64,1.3))))*step(.79,seed)*smoothstep(.26,.64,patch);
 vec3 bed=mix(sand.rgb,drift.rgb,smoothstep(.42,.68,patch)*.32);ALBEDO=mix(mix(bed,drift.rgb,wisps*.77),ochre.rgb,pebble*.67);ROUGHNESS=1.;
}
