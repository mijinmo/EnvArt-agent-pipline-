shader_type spatial;
uniform sampler2D scan : source_color, filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D rough_scan : filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D normal_scan : hint_normal, filter_linear_mipmap_anisotropic, repeat_enable;
uniform bool floor_finish = false;
varying vec3 world;
varying vec3 face;
void vertex(){
 world=(MODEL_MATRIX*vec4(VERTEX,1.)).xyz;
 face=normalize(MODEL_NORMAL_MATRIX*NORMAL);
}
void fragment(){
 vec3 axis=abs(face);
 vec2 plane=axis.y>0.7?world.xz:(axis.x>axis.z?world.zy:world.xy);
 vec2 uv=plane*0.37;
 float scan_a=texture(scan,uv).g;
 float scan_b=texture(scan,mat2(vec2(0.88,0.48),vec2(-0.48,0.88))*uv*0.41+0.62).g;
 float value=0.105+scan_a*0.47+scan_b*0.63;
 vec2 bay=vec2(2.48,1.86);
 vec2 panel=mod(plane+vec2(0.63,0.26),bay);
 vec2 edge=min(panel,bay-panel);
 float joint=min(edge.x,edge.y);
 float aa=max(fwidth(joint),0.001);
 float seam=1.-smoothstep(0.0015-aa,0.005+aa,joint);
 vec2 tie=abs(panel-bay*0.5)-bay*vec2(0.29,0.32);
 float r=length(tie);
 float recess=1.-smoothstep(0.012,0.021+fwidth(r),r);
 ALBEDO=vec3(0.91,0.86,0.84)*value*(1.-0.34*seam-0.34*recess)*mix(0.85,1.,smoothstep(0.,1.1,world.y));
 ROUGHNESS=0.62+0.23*texture(rough_scan,uv).g;
 vec2 b=(texture(normal_scan,uv).xy*2.-1.)*0.36;
 vec3 n=axis.y>0.7?vec3(b.x,0.,b.y):(axis.x>axis.z?vec3(0.,b.y,b.x):vec3(b.x,b.y,0.));
 NORMAL=normalize(mat3(VIEW_MATRIX)*(face+n));
}
