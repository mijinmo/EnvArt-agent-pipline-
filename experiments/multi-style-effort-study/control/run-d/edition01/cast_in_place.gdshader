shader_type spatial;

uniform sampler2D scan : source_color, filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D rough_scan : filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D normal_scan : hint_normal, filter_linear_mipmap_anisotropic, repeat_enable;
varying vec3 world;
varying vec3 face;
void vertex() {
    world = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
    face = normalize(MODEL_NORMAL_MATRIX * NORMAL);
}
void fragment() {
    vec3 a = abs(face);
    bool ceiling = a.y > max(a.x, a.z);
    vec2 p = ceiling ? world.xz : (a.x > a.z ? world.zy : world.xy);
    vec2 uv = p * 0.38;
    vec2 offset_uv = mat2(vec2(0.946,0.324),vec2(-0.324,0.946)) * p * 0.147 + vec2(0.39,0.55);
    float micro = dot(texture(scan,uv).rgb,vec3(0.24,0.63,0.13));
    float broad = dot(texture(scan,offset_uv).rgb,vec3(0.24,0.63,0.13));
    float streak = texture(scan, p * vec2(0.68,0.087) + vec2(0.45,0.11)).r;
    float tone = 0.076 + 0.49 * micro + 0.32 * broad + 0.12 * streak;
    vec2 panel = vec2(2.46,2.8);
    vec2 loc = mod(p + vec2(0.84,0.64),panel);
    vec2 dist = min(loc,panel-loc);
    float aa = max(0.0008, max(fwidth(p.x),fwidth(p.y))*0.66);
    float joint = 1.0-smoothstep(0.0008,0.0028+aa,min(dist.x,dist.y));
    float tie_d = length(dist - vec2(0.225,0.275));
    float tie = 1.0-smoothstep(0.010,0.014+aa,tie_d);
    float edge = 1.0-smoothstep(0.0005,0.002+aa,abs(tie_d-0.014));
    tone *= 1.0 - 0.20 * joint - 0.36 * tie + 0.13 * edge;
    tone *= mix(0.865,1.0,smoothstep(0.14,1.2,world.y));
    ALBEDO = vec3(1.04,1.00,1.035)*tone;
    ROUGHNESS = 0.66 + 0.22*texture(rough_scan,uv).r;
    vec2 bump = (texture(normal_scan,uv).xy*2.0-1.0)*0.40;
    vec3 perturb = ceiling ? vec3(bump.x,0,bump.y) : (a.x>a.z ? vec3(0,bump.y,bump.x) : vec3(bump.x,bump.y,0));
    NORMAL = normalize(mat3(VIEW_MATRIX)*(face+perturb));
}
