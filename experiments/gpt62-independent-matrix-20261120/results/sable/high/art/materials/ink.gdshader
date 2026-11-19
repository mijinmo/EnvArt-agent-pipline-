shader_type spatial;
render_mode unshaded, shadows_disabled, cull_disabled, depth_draw_never, depth_test_disabled, fog_disabled;
uniform sampler2D scene_depth : hint_depth_texture, repeat_disable, filter_nearest;
uniform sampler2D normals : hint_normal_roughness_texture, repeat_disable, filter_nearest;
void vertex(){POSITION=vec4(VERTEX.xy,1.,1.);}
void fragment(){
 vec2 uv=SCREEN_UV;vec2 pixel=1./VIEWPORT_SIZE;
 float d=texture(scene_depth,uv).r;vec3 n=texture(normals,uv).rgb;
 float line=0.;
 for(int k=0;k<4;k++){
  vec2 t=k==0?vec2(pixel.x,0.):(k==1?vec2(0.,pixel.y):(k==2?vec2(-pixel.x,0.):vec2(0.,-pixel.y)));
  float dn=texture(scene_depth,uv+t).r;
  float de=(d-dn)/max(d,.00001);
  vec3 nd=texture(normals,uv+t).rgb-n;
  line=max(line,max(smoothstep(.016,.055,de),smoothstep(.14,.41,length(nd))*step(.0,nd.y+nd.x*.31)));
 }
 ALBEDO=vec3(.038,.030,.043);ALPHA=line*.83;
}