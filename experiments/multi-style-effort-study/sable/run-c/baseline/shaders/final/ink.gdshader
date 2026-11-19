shader_type spatial;
render_mode unshaded, cull_disabled, depth_draw_never, depth_test_disabled, fog_disabled;
uniform sampler2D scene_color : hint_screen_texture, repeat_disable, filter_nearest;
uniform sampler2D scene_depth : hint_depth_texture, repeat_disable, filter_nearest;
uniform sampler2D scene_normal : hint_normal_roughness_texture, repeat_disable, filter_nearest;
uniform float ink_opacity : hint_range(0.,1.) = 0.70;
uniform float stroke_px : hint_range(0.5,2.) = 1.15;
uniform vec4 ink_color : source_color = vec4(0.20,0.15,0.20,1.0);
void vertex(){POSITION=vec4(VERTEX.xy,1.,1.);}
void fragment(){
 vec2 uv=SCREEN_UV;
 float z=texture(scene_depth,uv).r;
 vec3 normal=texture(scene_normal,uv).rgb;
 float edge=0.;
 for(int i=0;i<4;i++){
  vec2 v=i==0?vec2(1,0):i==1?vec2(0,1):i==2?vec2(-1,0):vec2(0,-1);
  vec2 q=uv+v*stroke_px/VIEWPORT_SIZE;
  float neighbor=texture(scene_depth,q).r;
  float step_depth=smoothstep(0.015,0.08,(z-neighbor)/max(z,0.00001));
  float crease=smoothstep(0.26,0.55,length(normal-texture(scene_normal,q).rgb))*0.56;
  edge=max(edge,max(step_depth,crease));
 }
 ALBEDO=mix(texture(scene_color,uv).rgb,ink_color.rgb,edge*ink_opacity);
}
