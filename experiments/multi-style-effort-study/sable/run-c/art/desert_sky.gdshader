shader_type sky;
void sky(){
 vec3 d=EYEDIR; float y=max(d.y,0.0);
 vec3 base=mix(vec3(.84,.96,.91),vec3(.34,.84,.87),smoothstep(0.,.58,y));
 vec2 uv=d.xz/max(.018,y); float f=sin(uv.x*.6+uv.y*.24)+.65*sin(uv.x*.42-uv.y*1.7)+.26*sin(uv.x*1.4+uv.y*4.6);
 float clouds=smoothstep(1.46,1.49,f)*smoothstep(.018,.09,y);
 COLOR=mix(base,vec3(.98,.97,.88),clouds*.88);
}
