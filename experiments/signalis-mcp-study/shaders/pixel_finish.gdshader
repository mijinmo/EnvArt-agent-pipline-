shader_type canvas_item;
uniform sampler2D screen_tex : hint_screen_texture, repeat_disable, filter_nearest;
uniform float pixel_size = 2.0;
uniform float levels = 48.0;
uniform float dither_strength = 0.22;
uniform float vignette_strength = 0.12;
void fragment(){
 vec2 size=vec2(textureSize(screen_tex,0));vec2 pixel=floor(SCREEN_UV*size/pixel_size);
 vec2 uv=(pixel+0.5)*pixel_size/size;
 vec3 c=texture(screen_tex,uv).rgb;
 float d=mod(pixel.x+mod(pixel.y,2.0)*2.0,4.0)/4.0-0.375;
 c=floor(c*levels+d*dither_strength+0.5)/levels;
 vec2 r=SCREEN_UV*2.0-1.0;c*=1.0-vignette_strength*dot(r,r)*0.5;
 COLOR=vec4(c,1.0);
}
