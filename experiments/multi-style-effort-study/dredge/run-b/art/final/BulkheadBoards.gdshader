shader_type spatial;
render_mode specular_disabled;
uniform vec4 dry : source_color = vec4(.36,.45,.45,1.);
uniform vec4 reed : source_color = vec4(.42,.50,.48,1.);
uniform vec4 wood : source_color = vec4(.52,.44,.34,1.);
varying vec3 place;
varying vec3 wn;
float hash(vec2 p){return fract(sin(dot(p,vec2(127.1,311.7)))*13751.73);}
void vertex(){place=(MODEL_MATRIX*vec4(VERTEX,1.)).xyz;wn=normalize(MODEL_NORMAL_MATRIX*NORMAL);}
void fragment(){
 vec2 uv=vec2(abs(wn.x)>.55?place.z:place.x,place.y);
 float row=floor(uv.y/.134);float panel=floor(uv.x/2.38+.47*mod(row,2.));float y=fract(uv.y/.134);
 float seed=hash(vec2(panel,row));vec3 col=mix(dry.rgb,reed.rgb,seed);
 float scratch=sin(uv.x*4.3+seed*12.+sin(uv.y*143.)*.9)+sin(uv.y*363.+seed*18.);
 col=mix(col,wood.rgb,smoothstep(1.75,1.86,scratch)*.48);
 col*=.74+.26*smoothstep(.015,.084,y);col*=.84+.16*smoothstep(0.,.16,place.y);
 ALBEDO=col;ROUGHNESS=.94;
}
