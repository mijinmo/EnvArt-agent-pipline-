#!/usr/bin/env python3
"""Install a small CC0 realism experiment; original glTF/PBR files stay intact."""
import concurrent.futures
import hashlib
import json
from pathlib import Path
import subprocess
import urllib.parse

ROOT = Path(__file__).resolve().parents[1] / 'GodotProject/envart-pipline/envart/assets/polyhaven'
MODELS = ['modular_fort_01', 'wooden_crate_01', 'wine_barrel_01', 'wooden_bucket_02', 'wooden_lantern_01', 'small_wooden_table_01', 'wooden_hammer_01', 'fern_02', 'weed_plant_02', 'nettle_plant', 'wooden_crate_02', 'wooden_barrels_01']
TEXTURES = ['cobblestone_floor_03']


def fetch(url, target):
    target.parent.mkdir(parents=True, exist_ok=True)
    subprocess.run(['curl', '-fLsS', '--connect-timeout', '10', '--retry', '1', '--max-time', '45', url, '-o', str(target)], check=True, timeout=110)


def api(endpoint):
    path = Path('/tmp') / ('envart-ph-' + endpoint.replace('/', '-') + '.json')
    if not path.exists():
        fetch('https://api.polyhaven.com/' + endpoint, path)
    return json.loads(path.read_text())


def install(asset, model):
    info = api('info/' + asset)
    files = api('files/' + asset)
    jobs = {}
    if model:
        gltf = files['gltf']['2k']['gltf']
        jobs[asset + '_2k.gltf'] = gltf
        jobs.update(gltf['include'])
        # The public glTF variant references JPEG albedo without alpha.
        # Preserve the separately published leaf cutout for the Godot material.
        if asset in ['fern_02', 'weed_plant_02', 'nettle_plant']:
            opacity = files['Alpha']['2k']['jpg']
            jobs['textures/' + asset + '_alpha_2k.jpg'] = opacity
    else:
        for channel in ['Diffuse', 'nor_gl', 'arm']:
            f = files[channel]['2k']['jpg']
            jobs[Path(urllib.parse.urlparse(f['url']).path).name] = f
    records = []
    for relative, f in jobs.items():
        path = ROOT / asset / relative
        if not path.exists() or hashlib.md5(path.read_bytes()).hexdigest() != f['md5']:
            fetch(f['url'], path)
        data = path.read_bytes()
        assert hashlib.md5(data).hexdigest() == f['md5'], path
        records.append(dict(path=str(path.relative_to(ROOT)), url=f['url'], sha256=hashlib.sha256(data).hexdigest(), bytes=len(data)))
    print('Verified', asset, sum(r['bytes'] for r in records), flush=True)
    return dict(id=asset, source='https://polyhaven.com/a/' + asset, authors=info.get('authors'), license='CC0-1.0', resolution='2k', modifications='No source file changes. Node extraction, placement and material sampling settings are stored in the trial scene.', files=records)


def main():
    ROOT.mkdir(parents=True, exist_ok=True)
    with concurrent.futures.ThreadPoolExecutor(max_workers=3) as executor:
        futures = [executor.submit(install, a, True) for a in MODELS] + [executor.submit(install, a, False) for a in TEXTURES]
        records = [f.result() for f in futures]
    (ROOT / 'manifest.json').write_text(json.dumps(dict(license_source='https://polyhaven.com/license', assets=records), indent=2) + '\n')
    (ROOT / 'LICENSE.txt').write_text('Poly Haven assets — CC0 1.0 Universal\nLicense declaration: https://polyhaven.com/license\nLegal code: https://creativecommons.org/publicdomain/zero/1.0/legalcode\nOriginal authors and download hashes: manifest.json\nCommercial use and redistribution permitted; attribution appreciated.\n')


if __name__ == '__main__':
    main()
