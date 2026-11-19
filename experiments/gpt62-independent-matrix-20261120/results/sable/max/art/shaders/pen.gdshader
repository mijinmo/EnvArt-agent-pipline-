shader_type spatial;
render_mode unshaded, fog_disabled, cull_disabled, depth_draw_never, depth_test_disabled, shadows_disabled;
uniform sampler2D scene_color : hint_screen_texture, repeat_disable, filter_nearest;
uniform sampler2D scene_depth : hint_depth_texture, repeat_disable, filter_nearest;
uniform sampler2D scene_normal : hint_normal_roughness_texture, repeat_disable, filter_nearest;
uniform float density : hint_range(0.0,1.0) = 0.72;
float eye_distance(vec2 p, mat4 inv_proj) {
    vec4 eye = inv_proj * vec4(p*2.0-1.0,texture(scene_depth,p).x,1.0);
    return -eye.z/eye.w;
}
void vertex() { POSITION = vec4(VERTEX.xy,1.0,1.0); }
void fragment() {
    vec2 px = 1.0 / VIEWPORT_SIZE;
    vec2 uv = SCREEN_UV;
    float d = eye_distance(uv,INV_PROJECTION_MATRIX);
    vec3 n = normalize(texture(scene_normal,uv).xyz*2.0-1.0);
    float silhouette = 0.0;
    float corner = 0.0;
    for(int i=0;i<4;i++) {
        vec2 delta = i==0 ? vec2(px.x,0.) : i==1 ? vec2(-px.x,0.) : i==2 ? vec2(0.,px.y) : vec2(0.,-px.y);
        float od = eye_distance(uv+delta,INV_PROJECTION_MATRIX);
        silhouette = max(silhouette,smoothstep(.012,.036,(od-d)/max(d,.1)));
        vec3 nn = normalize(texture(scene_normal,uv+delta).xyz*2.0-1.0);
        float fold = (1.0-dot(n,nn))*smoothstep(-.1,.19,nn.z-n.z);
        corner=max(corner,smoothstep(.16,.56,fold));
    }
    float mark = max(silhouette,.54*corner)*(1.0-smoothstep(27.,65.,d));
    vec3 c=texture(scene_color,uv).rgb;
    ALBEDO=mix(c,c*.16+vec3(.022,.016,.024),density*mark);
}
