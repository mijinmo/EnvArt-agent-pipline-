shader_type spatial;
render_mode specular_disabled;
uniform vec4 shale : source_color = vec4(.44,.47,.48,1.);
uniform vec4 ground_edge : source_color = vec4(.60,.59,.54,1.);
varying vec3 point;
varying vec3 direction;
void vertex(){point=VERTEX;direction=NORMAL;}
void fragment(){
 float radius=length(point.yz);
 float ring=.5+.5*sin(radius*780.+.9*sin(atan(point.z,point.y)*3.));
 float grain=fract(sin(dot(floor(point*800.),vec3(48.1,131.2,64.4)))*9731.);
 float val=(.12*grain+.17*ring)*abs(direction.x)+(.38+.09*grain)*(1.-abs(direction.x))+.2*smoothstep(.070,.085,radius);
 ALBEDO=mix(shale.rgb,ground_edge.rgb,val);ROUGHNESS=.94;
}
