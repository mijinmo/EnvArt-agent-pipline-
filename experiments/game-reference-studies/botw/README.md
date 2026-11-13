# Sunlit Wayside Ruins — independent environment art study

Open `project.godot` with Godot 4.7.2. Open `sunlit_ruins.tscn` or press F6/F5. The native scene contains editable architecture, foliage, lighting and three fixed cameras. No controller, UI or gameplay code is included.

Renderer: Forward+ / Metal on macOS. Select `Overall`, `Detail` or `Transition` and enable Current to inspect the other view. Scene scale is meters. The arch is about 5 m high; the walking strip is about 4 m wide.

## Evidence and reproduction

- `captures/round-01/`: original three view captures, retained unchanged.
- `captures/round-02/`: intermediate version rerendered from the parameters used at that time (not an untouched original record).
- `captures/round-03/`: frozen final version, same cameras after root reviewer’s second visual feedback.
- `build.gd`: optional one-shot assembly source; the delivered `.tscn` is already baked and does not depend on running it.
- `capture.gd`: captures the three views via the real graphical viewport.

```sh
/Applications/Godot.app/Contents/MacOS/Godot --path . --rendering-method forward_plus --rendering-driver metal --script res://capture.gd -- round-03
```

Use a graphical environment; headless/dummy renders are not evidence. `RenderingServer.force_draw()` is used so a background window can still capture. Import first if opening a fresh copy. `.godot/` is local cache and not a delivery source; `.uid` and adjacent `.import` sidecars are source-controlled.

## Scope and limitations

This is an asset-first art trial inspired by references, not an IP asset reconstruction or an art-approved match. Downloaded meshes supply all visible architecture, stone paving, loose masonry, pots, vegetation and rocks. Authored geometry is only supporting continuous terrain. Real ambientCG surface maps were added in round 2. The sparse distant meadow, simple trees, low ornament density and modular gate silhouette remain visibly less rich than the reference. No gameplay or collision claim is made.

See `asset_manifest.json`, `candidate_notes.md` and `art_notes.md` for provenance, rejected scope and image-based findings.
