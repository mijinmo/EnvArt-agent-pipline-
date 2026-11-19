shader_type spatial;
render_mode unshaded, cull_disabled, depth_draw_never, depth_test_disabled, fog_disabled, shadows_disabled;
uniform sampler2D scene_depth : hint_depth_texture, repeat_disable, filter_nearest;
uniform sampler2D scene_normal : hint_normal_roughness_texture, repeat_disable, filter_nearest;
uniform sampler2D scene_colour : hint_screen_texture, repeat_disable, filter_nearest;
void vertex() { POSITION=vec4(VERTEX.xy,1.,1.); }
float distance_at(vec2 uv,mat4 inv) {
 float d=textureLod(scene_depth,uv,0.).r;
 vec4 v=inv*vec4(uv*2.-1.,d,1.);
 return -v.z/v.w;
}
void fragment() {
 vec2 t=1.2/VIEWPORT_SIZE, uv=SCREEN_UV;
 float centre=distance_at(uv,INV_PROJECTION_MATRIX);
 vec3 n=textureLod(scene_normal,uv,0.).rgb*2.-1.;
 float depth_edge=0., crease=0.;
 for(int i=0;i<4;i++){
  vec2 p=uv+(i==0?vec2(t.x,0.):i==1?vec2(-t.x,0.):i==2?vec2(0.,t.y):vec2(0.,-t.y));
  float z=distance_at(p,INV_PROJECTION_MATRIX);
  vec3 nn=textureLod(scene_normal,p,0.).rgb*2.-1.;
  depth_edge=max(depth_edge,(z-centre)/max(.6,centre));
  crease=max(crease,(1.-dot(n,nn))*smoothstep(-.25,.32,n.z-nn.z));
 }
 float outline=max(smoothstep(.013,.037,depth_edge),smoothstep(.21,.53,crease)*.78);
 vec3 src=textureLod(scene_colour,uv,0.).rgb;
 float y=dot(src,vec3(.2126,.7152,.0722));
 vec2 xy=FRAGCOORD.xy; vec2 screen=mat2(vec2(.943,.333),vec2(-.333,.943))*xy/4.75;
 float r=length(fract(screen)-.5);
 float shade=1.-smoothstep(.04,.26,y);
 float dots=(1.-smoothstep(.15,.35,r))*.29*shade;
 ALBEDO=vec3(.009,.012,.026);
 ALPHA=clamp(outline*.87+dots,0.,.92);
}
