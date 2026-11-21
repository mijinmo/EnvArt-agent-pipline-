#!/usr/bin/env python3
"""Extract the original lab geometry without changing transforms or collision shapes."""
import argparse
import hashlib
import json
import re
import shutil
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / 'GodotProject/envart-pipline/demo/controller_lab.tscn'


def extract(destination):
    text = SOURCE.read_text()
    blocks = re.findall(r'^\[(?:sub_resource|node)[^\n]*\]\n.*?(?=^\[|\Z)', text, re.M | re.S)
    resources, nodes, bodies = [], [], []
    for block in blocks:
        header = block.splitlines()[0]
        if header.startswith('[sub_resource') and any('type="'+t+'"' in header for t in ['ShaderMaterial', 'StandardMaterial3D', 'BoxMesh', 'BoxShape3D']):
            resources.append(block.rstrip())
        if header.startswith('[node') and ('parent="World"' in header or 'parent="World/' in header):
            if 'type="Label3D"' in header:
                continue
            nodes.append(block.rstrip())
            if 'type="StaticBody3D"' in header:
                bodies.append({'name': re.search(r'name="([^"]+)"', header)[1],
                               **dict(re.findall(r'^(\w+) = (.+)$', block, re.M))})
    assert len(bodies) == 17, 'Original whitebox changed; inspect before updating the extraction.'
    scene = '[gd_scene format=3]\n\n[ext_resource type="Shader" path="res://source/grid.gdshader" id="5_grid"]\n\n'
    scene += '\n\n'.join(resources) + '\n\n[node name="Whitebox" type="Node3D"]\n\n[node name="World" type="Node3D" parent="."]\n\n'
    scene += '\n\n'.join(nodes) + '\n'
    destination.mkdir(parents=True, exist_ok=True)
    path = destination / 'whitebox.tscn'
    if path.exists() and path.read_text() != scene:
        raise RuntimeError('Refusing to replace a different whitebox snapshot.')
    path.write_text(scene)
    shutil.copy2(SOURCE.parent / 'grid.gdshader', destination / 'grid.gdshader')
    manifest = {
        'source': str(SOURCE.relative_to(ROOT)),
        'source_sha256': hashlib.sha256(SOURCE.read_bytes()).hexdigest(),
        'whitebox_sha256': hashlib.sha256(path.read_bytes()).hexdigest(),
        'extraction': 'Exact original body, mesh and shape blocks. Removed UI, controllers, labels and light rig only; no transform or shape edits.',
        'static_bodies': bodies,
        'clearance': {'door_width_m': 1.2, 'door_height_m': 2.3, 'ramp_width_m': 3, 'ramp_slope_degrees': 18.43495, 'floor_extent_m': [32, 32]},
        'scope': 'All 17 original bodies, their world transforms, shapes, layers and masks remain. Visual dressing must preserve routes, jump/step access and door clearance.'
    }
    (destination / 'whitebox_manifest.json').write_text(json.dumps(manifest, ensure_ascii=False, indent=2)+'\n')
    print(json.dumps({'bodies': len(bodies), 'source_sha256': manifest['source_sha256'], 'whitebox_sha256': manifest['whitebox_sha256']}))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('destination', type=Path)
    extract(parser.parse_args().destination)
