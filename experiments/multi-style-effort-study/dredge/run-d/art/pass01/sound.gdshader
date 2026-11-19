shader_type spatial;
render_mode unshaded;
uniform float phase=0.36;
uniform vec4 deep : source_color=vec4(.19,.315,.345,1.);
uniform vec4 shoal : source_color=vec4(.30,.39,.41,1.);
varying vec3 p;
void vertex(){p=(MODEL_MATRIX*vec4(VERTEX,1.)).xyz;}
float hash(vec2 q){return fract(sin(dot(q,vec2(27.12,341.3)))*17123.7);}
void fragment(){
 vec2 q=p.xz; float d=length(q-CAMERA_POSITION_WORLD.xz);
 vec2 ring=vec2(q.x*.098+q.y*.027,q.y*.87);
 ring.x+=floor(ring.y)*.35;
 float cell=hash(floor(ring)); vec2 f=fract(ring);
 float stroke=step(.034, f.y)*step(f.y,.15+.17*cell)*step(abs(f.x-.5),.17+.3*cell);
 float wave=sin(q.y*.129+q.x*.050+phase+sin(q.x*.060));
 vec3 base=mix(deep.rgb,shoal.rgb,.32+.22*step(.06,wave)+.24*smoothstep(24.,120.,d));
 float trail=exp(-abs((q.x+4.3)-(q.y+.05)*(-.259))* .09);
 base=mix(base,vec3(.61,.31,.18),trail*(.17+.60*stroke)*smoothstep(13.,58.,d));
 ALBEDO=base+vec3(.085,.068,.063)*stroke*step(.53,cell);
}
