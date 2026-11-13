from pathlib import Path
import re,json,hashlib,shutil
root=Path('/Users/paul/Developer/EnvArt-agent-pipline-')
src=root/'GodotProject/envart-pipline/demo/controller_lab.tscn'
out=Path('/private/tmp/whitebox-lighting-study-20261113')
s=src.read_text()
blocks=re.findall(r'^\[(?:sub_resource|node)[^\n]*\]\n.*?(?=^\[|\Z)',s,re.M|re.S)
resources=[];nodes=[];bodies=[]
for b in blocks:
 head=b.splitlines()[0]
 if head.startswith('[sub_resource') and any('type="'+t+'"' in head for t in ['ShaderMaterial','StandardMaterial3D','BoxMesh','BoxShape3D']):resources.append(b.rstrip())
 if head.startswith('[node') and ('parent="World"' in head or 'parent="World/' in head):
  if 'type="Label3D"' in head:continue
  nodes.append(b.rstrip())
  if 'type="StaticBody3D"' in head:
   name=re.search(r'name="([^"]+)"',head).group(1)
   props={k:v for k,v in re.findall(r'^(\w+) = (.+)$',b,re.M)}
   bodies.append({'name':name,**props})
header='[gd_scene format=3]\n\n[ext_resource type="Shader" path="res://source/grid.gdshader" id="5_grid"]\n\n'
scene=header+'\n\n'.join(resources)+'\n\n[node name="Whitebox" type="Node3D"]\n\n[node name="World" type="Node3D" parent="."]\n\n'+'\n\n'.join(nodes)+'\n'
(out/'source/whitebox.tscn').write_text(scene)
shutil.copy2(src,out/'source/controller_lab.original.tscn.txt')
shutil.copy2(src.parent/'grid.gdshader',out/'source/grid.gdshader')
manifest={'source':'GodotProject/envart-pipline/demo/controller_lab.tscn','source_sha256':hashlib.sha256(src.read_bytes()).hexdigest(),'whitebox_sha256':hashlib.sha256(scene.encode()).hexdigest(),'extraction':'Exact StaticBody3D, MeshInstance3D and CollisionShape3D node blocks plus original mesh/shape dimensions; removed only UI/controller/labels/lights. No transformations applied.','static_bodies':bodies,'clearance':{'door_width_m':1.2,'door_height_m':2.3,'ramp_width_m':3,'ramp_slope_degrees':18.43495,'floor_extent_m':[32,32]},'scope':'Preserve original world transforms, collision shapes and traversable surfaces. Art may replace visible surface materials; primary route and jump/step envelopes remain open.'}
(out/'source/whitebox_manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
print('Extracted exact bodies',len(bodies),[b['name'] for b in bodies])
