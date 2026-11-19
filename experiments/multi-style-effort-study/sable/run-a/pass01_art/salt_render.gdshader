shader_type spatial;
render_mode specular_disabled;
uniform vec4 plaster : source_color = vec4(0.85, 0.68, 0.50, 1.0);
uniform vec4 plinth : source_color = vec4(0.71, 0.47, 0.38, 1.0);
uniform vec4 repair : source_color = vec4(0.90, 0.72, 0.53, 1.0);
varying vec3 world;
varying vec3 face;
float hashed(vec2 p) {return fract(sin(dot(p, vec2(12.989, 78.233))) * 43758.545);}
void vertex() {
 world=(MODEL_MATRIX*vec4(VERTEX,1.0)).xyz;
 face=abs(MODEL_NORMAL_MATRIX*NORMAL);
}
void fragment() {
 float s=face.x>face.z?world.z:world.x;
 float y=world.y;
 float lip=0.35+0.11*sin(s*0.45)+0.035*sin(s*2.8);
 vec3 paint=mix(plinth.rgb,plaster.rgb,smoothstep(lip,lip+0.014,y));
 float row=floor(y*2.3);
 float cut=fract(y*2.3+0.025*sin(s*2.0));
 float cell=floor((s+0.9*row)/1.6);
 float patch=hashed(vec2(cell,row));
 if(cut>0.96 && patch>0.72 && fract(s/1.6+row*0.5625)<0.67) {paint*=0.86;}
 if(patch>0.86 && cut>0.12 && cut<0.22 && fract(s/1.6+row*0.5625)<0.28) {paint=mix(paint,repair.rgb,0.43);}
 ALBEDO=paint; ROUGHNESS=1.0;
}