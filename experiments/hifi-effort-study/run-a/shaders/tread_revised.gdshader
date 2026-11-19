shader_type spatial;
render_mode ambient_light_disabled, specular_disabled;
uniform vec4 steel : source_color = vec4(0.44,0.56,0.63,1);
uniform vec4 recess : source_color = vec4(0.15,0.19,0.29,1);
uniform float slot_length : hint_range(0.08,0.32) = 0.19;
varying vec2 p;
void vertex(){ p=(MODEL_MATRIX*vec4(VERTEX,1.0)).xz; }
float inside(float distance_to_edge){
    float w=max(fwidth(distance_to_edge),0.0004);
    return 1.0-smoothstep(-w,w,distance_to_edge);
}
void fragment(){
    vec2 plank=mod(p+vec2(1.95,1.7),vec2(1.0,2.0));
    vec2 edge=min(plank,vec2(1.0,2.0)-plank);
    float seam=min(edge.x,edge.y);
    float column=floor((p.x+1.95));
    float row=floor((p.y+1.7)/2.0);
    float v=fract(sin(dot(vec2(column,row),vec2(41.31,18.4)))*437.53);
    vec3 paint=steel.rgb*(0.87+0.16*step(0.42,v));
    vec2 rivet=edge-vec2(0.052,0.070);
    paint=mix(paint,recess.rgb,inside(length(rivet)-0.012));
    paint=mix(paint,steel.rgb*1.48,inside(seam-0.012));
    paint=mix(paint,recess.rgb,inside(seam-0.006));
    float row_slot=floor(plank.y/0.25);
    vec2 c=vec2(plank.x-(0.50+0.14*(mod(row_slot,2.0)-0.5)),mod(plank.y,0.25)-0.125);
    float spacing=mod(column+row,3.0);
    float taper=spacing==0.0?0.52:(spacing==1.0?0.79:1.28);
    float slot=length(vec2(max(abs(c.x)-slot_length*taper,0.0),c.y))-0.022;
    float active=1.0-step(0.98,abs(row_slot-3.5)/3.6);
    float plain=step(0.6,spacing)*step(0.86,fract((p.y+1.7)*0.5));
    active*=1.0-plain;
    paint=mix(paint,steel.rgb*1.5,inside(slot-0.007)*active);
    paint=mix(paint,recess.rgb,inside(slot)*active);
    // The access stripe stops at the keep-clear limit. Light and shadow families stretch across adjacent plates.
    float rail=abs(p.x+0.04);
    float route=(1.0-smoothstep(0.020,0.028,abs(rail-0.55)))*step(-8.90,p.y)*step(p.y,-4.35);
    paint=mix(paint,vec3(0.43,0.61,0.46),route);
    float wash=smoothstep(-0.3,0.0,p.x+0.43*p.y+3.50)*(1.0-smoothstep(1.0,1.4,p.x+0.43*p.y+2.45));
    vec3 base=paint*mix(vec3(0.42,0.48,0.63),vec3(0.74,0.82,0.92),wash);
    ALBEDO=paint;
    EMISSION=base;
    ROUGHNESS=1.0;
    SPECULAR=0.0;
}
void light(){
    float k=dot(NORMAL,LIGHT)*ATTENUATION;
    DIFFUSE_LIGHT=max(DIFFUSE_LIGHT,LIGHT_COLOR*0.075*smoothstep(0.23,0.28,k));
}
