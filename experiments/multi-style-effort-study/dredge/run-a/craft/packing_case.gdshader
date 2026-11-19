shader_type spatial;
render_mode specular_disabled;
uniform vec3 case_size = vec3(1.5,1.4,1.5);
uniform vec4 paint : source_color = vec4(.39,.31,.24,1.);
uniform vec4 rail : source_color = vec4(.49,.36,.27,1.);
uniform vec4 stamp : source_color = vec4(.83,.70,.49,1.);
varying vec3 local;
varying vec3 facing;
void vertex(){local=VERTEX; facing=NORMAL;}
float hash21(vec2 a){return fract(sin(dot(a,vec2(71.37,114.1)))*5371.765);}
void fragment(){
 vec3 p=local/case_size+.5;
 bool lid=abs(facing.y)>.5;
 vec2 face=lid?p.xz:(abs(facing.z)>.5?p.xy:p.zy);
 vec2 dims=lid?case_size.xz:(abs(facing.z)>.5?case_size.xy:case_size.zy);
 vec2 uv=face*dims; vec2 border=min(face,1.-face)*dims;
 float board=floor(uv.y/.205); float seam=smoothstep(.012,.026,abs(fract(uv.y/.205+.5)-.5)*.205);
 float ridge=step(min(border.x,border.y),.13);
 float crossbar=step(abs(face.x-face.y)*min(dims.x,dims.y),.064)*(lid?0.:1.);
 float n=hash21(vec2(board,7.));
 vec3 col=paint.rgb*(.81+.34*n)*mix(.48,1.,seam);
 col=mix(col,rail.rgb*(.86+.13*step(.5,fract(uv.x*3.+uv.y*9.))),max(ridge,crossbar));
 float metal=step(border.x,.065)*step(border.y,.16);
 col=mix(col,vec3(.055,.077,.072),metal);
 float nail=1.-smoothstep(.010,.018,length(border-vec2(.036,.06)));
 col=mix(col,vec3(.28,.24,.18),nail);
 vec2 mark=(face-vec2(.68,.55))*dims;
 float chevron=step(abs(mark.y+.65*abs(mark.x)),.012)*step(abs(mark.x),.084);
 col=mix(col,stamp.rgb,chevron*(1.-ridge)*(lid?0.:1.));
 ALBEDO=col;ROUGHNESS=.89;
}
