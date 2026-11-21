shader_type spatial;

uniform sampler2D paving : source_color, repeat_enable, filter_linear_mipmap_anisotropic;
uniform sampler2D litter : source_color, repeat_enable, filter_linear_mipmap_anisotropic;
uniform sampler2D paving_normal : hint_normal, repeat_enable, filter_linear_mipmap_anisotropic;
uniform sampler2D litter_normal : hint_normal, repeat_enable, filter_linear_mipmap_anisotropic;
uniform sampler2D paving_rough : repeat_enable;
uniform sampler2D litter_rough : repeat_enable;
varying vec2 ground;
void vertex() {
    ground = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xz;
}
float hash(vec2 p) {
    return fract(sin(dot(p, vec2(41.13, 73.71))) * 4523.14);
}
float patch(vec2 p) {
    vec2 i = floor(p);
    vec2 f = smoothstep(vec2(0.0), vec2(1.0), fract(p));
    return mix(mix(hash(i),hash(i+vec2(1,0)),f.x),mix(hash(i+vec2(0,1)),hash(i+1.0),f.x),f.y);
}
float lane(vec2 p, vec2 a, vec2 b) {
    vec2 d = b-a;
    return length(p-a-d*clamp(dot(p-a,d)/dot(d,d),0.0,1.0));
}
void fragment() {
    vec2 p = ground;
    float d = min(lane(p,vec2(-1.4,4.0),vec2(0.,-4.4)),lane(p,vec2(0.,-4.4),vec2(2.4,-9.4)));
    d = min(d, lane(p,vec2(-6.0,-0.4), vec2(-0.4,-3.5))+.18);
    d = min(d, lane(p,vec2(1.8,-6.2), vec2(7.7,-5.8))+.1);
    float weather = patch(p*.65)*.8+patch(p*2.1)*.4;
    float mask = 1.-smoothstep(.7,2.25,d-weather+.55);
    vec2 uv = mat2(vec2(.98,.2),vec2(-.2,.98))*p/2.6;
    vec2 fuv = p*.45+vec2(.13*patch(p*.35));
    vec3 soil = texture(litter,fuv).rgb * vec3(.83,.70,.54);
    vec3 stone = texture(paving,uv).rgb * vec3(1.08,.97,.83);
    ALBEDO = mix(soil,stone,mask) * mix(.81,1.22,patch(p*.39));
    NORMAL_MAP = mix(texture(litter_normal,fuv).rgb,texture(paving_normal,uv).rgb,mask);
    NORMAL_MAP_DEPTH = .70;
    ROUGHNESS = mix(texture(litter_rough,fuv).r,texture(paving_rough,uv).r,mask);
}
