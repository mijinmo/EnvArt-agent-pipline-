extends SceneTree
var scene_root: Node3D
var rng=RandomNumberGenerator.new()
var idx=0
var needle_mat:ShaderMaterial
var wood_mat:ShaderMaterial
var grass_mat:ShaderMaterial
func add(n:Node,parent:Node=null):
 if parent==null:parent=scene_root
 parent.add_child(n); n.owner=scene_root; return n
func terrain_y(x:float,z:float)->float:
 var d=abs(x-path_x(z))
 return maxf(0.0,d-2.5)*0.025 + sin(x*0.11)*sin(z*0.12)*0.24 + maxf(0.0,-z-19.0)*0.16 + maxf(0.0,-z-23.0)*0.12*(sin(x*.14)+1.0)
func path_x(z:float)->float:return sin(z*0.12)*2.2+0.5
func model(file:String,pos:Vector3,s:float,rot:float=0.0,label:String=""):
 var n=load(file).instantiate();add(n); scene_root.set_editable_instance(n,true); n.name=(label if label!="" else file.get_file().get_basename())+str(idx);idx+=1
 n.position=pos;n.rotation.y=rot;n.scale=Vector3.ONE*s
 for m in n.find_children("*","MeshInstance3D",true,false):
  for k in m.mesh.get_surface_count():
   var mat=m.mesh.surface_get_material(k)
   if mat is StandardMaterial3D:
    mat=mat.duplicate(); mat.roughness=0.95;mat.metallic=0.0
    mat.vertex_color_use_as_albedo=false
    if "Pine" in file:
     mat.albedo_color=Color("759b88") if "Leaves" in mat.resource_name else Color("b2a087")
     mat.normal_scale=0.3
    elif "Grass" in file:mat.albedo_color=Color("e8c767")
    elif "Rock" in file or "Pebble" in file:mat.albedo_color=Color("b9a17e")
    elif "Fern" in file:mat.albedo_color=Color("82937a")
    else:mat.albedo_color=Color("c4b995")
    m.set_surface_override_material(k,mat)
    if "Pine" in file and k==1:m.set_surface_override_material(k,needle_mat)
    if "Grass" in file:m.set_surface_override_material(k,grass_mat)
    if "survival" in file:
     var wm=wood_mat.duplicate()
     wm.set_shader_parameter("source_tex",mat.albedo_texture)
     m.set_surface_override_material(k,wm)
 return n
