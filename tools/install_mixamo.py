#!/usr/bin/env python3
"""Install personally downloaded Mixamo files; no login/token automation or redistribution."""
import argparse
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
from zipfile import ZipFile

ROOT = Path(__file__).resolve().parents[1]
PROJECT = ROOT / "GodotProject/envart-pipline"
DEST = PROJECT / "characters/mixamo_local"


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--character", type=Path, required=True, help="Mannequin T-pose FBX")
    parser.add_argument("--locomotion", type=Path, required=True, help="Basic Locomotion Pack ZIP, No Character")
    parser.add_argument("--running", type=Path, required=True, help="Running FBX, In Place, Without Skin")
    parser.add_argument("--godot", default="/Applications/Godot.app/Contents/MacOS/Godot")
    parser.add_argument("--stage-only", action="store_true", help="Copy validated files; import/build later")
    args = parser.parse_args()
    files = {"mannequin.fbx": args.character.read_bytes(), "running.fbx": args.running.read_bytes()}
    with ZipFile(args.locomotion) as archive:
        for name in ("idle", "walking", "jump"):
            # Exact entries only. Never extract archive paths into the project.
            files[name + ".fbx"] = archive.read(name + ".fbx")
    for name, content in files.items():
        if not content.startswith(b"Kaydara FBX Binary"):
            raise ValueError(f"{name}: expected Mixamo FBX Binary export")
    DEST.mkdir(parents=True, exist_ok=True)
    records = []
    for name, content in files.items():
        target = DEST / name
        if not target.exists() or target.read_bytes() != content:
            target.write_bytes(content)
        records.append({"file": name, "sha256": hashlib.sha256(content).hexdigest()})
    manifest = {"source": "https://www.mixamo.com/", "character": "Mannequin / Ch36_nonPBR",
                "animations": ["Basic Locomotion Pack: idle, walking, jump", "Running: Running Forward Quickly, In Place"],
                "license_reference": "https://helpx.adobe.com/creative-cloud/faq/mixamo-faq.html",
                "distribution": "Local licensed files excluded from Git; not CC0.", "files": records}
    (DEST / "manifest.json").write_text(json.dumps(manifest, indent=2) + "\n")
    print(f"Staged {len(files)} FBX files in {DEST}")
    if not args.stage_only:
        engine = shutil.which(args.godot) or args.godot
        subprocess.run([engine, "--headless", "--path", str(PROJECT), "--editor", "--import", "--quit"], check=True)
        subprocess.run([engine, "--headless", "--path", str(PROJECT), "--script", "res://characters/build_mixamo.gd"], check=True)
        if not (DEST / "humanoid.scn").is_file():
            raise RuntimeError("Godot did not produce humanoid.scn; check its error output")
        print("Ready: launch the project in Godot.")

if __name__ == "__main__":
    main()
