shader_type spatial;
render_mode cull_disabled, specular_disabled;

uniform sampler2D stock : source_color, hint_default_white, filter_linear_mipmap_anisotropic;
uniform vec4 enamel : source_color = vec4(0.7,0.8,0.85,1);
uniform vec4 shade : source_color = vec4(0.15,0.17,0.29,1);
uniform sampler2D press_normal : hint_normal, filter_linear_mipmap_anisotropic;
uniform float stock_mix = 0.70;
uniform bool use_normal = false;
uniform float hatch_density = 45.0;
uniform int surface_role = 0; // 1 = steel tread plate, 2 = wall paint
varying vec3 pos;
varying vec3 normal_world;

void vertex(){
	pos=(MODEL_MATRIX*vec4(VERTEX,1.0)).xyz;
	normal_world=normalize(MODEL_NORMAL_MATRIX*NORMAL);
}

void fragment(){
	vec3 n=normalize(normal_world);
	vec3 tex=texture(stock,UV).rgb;
	float value=dot(tex,vec3(0.22,0.65,0.13));
	float mask=smoothstep(0.025,0.29,value);
	vec3 paint=enamel.rgb*mix(1.0,0.57+0.52*mask,stock_mix);
	float axis=dot(n, normalize(vec3(-0.43,0.68,0.58)));
	vec3 die=texture(press_normal,UV).xyz*2.0-1.0;
	float relief=use_normal ? dot(die.xy,vec2(-0.63,0.76)) : 0.0;
	float ground=surface_role==1 ? 1.0 : 0.0;
	paint*=mix(0.75,1.16,mask);
	paint=mix(paint,shade.rgb,0.55*smoothstep(0.12,0.44,-relief));
	paint+=vec3(0.13,0.13,0.12)*smoothstep(0.21,0.44,relief);
	vec3 tone=mix(shade.rgb,paint,0.30+0.43*smoothstep(-0.16,-0.05,axis)+0.27*smoothstep(0.54,0.60,axis));
	vec2 plane=abs(n.y)>0.65 ? pos.xz : (abs(n.x)>0.68 ? pos.zy : pos.xy);
	float line=(plane.x+plane.y*0.51)*hatch_density;
	float hatch=(1.0-smoothstep(0.0,0.15,abs(fract(line)-0.5)))*(1.0-smoothstep(0.20,0.51,fwidth(line)));
	float screen_ink=1.0-smoothstep(-0.1,0.32,axis);
	if(surface_role==1 && n.y>0.75){
		// Draw a pressed slot and its bright lower lip in object-size repeating deck strips.
		vec2 tile=mod(pos.xz+vec2(0.95,1.7),2.0);
		vec2 cell=vec2(mod(pos.x+0.15*floor(pos.z/0.21),0.34)-0.17,mod(pos.z,0.21)-0.105);
		float slot=length(vec2(max(abs(cell.x+cell.y*0.56)-0.058,0.0),cell.y))-0.020;
		float tread=(1.0-smoothstep(0.0,max(fwidth(slot),0.002),slot))*step(0.13,tile.x)*step(tile.x,0.49)*step(0.12,tile.y)*step(tile.y,1.88);
		float lip=(1.0-smoothstep(0.002,0.012,abs(slot-0.012)))*step(0.13,tile.x)*step(tile.x,0.49)*step(0.12,tile.y)*step(tile.y,1.88);
		tone=mix(mix(tone,tone*1.45,lip),shade.rgb,tread*0.85);
		float stripe=abs(mod(pos.x+pos.z*0.48+0.3,5.1)-1.35);
		tone=mix(tone,tone*vec3(0.71,0.74,0.89),1.0-smoothstep(0.53,0.56,stripe));
		screen_ink=max(screen_ink,0.55*(1.0-smoothstep(0.51,0.55,stripe)));
		// Two pilot lamps wash the floor inside their service footprints.
		float reach=pos.z+11.0;
		float footprint=step(0.0,reach)*(1.0-smoothstep(1.65,1.90,reach));
		float spread=0.30+reach*0.29;
		float live=footprint*(1.0-smoothstep(spread,spread+0.06,abs(pos.x-1.25-reach*0.11)));
		float isolated=footprint*(1.0-smoothstep(spread,spread+0.06,abs(pos.x-3.4-reach*0.11)));
		tone=mix(tone,tone*vec3(0.55,1.25,1.05)+vec3(0.0,0.065,0.03),0.85*live);
		tone=mix(tone,tone*vec3(1.25,0.57,0.78)+vec3(0.15,0.01,0.03),0.8*isolated);
	}
	if(surface_role==2 && abs(n.y)<0.5){
		float border=step(1.45,pos.y)*step(pos.y,1.57);
		tone=mix(tone,vec3(0.64,0.046,0.22),border);
	}
	tone=mix(tone,shade.rgb,hatch*screen_ink*0.51);
	ALBEDO=tone;
	EMISSION=tone*0.37;
	ROUGHNESS=0.95;
}
void light(){
	float facing=dot(NORMAL,LIGHT);
	float band=smoothstep(0.34,0.41,facing*ATTENUATION);
	DIFFUSE_LIGHT+=LIGHT_COLOR*(0.035*ATTENUATION+0.24*band)/PI;
}
