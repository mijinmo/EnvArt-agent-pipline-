shader_type spatial;
uniform sampler2D panel_paint : source_color, filter_linear_mipmap_anisotropic;
uniform sampler2D panel_normal : hint_normal, filter_linear_mipmap_anisotropic;
uniform sampler2D panel_orm : filter_linear_mipmap_anisotropic;
uniform sampler2D wear_mask : filter_linear_mipmap_anisotropic, repeat_enable;
varying vec2 deck_metres;
void vertex() {
    deck_metres = (MODEL_MATRIX * vec4(VERTEX,1.0)).xz;
}
void fragment() {
    vec3 source = texture(panel_paint, UV).rgb;
    vec3 packed = texture(panel_orm, UV).rgb;
    vec2 wear = texture(wear_mask, deck_metres / vec2(4.91,4.39)).rg;
    float grey = dot(source,vec3(.24,.64,.12));
    ALBEDO = mix(source,vec3(grey * .97,grey,grey*.99),.57) * mix(.81,1.16,wear.r);
    ALBEDO = mix(ALBEDO,ALBEDO*.61,wear.g*.61);
    NORMAL_MAP = texture(panel_normal,UV).rgb;
    NORMAL_MAP_DEPTH = .37;
    ROUGHNESS = .8 + packed.g*.16;
    AO = .49 + .51*packed.r;
    SPECULAR = .16;
}
void light() {
    float ndl = max(dot(NORMAL,LIGHT),0.0);
    float level = mix(ndl, smoothstep(.18,.34,ndl)*.47 + smoothstep(.64,.77,ndl)*.53,.36);
    DIFFUSE_LIGHT += level * ATTENUATION * LIGHT_COLOR / PI;
}
