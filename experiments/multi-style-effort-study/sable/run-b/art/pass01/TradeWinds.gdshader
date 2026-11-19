shader_type sky;
uniform vec4 horizon : source_color = vec4(0.93,0.95,0.94,1.0);
uniform vec4 zenith : source_color = vec4(0.65,0.89,0.89,1.0);
uniform vec4 cloud_color : source_color = vec4(0.998,0.986,0.949,1.0);
// Irregular banks with long wind-sheared tails. Coordinates are angular.
float bank(vec2 p,vec2 center,vec2 scale,float phase){
 vec2 q=(p-center)/scale;
 float body=max(0.0,1.0-q.x*q.x);
 float top=body*(0.30+0.44*exp(-10.0*pow(q.x-0.19,2.0))+0.20*pow(sin(q.x*10.0+phase),2.0));
 float base=-body*(0.14+0.12*sin(q.x*5.0+phase));
 return (1.0-smoothstep(0.996,1.0,abs(q.x)))*smoothstep(base-0.008,base+0.008,q.y)*(1.0-smoothstep(top-0.008,top+0.008,q.y));
}
void sky(){
 vec2 p=vec2(atan(EYEDIR.x,-EYEDIR.z),EYEDIR.y);
 vec3 base=mix(horizon.rgb,zenith.rgb,smoothstep(-0.07,0.76,p.y));
 float mask=bank(p,vec2(-0.05,0.31),vec2(0.33,0.07),0.4);
 mask=max(mask,bank(p,vec2(1.04,0.258),vec2(0.30,0.065),1.3));
 mask=max(mask,bank(p,vec2(0.82,0.244),vec2(0.15,0.015),0.2));
 mask=max(mask,bank(p,vec2(0.39,0.15),vec2(0.13,0.016),0.2));
 mask=max(mask,bank(p,vec2(1.31,0.46),vec2(0.22,0.085),2.0));
 COLOR=mix(base,cloud_color.rgb,mask*0.95);
}
