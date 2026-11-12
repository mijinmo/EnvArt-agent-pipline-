"""Copy the curated CC0 subset from author-published Standard ZIPs.

Usage: python3 tools/install_quaternius_sample.py VILLAGE.zip PROPS.zip
No network, executable content, or engine settings are imported.
"""
import hashlib
import json
from pathlib import Path
import sys
from zipfile import ZipFile

DEST = Path(__file__).resolve().parents[1] / "GodotProject/envart-pipline/envart/assets"
VILLAGE = """DoorFrame_Flat_Brick DoorFrame_Flat_WoodDark Wall_UnevenBrick_Door_Flat
Wall_UnevenBrick_Straight Wall_Plaster_Straight Wall_Plaster_WoodGrid
Wall_Plaster_Window_Wide_Flat Window_Wide_Flat1 WindowShutters_Wide_Flat_Open
Floor_UnevenBrick Floor_WoodDark Balcony_Cross_Straight Balcony_Simple_Straight
Corner_Exterior_Wood Corner_Exterior_Brick Roof_Wooden_2x1 Roof_Log
Prop_ExteriorBorder_Straight1 Prop_ExteriorBorder_Straight2 Prop_Support
Prop_Vine1 Prop_Vine2 Prop_Vine4 Prop_Vine5 Prop_Brick1 Prop_Brick2
Prop_Brick3 Prop_Brick4 Prop_Wagon Roof_RoundTile_2x1_Long
Roof_RoundTiles_4x4 Roof_RoundTiles_4x6 Roof_Front_Brick4
Roof_Tower_RoundTiles Prop_Chimney Prop_Chimney2 Door_1_Flat""".split()
PROPS = """Barrel Barrel_Apples Barrel_Holder Crate_Wooden Crate_Metal Bag
FarmCrate_Apple FarmCrate_Carrot FarmCrate_Empty Lantern_Wall Banner_1
Workbench Workbench_Drawers Stool Bench Bucket_Wooden_1 Bucket_Metal
Rope_1 Rope_2 Rope_3 Chain_Coil Peg_Rack Pickaxe_Bronze Axe_Bronze
Stall_Empty Stall_Cart_Empty Pot_1 Pot_1_Lid Vase_2 Vase_4 Vase_Rubble_Medium
Bottle_1 SmallBottle Mug Scroll_1 Scroll_2 Book_5 Pouch_Large CandleStick
Chest_Wood""".split()
NATURE = """Bush_Common Bush_Common_Flowers Grass_Common_Short Grass_Common_Tall
Grass_Wispy_Short Grass_Wispy_Tall Clover_1 Clover_2 Fern_1 Flower_3_Group
Flower_4_Group CommonTree_1 CommonTree_3 Pine_1 Rock_Medium_1 Pebble_Round_1
Pebble_Round_2""".split()


def install(archive, folder, prefix, models, source):
    out = DEST / folder
    out.mkdir(parents=True, exist_ok=True)
    with ZipFile(archive) as z:
        license_text = z.read("License_Standard.txt").decode()
        assert "CC0 1.0" in license_text
        files = {"License_Standard.txt": "License_Standard.txt"}
        for model in models:
            filename = model + ".gltf"
            data = json.loads(z.read(prefix + filename))
            files[filename] = prefix + filename
            for ref in data.get("buffers", []) + data.get("images", []):
                uri = ref.get("uri", "")
                assert uri and "/" not in uri and not uri.startswith("data:")
                files[uri] = prefix + uri
        records = []
        for filename, source_name in sorted(files.items()):
            if source_name not in z.namelist():
                matches = [n for n in z.namelist() if n == "Textures/" + filename]
                assert len(matches) == 1, "Missing dependency: " + source_name
                source_name = matches[0]
            content = z.read(source_name)
            (out / filename).write_bytes(content)
            records.append({"file": filename, "sha256": hashlib.sha256(content).hexdigest()})
    manifest = {"author": "Quaternius", "license": "CC0-1.0", "edition": "Standard / free",
                "source": source, "downloaded": "2026-11-12", "archive_sha256": hashlib.sha256(Path(archive).read_bytes()).hexdigest(),
                "models": models, "files": records, "modifications": "None; original glTF, buffers, and texture dependencies."}
    (out / "manifest.json").write_text(json.dumps(manifest, indent=2) + "\n")
    print(folder, len(models), "models", len(files), "files")


if __name__ == "__main__":
    install(sys.argv[1], "quaternius_village", "glTF/", VILLAGE,
            "https://opengameart.org/content/medieval-village-megakit")
    install(sys.argv[2], "quaternius_props", "Exports/glTF/", PROPS,
            "https://opengameart.org/content/fantasy-props-megakit")
    if len(sys.argv) > 3:
        install(sys.argv[3], "quaternius_nature", "glTF/", NATURE,
                "https://opengameart.org/content/stylized-nature-megakit")
