shader_type spatial;
render_mode unshaded, cull_disabled, depth_test_disabled, depth_draw_never, fog_disabled;
uniform sampler2D depth_map : hint_depth_texture, repeat_disable, filter_nearest;
uniform sampler2D normals : hint_normal_roughness_texture, repeat_disable, filter_nearest;
uniform float strength = 0.62;
void vertex() { POSITION = vec4(VERTEX.xy, 1.0, 1.0); }
void fragment() {
 vec2 uv = SCREEN_UV;
 vec2 px = 1.0/VIEWPORT_SIZE;
 float z = texture(depth_map,uv).r;
 vec3 n = texture(normals,uv).rgb;
 float line = 0.0;
 for (int i=0;i<2;i++) {
  vec2 step_uv = i==0 ? vec2(px.x,0.0) : vec2(0.0,px.y);
  float za=texture(depth_map,uv+step_uv).r;
  float zb=texture(depth_map,uv-step_uv).r;
  float curvature=abs(2.0*z-za-zb)/max(z,0.0001);
  float crease=length(texture(normals,uv+step_uv).rgb-n);
  line=max(line,max(smoothstep(0.009,0.055,curvature),smoothstep(0.14,0.4,crease)));
 }
 ALBEDO=vec3(0.048,0.031,0.038);
 ALPHA=line*strength;
}
