shader_type sky;
float h(vec2 p){return fract(sin(dot(p,vec2(127.1,311.7)))*43758.5453);}
float n(vec2 p){vec2 i=floor(p),f=fract(p);f=f*f*(3.0-2.0*f);return mix(mix(h(i),h(i+vec2(1,0)),f.x),mix(h(i+vec2(0,1)),h(i+vec2(1,1)),f.x),f.y);}
void sky(){vec2 p=SCREEN_UV*vec2(5.0,3.0);float v=n(p*2.4)*0.6+n(p*5.0)*0.27+n(p*12.0)*0.13;COLOR=mix(vec3(0.055,0.075,0.08),vec3(0.29,0.34,0.33),smoothstep(0.1,0.85,v));}
