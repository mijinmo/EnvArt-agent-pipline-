shader_type sky;
uniform sampler2D panorama : source_color, filter_linear, repeat_enable;
void sky() {
    float az = atan(EYEDIR.z,EYEDIR.x)/TAU + .5;
    float height = asin(clamp(EYEDIR.y,-1.0,1.0));
    COLOR=texture(panorama,vec2(az,clamp((.64-height)/.80,.001,.999))).rgb;
}
