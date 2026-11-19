shader_type spatial;
render_mode unshaded, fog_disabled, cull_disabled, depth_test_disabled, depth_draw_never, shadows_disabled;
uniform sampler2D depth_buffer : hint_depth_texture, repeat_disable, filter_nearest;
uniform sampler2D surface_buffer : hint_normal_roughness_texture, repeat_disable, filter_nearest;
uniform float line_opacity : hint_range(0.0,1.0) = 0.78;
void vertex(){POSITION=vec4(VERTEX.xy,1.0,1.0);}
void fragment(){
 vec2 uv=SCREEN_UV;
 float d=texture(depth_buffer,uv).r;
 vec4 view_pos=INV_PROJECTION_MATRIX*vec4(uv*2.0-1.0,d,1.0);
 vec3 world=(INV_VIEW_MATRIX*vec4(view_pos.xyz/view_pos.w,1.0)).xyz;
 vec3 n=texture(surface_buffer,uv).rgb;
 float edge=0.0;
 for(int axis=0;axis<2;axis++){
  vec2 delta=(axis==0?vec2(1.2,0.0):vec2(0.0,1.2))/VIEWPORT_SIZE;
  float da=texture(depth_buffer,uv+delta).r;
  float db=texture(depth_buffer,uv-delta).r;
  float crease=length(texture(surface_buffer,uv+delta).rgb-n);
  edge=max(edge,max(smoothstep(0.13,0.34,crease),smoothstep(0.004,0.018,(da+db-2.0*d)/max(d,0.00001))));
 }
 float zone=step(-6.1,world.x)*step(world.x,10.8)*step(-12.2,world.z)*step(world.z,2.6);
 ALBEDO=vec3(0.008,0.011,0.025);
 ALPHA=edge*line_opacity*zone;
}
