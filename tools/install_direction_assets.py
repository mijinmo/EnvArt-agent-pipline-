"""Install curated CC0 sources for the second art direction comparison.

Reads only author-distributed archives; does not execute bundled project code.
Usage: python3 tools/install_direction_assets.py /tmp
"""
import hashlib
import json
import sys
from pathlib import Path
from zipfile import ZipFile

DEST = Path(__file__).resolve().parents[1] / 'GodotProject/envart-pipline/envart/assets'
DUNGEON = '''wall wall_cracked wall_broken wall_arched wall_archedwindow_gated
wall_archedwindow_open wall_pillar wall_doorway wall_doorway_sides
wall_half wall_endcap wall_sloped column pillar pillar_decorated
barrier barrier_half barrier_column floor_tile_large floor_tile_small
floor_tile_small_broken_A floor_tile_small_broken_B floor_tile_small_decorated
floor_tile_small_weeds_A floor_tile_large_rocks floor_tile_grate
floor_wood_large_dark rubble_half rubble_large torch_mounted torch_lit
candle candle_lit candle_triple candle_melted sword_shield sword_shield_broken
banner_patternC_brown banner_thin_brown chest barrel_large_decorated
barrel_small_stack box_stacked crates_stacked shelf_large shelf_small_candles
shelves table_long_broken table_medium stool bottle_A_brown bottle_B_green
plate_stack keyring_hanging trunk_large_A trunk_medium_B'''.split()

SCIFI = """Column_Astra Column_MetalSupport Column_Pipes Column_Round Column_Simple
Door_Frame_Square Door_Frame_SquareTall Platform_3Plates Platform_CenterPlate
Platform_DarkPlates Platform_Metal Platform_Metal2 Platform_Simple Platform_Squares
Prop_AccessPoint Prop_Barrel_Large Prop_Cable_1 Prop_Cable_3 Prop_Chest Prop_Clamp
Prop_Computer Prop_Crate3 Prop_Crate4 Prop_Fan_Small Prop_Fan_Small_Propeller
Prop_ItemHolder Prop_Light_Corner Prop_Light_Floor Prop_Light_Small Prop_Light_Wide
Prop_PipeHolder Prop_Rail_2 Prop_Rail_3 Prop_Rail_4 Prop_Vent_Big Prop_Vent_Small
Prop_Vent_Wide BottomMetal_Straight BottomSimple_Straight ShortWall_AccentStrip_Straight
ShortWall_WhitePlate2_Straight ShortWall_MetalPlates_Straight TopAstra_Straight
TopCables_Straight TopCables_Straight_Hanging TopSimple_Straight TopWindow_Straight
WallAstra_Straight WallAstra_Straight_Flat WallAstra_Straight_Window WallBand_Straight
WallWindow_Straight Decal_0 Decal_7 Decal_Line_Straight Decal_Dashes""".split()
SCIFI_PROPS = """Prop_Ammo_Closed Prop_Ammo_Small Prop_Barrel1 Prop_Barrel2_Closed
Prop_Chair Prop_Crate Prop_Crate_Large Prop_Crate_Tarp Prop_Crate_Tarp_Large
Prop_Desk_L Prop_Desk_Medium Prop_Desk_Small Prop_HealthPack Prop_HealthPack_Tube
Prop_KeyCard Prop_Locker Prop_Mug Prop_SatelliteDish Prop_Shelves_ThinShort
Prop_Shelves_ThinTall Prop_Shelves_WideShort Prop_Shelves_WideTall Prop_Syringe""".split()


def install_scifi(folder, pack, models, primary, extras):
    out=DEST/pack; out.mkdir(parents=True,exist_ok=True)
    archives=[ZipFile(folder/n) for n in [primary]+extras]
    z=archives[0]
    license_name=next(n for n in z.namelist() if n.endswith('License_Standard.txt'))
    assert b'CC0 1.0' in z.read(license_name)
    files={'License_Standard.txt':(z,license_name)}
    for model in models:
        paths=[n for n in z.namelist() if n.endswith('/'+model+'.gltf')]
        assert len(paths)==1, model
        path=paths[0]; data=json.loads(z.read(path)); files[model+'.gltf']=(z,path)
        for ref in data.get('images',[])+data.get('buffers',[]):
            uri=ref['uri']; assert '/' not in uri and not uri.startswith('data:')
            local=str(Path(path).parent/uri)
            match=next(((a,local) for a in archives if local in a.namelist()),None)
            if not match:
                match=next(((a,n) for a in archives for n in a.namelist() if n.endswith('/'+uri)),None)
            assert match,uri
            files[uri]=match
    if pack=='quaternius_scifi':
        for name in ['T_Trim_01_BaseColor.png','T_Trim_02_BaseColor_Blue.png','T_Trim_01_Emissive.png']:
            files[name]=next((z,n) for n in z.namelist() if n.endswith('/'+name))
    records=[]
    for name,(archive,path) in sorted(files.items()):
        data=archive.read(path);(out/name).write_bytes(data)
        records.append({'file':name,'archive':Path(archive.filename).name,'archive_path':path,'sha256':sha(data)})
    record={'author':'Quaternius','license':'CC0-1.0','edition':'Standard / free',
            'source':'https://opengameart.org/content/'+('modular-sci-fi-megakit' if pack=='quaternius_scifi' else 'sci-fi-essentials-kit'),
            'downloaded':'2026-11-12','archives':{Path(a.filename).name:sha(Path(a.filename).read_bytes()) for a in archives},
            'models':models,'files':records,'modifications':'Original source bytes unchanged. Shader and material adaptation lives in scene builders.'}
    (out/'manifest.json').write_text(json.dumps(record,indent=2)+'\n')
    for a in archives:a.close()
    print(pack,len(models),'models',len(files),'files')


def sha(data):
    return hashlib.sha256(data).hexdigest()


def install_kaykit(archive):
    out = DEST / 'kaykit_dungeon'
    out.mkdir(parents=True, exist_ok=True)
    with ZipFile(archive) as z:
        names = z.namelist()
        license_name = next(n for n in names if n.endswith('/Assets/LICENSE.txt'))
        license_data = z.read(license_name)
        assert b'CC0' in license_data
        files = [('License.txt', license_name)]
        for model in DUNGEON:
            matches = [n for n in names if '/gltf/' in n and n.split('/')[-1] in [model+'.glb',model+'.gltf.glb']]
            assert len(matches) == 1, model
            files.append((model+'.glb', matches[0]))
        records=[]
        for filename, source in files:
            data=z.read(source); (out/filename).write_bytes(data)
            records.append({'file':filename,'archive_path':source,'sha256':sha(data)})
    record={'author':'Kay Lousberg / KayKit','license':'CC0-1.0','edition':'Dungeon Remastered 1.0 / author GitHub free assets',
            'source':'https://github.com/KayKit-Game-Assets/KayKit-Dungeon-Remastered-1.0',
            'downloaded':'2026-11-12','archive_sha256':sha(Path(archive).read_bytes()),'models':DUNGEON,'files':records,
            'modifications':'Only normalized .gltf.glb file names to .glb; model bytes unchanged.'}
    (out/'manifest.json').write_text(json.dumps(record,indent=2)+'\n')
    print(out.name,len(DUNGEON),'models')

if __name__=='__main__':
    folder=Path(sys.argv[1])
    install_kaykit(folder/'kaykit-dungeon.zip')
    install_scifi(folder,'quaternius_scifi',SCIFI,'scifi.zip',[])
    install_scifi(folder,'quaternius_scifi_props',SCIFI_PROPS,'scifi-props.zip',['scifi-textures.zip','scifi.zip'])
