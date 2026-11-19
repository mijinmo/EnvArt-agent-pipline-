shader_type spatial;
render_mode diffuse_burley, specular_schlick_ggx;
uniform sampler2D linoleum : source_color, filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D surface_normal : hint_normal, filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D surface_rough : filter_linear_mipmap_anisotropic, repeat_enable;
varying vec3 building_position;
void vertex() { building_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz; }
void fragment() {
    vec2 p = building_position.xz;
    vec2 ft = (p + vec2(0.38, 0.22)) / 0.64;
    vec2 cell = floor(ft);
    vec2 q = p * 0.5;
    float alternate = mod(cell.x + cell.y, 2.0);
    vec2 uv = alternate < 0.5 ? q : vec2(q.y, -q.x);
    vec2 dx = dFdx(q), dy = dFdy(q);
    if (alternate > 0.5) { dx = vec2(dx.y, -dx.x); dy = vec2(dy.y,-dy.x); }
    vec3 original = textureGrad(linoleum, uv, dx, dy).rgb;
    vec2 d = min(fract(ft), 1.0-fract(ft));
    float joint = 1.0-smoothstep(0.0008, max(0.004,0.8*max(fwidth(ft.x), fwidth(ft.y))), min(d.x,d.y));
    float stock = fract(sin(dot(cell,vec2(12.9898,78.233))) * 43758.5453);
    vec3 base = original * vec3(0.88,1.02,1.02) * (0.94+0.10*stock);
    ALBEDO = mix(base, base*0.59, joint*0.72);
    vec3 n = textureGrad(surface_normal, uv, dx, dy).rgb;
    if(alternate > 0.5) { n.xy=vec2(1.0-n.y,n.x); }
    NORMAL_MAP = n;
    NORMAL_MAP_DEPTH = 0.23;
    ROUGHNESS = mix(0.37,0.61,textureGrad(surface_rough,uv,dx,dy).r)+joint*0.06;
    SPECULAR = 0.43;
}
