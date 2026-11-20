shader_type spatial;
render_mode cull_disabled, specular_disabled, ambient_light_disabled;

uniform vec4 deep_pool : source_color = vec4(0.055, 0.095, 0.130, 1.0);
uniform vec4 open_sky : source_color = vec4(0.200, 0.306, 0.352, 1.0);
uniform vec4 reflected_sun : source_color = vec4(0.965, 0.595, 0.218, 1.0);
uniform float warm_reflection : hint_range(0.0, 2.5) = 1.30;
uniform sampler2D ripple_field : repeat_enable, filter_linear_mipmap_anisotropic;
varying vec3 world_position;

float reflection_patch(vec2 p, vec2 center, vec2 half_width) {
 vec2 delta = (p-center)/half_width;
 return exp(-dot(delta,delta));
}

void vertex() {
 world_position = (MODEL_MATRIX * vec4(VERTEX,1.0)).xyz;
}

void fragment() {
 vec2 p = world_position.xz;
 // Filtered, stationary wave footprints; rotate only the local ripple shapes.
 vec3 samples = texture(ripple_field,p/6.4).rgb;
 vec3 offset_samples = texture(ripple_field,p.yx/9.7+vec2(0.32,0.21)).rgb;
 vec2 bend = vec2(samples.r,offset_samples.r)-0.5;
 vec2 flow = p+0.58*bend;
 float broad = 0.70*samples.r+0.30*offset_samples.r;
 float wave = samples.b;
 float crests = max(samples.g,0.33*offset_samples.g);
 float sky_gaps = smoothstep(0.32,0.77,broad)*(0.53+0.47*wave)+0.24*crests;

 // Shore curve follows the actual cut-bank profile. Leave a dark wet margin.
 float turn = min(1.0,abs(p.x)/2.9);
 float channel_center = (0.54*sin(p.x*0.54)+0.42*sin(p.x*0.98)+0.13*sin(p.x*2.4))*turn;
 float water_edge = 2.81+0.48*sin(p.x*0.66)*turn;
 float offshore = smoothstep(0.03,0.62,water_edge-abs(p.y-channel_center));
 float pier = smoothstep(0.0,0.76,length(vec2(max(abs(p.x)-1.92,0.0),max(abs(p.y)-0.40,0.0))));
 float contact = mix(0.31,1.0,offshore*pier);

 vec2 patch_position = flow+bend*1.3;
 float gaps = reflection_patch(patch_position,vec2(-3.65,-0.42),vec2(1.28,0.85))
            + 0.47*reflection_patch(patch_position,vec2(-5.35,0.9),vec2(1.12,0.57))
            + 0.31*reflection_patch(patch_position,vec2(3.35,0.45),vec2(0.90,0.63));
 float broken_gold = gaps*(0.05+0.95*crests)*smoothstep(0.19,0.71,broad+0.18*wave);
 vec3 reflected = mix(deep_pool.rgb,open_sky.rgb,0.12+0.75*sky_gaps);
 EMISSION = contact*(reflected + reflected_sun.rgb*warm_reflection*broken_gold);
 ALBEDO = mix(deep_pool.rgb,open_sky.rgb,0.21+0.26*sky_gaps)*contact;
 ROUGHNESS = 0.88;
 SPECULAR = 0.0;
}
