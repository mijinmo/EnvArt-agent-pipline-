# Pump Lane — Dishonored reference study

Open `project.godot` with Godot 4.7.2. The native editable scene is `study.tscn`; press F6/F5 for the static overall view. All materials, mesh instances, lights and the Overall / Detail / Transition cameras are saved in the native scene. There is no controller or review UI.

Renderer: Metal Forward+, MSAA 4x and TAA. The study uses freshly downloaded CC0 warehouses, industrial modules and props; licenses and exact provenance are under `assets/licenses/` and `asset_manifest.json`. `candidate_notes.md` records rejected candidates and actual free scope.

Reproduce the fixed captures (on a graphical macOS session):

```sh
/Applications/Godot.app/Contents/MacOS/Godot --path . --rendering-method forward_plus --rendering-driver metal --resolution 1440x900 --script capture.gd -- review-copy
```

Choose a new round directory to preserve reviewed images. `build.gd` is a scene authoring convenience, not required when opening the delivered native scene. It reconstructs authored adapters and selected imported mesh variants; running it overwrites study.tscn.

This is an independent small environment-art trial, not a Dishonored recreation or an approved visual baseline. See art_notes.md for the actual limitations.

Review comparisons are retained in `captures/round-01/` and `captures/round-02/`. Round 02 is the delivered native scene state. The unchanged fixed cameras make before/after comparison direct.
