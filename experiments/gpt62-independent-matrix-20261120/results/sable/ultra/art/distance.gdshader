shader_type sky;

float ridge(float a) {
    return 0.018 + 0.014 * sin(3.0*a+0.7) + 0.009*cos(12.0*a)
        + 0.042 * smoothstep(0.46,0.51,sin(4.0*a+1.2)+0.32*cos(10.0*a))
        + 0.009*smoothstep(0.42,0.53,cos(19.0*a));
}
void sky() {
    float a = atan(EYEDIR.z, EYEDIR.x);
    float h = EYEDIR.y;
    vec3 sky_col = mix(vec3(.79,.88,.825),vec3(.39,.77,.81),smoothstep(-.05,.6,h));
    float r = ridge(a);
    vec3 hill = mix(vec3(.63,.57,.57),vec3(.73,.67,.66),smoothstep(.0,.14,h));
    hill *= 1.0-.05*(1.0-smoothstep(.0002,.0012,abs(h-r+.014+.002*sin(13.0*a))));
    vec3 col = mix(hill,sky_col,smoothstep(r-.0006,r+.0006,h));
    float sand = -.008 + .013*sin(5.0*a)+.004*cos(13.0*a);
    COLOR = mix(vec3(.80,.61,.41),col,smoothstep(sand-.0008,sand+.0008,h));
}
