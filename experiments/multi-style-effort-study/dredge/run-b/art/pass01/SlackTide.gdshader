shader_type spatial;
render_mode unshaded;
uniform vec4 channel : source_color = vec4(.19,.32,.35,1.);
uniform vec4 shallows : source_color = vec4(.31,.39,.38,1.);
uniform vec4 reflected_sky : source_color = vec4(.51,.39,.33,1.);
uniform vec4 silver : source_color = vec4(.62,.62,.52,1.);
uniform float phase = .36;
varying vec3 place;
float hash(vec2 p){return fract(sin(dot(p,vec2(93.4,155.7)))*15674.43);}
float facet(vec2 p){
 vec2 i=floor(p),f=fract(p);
 float a=hash(i),b=hash(i+vec2(1.,0.)),c=hash(i+vec2(0.,1.)),d=hash(i+1.);
 return f.x+f.y<1.?a+(b-a)*f.x+(c-a)*f.y:d+(b-d)*(1.-f.y)+(c-d)*(1.-f.x);
}
void vertex(){place=(MODEL_MATRIX*vec4(VERTEX,1.)).xyz;}
void fragment(){
 vec2 q=place.xz+vec2(.3,phase);
 float basin=facet(q*vec2(.073,.16));
 float swell=facet(q*vec2(.17,.95)+vec2(basin,phase));
 float dash=facet(q*vec2(.48,2.01));
 vec3 water=mix(channel.rgb,shallows.rgb,.12+.42*smoothstep(.41,.44,basin));
 float faraway=smoothstep(24.,120.,length(q-CAMERA_POSITION_WORLD.xz));
 water=mix(water,reflected_sky.rgb,faraway*(.32+.34*smoothstep(.52,.58,swell)));
 water=mix(water,silver.rgb,.42*smoothstep(.69,.75,swell)*smoothstep(.54,.62,dash)*(1.-.5*faraway));
 ALBEDO=water;
}
