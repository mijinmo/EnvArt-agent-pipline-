# Pine Relay — Firewatch reference study

Open `project.godot` in Godot **4.7.2** and press **F5**. The default is a static overall view; no controller or gameplay/UI is included. `scene.tscn` is an editable native scene with imported asset instances, saved material overrides, continuous ground, lights and three named Camera3D nodes (`overall`, `detail`, `transition`). Switch a camera's Current property for inspection.

`captures/round-01/` and `captures/round-02/` contain frozen actual engine screenshots. The current native scene is round 02. The first-round builder is retained only as provenance; do not run it over the final scene. The scene is an independent study, not a reproduction of Firewatch content. See `art_notes.md` for observed weaknesses and `candidate_notes.md` for search decisions, free-versus-paid scope and failed download fallback. `asset_manifest.json` records hashes and sources; source license files are in `assets/licenses/`.

To reproduce captures into a **new** directory:

```sh
/Applications/Godot.app/Contents/MacOS/Godot --path /absolute/path/to/firewatch --rendering-method forward_plus --rendering-driver metal -- --capture --out=res://captures/new-review
```

`capture.gd` calls `RenderingServer.force_draw()` to handle covered macOS windows. `build.gd` documents authored placement and can rebuild the native scene; it does not fetch assets or execute archive scripts. Imported source models and textures are preserved. Keep `.uid` and adjacent `.import` sidecars; omit `.godot/` and raw ZIPs when packaging.

Validation: successful headless import and native-scene creation; successful Metal Forward+ scene load and all three captures; each image visually inspected. No unrelated runtime suites were added. The final round was reloaded from the saved native scene before capture, verifying persistent material overrides.