func nat(n:String,x:float,z:float,s:float,r:float=0.0):return model("res://assets/nature/"+n+".gltf",Vector3(x,terrain_y(x,z),z),s,r)
func prop(n:String,x:float,z:float,s:float,r:float=0.0,y:float=0.0):return model("res://assets/survival/"+n+".glb",Vector3(x,terrain_y(x,z)+y,z),s,r)
func _initialize():
 rng.seed=383870
 var ns=Shader.new();ns.code='''shader_type spatial;
render_mode cull_disabled;
uniform sampler2D diffuse_tex : source_color, filter_linear_mipmap_anisotropic;
uniform sampler2D alpha_tex : filter_linear_mipmap;
void fragment(){vec2 p=vec2(clamp((UV.x-.16)/.68,0.,1.)*.245,clamp(UV.y,0.,1.)*.46);float a=texture(alpha_tex,p).r;ALPHA=a;ALPHA_SCISSOR_THRESHOLD=.45;vec3 c=texture(diffuse_tex,p).rgb;float l=dot(c,vec3(.3,.59,.11));ALBEDO=mix(vec3(.055,.13,.12),vec3(.25,.39,.29),clamp(l*2.,0.,1.));ROUGHNESS=1.;}
'''
 needle_mat=ShaderMaterial.new();needle_mat.shader=ns;needle_mat.set_shader_parameter("diffuse_tex",load("res://assets/pine_twigs/twig_diff.jpg"));needle_mat.set_shader_parameter("alpha_tex",load("res://assets/pine_twigs/twig_alpha.png"))
 var gs=Shader.new();gs.code='''shader_type spatial;render_mode cull_disabled;
uniform sampler2D source_tex:source_color,filter_linear_mipmap;
void fragment(){vec4 c=texture(source_tex,UV);ALPHA=c.a;ALPHA_SCISSOR_THRESHOLD=.3;float l=dot(c.rgb,vec3(.3,.59,.11));ALBEDO=mix(vec3(.19,.16,.05),vec3(.64,.47,.17),clamp(l*2.,0.,1.));ROUGHNESS=1.;}
'''
 grass_mat=ShaderMaterial.new();grass_mat.shader=gs;grass_mat.set_shader_parameter("source_tex",load("res://assets/nature/Grass.png"))
 var ws=Shader.new();ws.code='''shader_type spatial;
uniform sampler2D source_tex:source_color,filter_nearest;
uniform sampler2D wood_tex:source_color,filter_linear_mipmap;
varying vec3 pos;
void vertex(){pos=VERTEX;}
void fragment(){vec3 c=texture(source_tex,UV).rgb;float iswood=step(c.b*1.18,c.r)*step(c.b*1.12,c.g);vec2 wuv=vec2(fract((pos.x+pos.z)*2.),.04+fract(pos.y*12.)*.22);vec3 grain=texture(wood_tex,wuv).rgb;float g=dot(grain,vec3(.3,.59,.11));vec3 timber=mix(vec3(.13,.105,.075),vec3(.39,.31,.21),clamp(g*1.3,0.,1.));ALBEDO=mix(c*.65,timber,iswood*.9);ROUGHNESS=.88;}
'''
 wood_mat=ShaderMaterial.new();wood_mat.shader=ws;wood_mat.set_shader_parameter("wood_tex",load("res://assets/wood/T_WoodTrim_BaseColor.png"))
 scene_root=Node3D.new();scene_root.name="PineRelay_EditableScene";get_root().add_child(scene_root)
 var ground=MeshInstance3D.new();ground.name="Continuous_ochre_ground_and_path"
 var st=SurfaceTool.new();st.begin(Mesh.PRIMITIVE_TRIANGLES)
 for iz in range(100):
  for ix in range(100):
   var x=ix-50.0;var z=iz-70.0
   for p in [Vector2(x,z),Vector2(x+1,z+1),Vector2(x+1,z),Vector2(x,z),Vector2(x,z+1),Vector2(x+1,z+1)]:
    st.set_uv(p*0.2);st.add_vertex(Vector3(p.x,terrain_y(p.x,p.y)-0.035,p.y))
 st.generate_normals();ground.mesh=st.commit()
 var shader=Shader.new();shader.code='''shader_type spatial;
render_mode cull_disabled;
varying vec3 wp;
void vertex(){wp=(MODEL_MATRIX*vec4(VERTEX,1.0)).xyz;}
float hash(vec2 p){return fract(sin(dot(p,vec2(127.1,311.7)))*43758.5453);}
float n(vec2 p){vec2 i=floor(p),f=fract(p);f=f*f*(3.-2.*f);return mix(mix(hash(i),hash(i+vec2(1,0)),f.x),mix(hash(i+vec2(0,1)),hash(i+vec2(1,1)),f.x),f.y);}
void fragment(){float px=sin(wp.z*.12)*2.2+.5;float d=abs(wp.x-px);float a=n(wp.xz*1.7);float dirt=smoothstep(1.1,2.4,d+(a-.5)*.7);vec3 path=vec3(.31,.20,.105);vec3 edge=vec3(.34,.29,.13);ALBEDO=mix(path,edge,dirt)*(0.82+.28*a+.12*n(wp.xz*17.));ROUGHNESS=.98;}
'''
 var sm=ShaderMaterial.new();sm.shader=shader;ground.material_override=sm;add(ground)
 # Main downloaded architecture: ranger trail maintenance shelter.
 prop("structure-roof",-5.1,-4.2,6.7,0.0)
 prop("structure-canvas",-5.1,-4.2,6.7,0.0)
 for x in [-5.95,-4.3]:
  for z in [-5.0,-3.35]:prop("floor-old",x,z,3.3,0.0,0.02)
 prop("workbench",-5.6,-4.8,4.7,0.2,0.18)
 prop("workbench-grind",-4.1,-4.75,4.0,-0.15,0.18)
 prop("tool-hammer",-5.8,-4.75,2.4,0.3,1.32).rotation.z=1.47
 prop("bottle",-5.5,-5,1.8,0,1.3)
 prop("bottle-large",-5.2,-4.9,1.6,0,1.3)
 prop("box-open",-6.3,-3.4,2.3,0.1,.18)
 prop("bedroll-packed",-6.25,-3.4,2.0,.2,.6)
 prop("box-large",-3.5,-4,2.3,-.06,.1)
 prop("barrel",-3.2,-5.2,2.5,.1)
 prop("barrel-open",-3.0,-3.0,2.3,-.1)
 prop("bucket",-4,-2.9,2.7,.3,.12)
 prop("tool-shovel",-6.65,-3,4.3,0.0).rotation.z=-.18
 prop("resource-planks",-5.9,-2,3.8,1.5)
 prop("resource-planks",-5.8,-2.1,3.3,1.45,.32)
 prop("signpost",-1.65,-2.9,5.0,.1)
 for item in [["PINE RELAY",Vector3(-1.65,2.06,-2.72)],["LOOKOUT  2.4 km",Vector3(-1.65,1.48,-2.65)]]:
  var label=Label3D.new();label.text=item[0];label.font_size=32;label.pixel_size=.003;label.modulate=Color("f2d9a2");label.outline_size=0;label.no_depth_test=false;label.shaded=true;add(label);label.position=item[1];label.rotation.y=.1
 # Natural maintenance story: fallen trunk, trimmed sections, axe, fungi, young growth.
 prop("tree-log",4.5,0.3,4.6,1.1,.5)
 prop("tree-log",6.1,-1.3,3.4,1.4,.35)
 prop("resource-wood",3.3,1.3,3.8,.3)
 prop("resource-wood",3.4,1.2,3.3,.1,.22)
 prop("tool-axe",3.9,.2,3.2,.3,.55).rotation.z=-.5
 for i in 8:
  nat("Mushroom_Common",4+rng.randf_range(-.9,.9),1+rng.randf_range(-.7,.7),rng.randf_range(.17,.32),rng.randf()*TAU)
 for xz in [Vector2(7,-1),Vector2(-8,-1),Vector2(7,-6),Vector2(-7,4),Vector2(11,-10),Vector2(-12,-7)]:
  nat("Rock_Medium_"+str(rng.randi_range(1,3)),xz.x,xz.y,rng.randf_range(1.3,2.3),rng.randf()*TAU)
 # Mature trees frame a legible curved path; no trees in the facility or route.
 for i in 150:
  var x=rng.randf_range(-36,36);var z=rng.randf_range(-58,12)
  if abs(x-path_x(z))<3.8:continue
  if Vector2(x+5.1,z+4.2).length()<7:continue
  if Vector2(x-4.5,z).length()<4:continue
  nat("Pine_"+str(rng.randi_range(1,5)),x,z,rng.randf_range(1.05,2.0),rng.randf()*TAU)
 for q in [Vector3(11,1.7,0),Vector3(-12,2.0,-10),Vector3(8,1.8,-13)]:nat("Pine_2",q.x,q.z,q.y,1.3)
 for i in 4200:
  var x=rng.randf_range(-20,20);var z=rng.randf_range(-27,14);var d=abs(x-path_x(z))
  if d<1.5 or Vector2(x+5.1,z+4.2).length()<2.8:continue
  var s=rng.randf_range(.19,.42)
  nat("Grass_Wispy_Tall" if i%3 else "Grass_Common_Short",x,z,s,rng.randf()*TAU)
 for i in 90:
  var x=rng.randf_range(-15,15);var z=rng.randf_range(-22,9)
  if abs(x-path_x(z))<2.2:continue
  nat("Fern_1",x,z,rng.randf_range(.3,.65),rng.randf()*TAU)
 for i in 100:
  var z=rng.randf_range(-25,14);var x=path_x(z)+rng.randf_range(-2.7,2.7)
  nat("Pebble_Round_1",x,z,rng.randf_range(.06,.2),rng.randf()*TAU)
 var world=WorldEnvironment.new();world.name="Warm_sun_cool_forest_air";var e=Environment.new();world.environment=e
 e.background_mode=Environment.BG_COLOR;e.background_color=Color("668d9c");e.background_energy_multiplier=0.7
 e.ambient_light_source=Environment.AMBIENT_SOURCE_COLOR;e.ambient_light_color=Color("728da8");e.ambient_light_energy=0.52
 e.tonemap_mode=Environment.TONE_MAPPER_FILMIC
 e.fog_enabled=true;e.fog_light_color=Color("839a9b");e.fog_density=.003;e.fog_sky_affect=1.0
 e.ssao_enabled=true;e.ssao_radius=2.3;e.ssao_intensity=1.3
 add(world)
 var sun=DirectionalLight3D.new();sun.name="Late_afternoon_sun";sun.rotation_degrees=Vector3(-38,30,0);sun.light_color=Color("ffd38a");sun.light_energy=1.9;sun.shadow_enabled=true;sun.directional_shadow_max_distance=90;sun.directional_shadow_mode=DirectionalLight3D.SHADOW_PARALLEL_4_SPLITS;add(sun)
 var cams=[["overall",Vector3(10,4.8,14),Vector3(-1.5,2,-6),60],["detail",Vector3(.7,2.5,2.6),Vector3(-4.9,1.5,-4),58],["transition",Vector3(-2,2.1,8),Vector3(4,1.7,-3.5),64]]
 for c in cams:
  var cam=Camera3D.new();cam.name=c[0];add(cam);cam.position=c[1];cam.look_at_from_position(c[1],c[2]);cam.fov=c[3];cam.current=c[0]=="overall";cam.far=180
 scene_root.set_script(load("res://capture.gd"))
 var packed=PackedScene.new();packed.pack(scene_root);ResourceSaver.save(packed,"res://scene.tscn")
 print("BUILT ",idx," asset instances");quit()
