# Godot assembly and visual delivery notes

Use when assembling imported 3D assets or capturing a Godot result. These are implementation traps, not a mandatory test plan.

- Treat a source scene as a collection when it contains separate variants laid out in a grid. Instantiate the intended submesh/variant, not the entire catalog.
- Compute bounds through the descendant transforms. Choose whether an anchor means bottom-center, a module connector or the original author pivot. Rotation and nonuniform scale do not commute: normally rotate the frame, then apply local scale (`R * S`). Ground objects using the rotated bounds and the actual support/terrain height.
- For packed scenes, set ownership on authored nodes. Keep imported scene ownership intact; re-owning every imported descendant can duplicate geometry. Use editable instances/material overrides for adjustments. Ensure generated resources survive reopening the project.
- Retain original UVs and meaningful PBR channels. Verify source color vs data maps, OpenGL normal orientation, ARM channel assignment, alpha cutout and mipmaps. Excessively strong normals, stretched UVs and mismatched texture density can look worse than a simpler coherent material family.
- Keep camera positions/FOV stable across iterations. Captures should come from the Godot viewport, not a generated illustration. On macOS, a covered background window can stop presentation; after settling the scene, `RenderingServer.force_draw()` before `get_viewport().get_texture().get_image().save_png(...)` avoids waiting indefinitely for a presented frame.
- Run actual screenshots using a graphical rendering backend. Some RenderingServer/MultiMesh data is not retained by headless/dummy builds; use a graphics backend when baking such data. Headless import/parse checks alone cannot establish visual correctness.
- Watch for missing resources, shader errors and magenta/opaque placeholder surfaces. Only inspect logs for the task at hand; do not turn the delivery into a general engine compatibility exercise.
- Deliver source assets, scene resources, licenses and Godot sidecar `.uid`/`.import` files. Exclude `.godot/`, raw download archives, logs and temporary renders unless explicitly requested. A capture script or scene builder is useful only if it helps reproduce this output; it need not become a framework.
