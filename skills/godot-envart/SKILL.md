---
name: godot-envart
description: Build and art-direct asset-based Godot environments from a whitebox or visual brief, including source selection, scene dressing, lighting, and in-engine image review. Use for environment-art production and visual replication, not controller or gameplay-system development.
---

# Godot environment art

Deliver an editable scene that reads as a coherent place from both the main view and nearby inspection views. The output is **environment art**; importing models, counting props, and passing runtime tests are means, not acceptance criteria.

## Establish the visual target

Read the user's references and actually view the images. Describe the intended scene in a few lines: setting, dominant forms, palette, material treatment, focal point, and a small activity that explains its props. Separate the desired visual standard from features present in the reference project. A reference with a player controller does not require implementing a controller.

Respect an existing whitebox's routes, scale and required interaction envelopes. If starting empty, create only enough spatial structure and cameras to produce the environment. Pick one coherent reviewable slice before attempting a whole level or several styles. Do not silently substitute photorealism, low-poly, or retro for the requested direction.

## Choose a coherent asset family

Prefer existing downloadable models for the main architecture and visible props. First choose a compatible architectural kit, then a small supporting family for furnishings, objects and vegetation. Judge candidates by silhouette, scale, surface detail, palette and how they look together—not resolution, polygon count, or the number of available models alone.

Verify the actual downloadable/free contents and commercial-use permission at the source. Record source URL, author, license, chosen files and modifications in a compact manifest; retain supplied licenses. Cache verified downloads. A failed download is not a reason to spend the whole task searching: use bounded timeouts and retries, then pick another suitable source or report the specific missing asset. Do not execute code bundled in asset archives.

Before dressing the scene, inspect a few representative assets in Godot: dimensions and pivot, useful submeshes, UV/material response, transparency, and normals. Downloaded foliage may need a separate alpha map even if its glTF says MASK. Import success does not prove that its leaves look correct. For an entrance, distinguish an actual aperture from a decorative arch or recess.

## Assemble a place, not an asset catalog

Work from large forms toward supporting details:

- Establish complete visible ground, entrance/threshold, boundaries, changes of level, and a readable distant layer. Do not leave a gray floor beneath otherwise dressed architecture.
- Preserve module proportions and texture density. Repeat appropriate-length pieces or adapt a specific asset instead of stretching a large building to fit a small opening.
- Build a few activity-based prop groups: e.g. repair bench with tools and worn parts, supply shelf with staged containers, gate with waiting deliveries. Use supporting surfaces and believable contact, with deliberate gaps and clear routes.
- Add variation through function, grouping, orientation and selective wear. Repeating the same closed crate in a rectangular grid does not create richness. Keep stacking physically supported; random offsets alone are not composition.
- Concentrate plants/debris where they could accumulate. Match their rendering style and leaf/object scale to the architecture. Use procedural work for missing terrain, distribution or simple adapters, not as a substitute for the main visible assets.
- Use a clear key light, readable fill and justified local sources. Fog separates distance; it should not conceal weak construction. Inspect material response under the scene's actual lighting.

If Blender adaptation is materially needed, use the available Blender production workflow for that subtask. Do not add a Blender stage simply to satisfy a pipeline diagram.

## Iterate on real images

Get an in-engine main-view capture early. Keep a few stable views: overall/entrance, prop-group close-up, and ground/transition or background. Inspect the actual captures, identify the largest visible weakness, fix it, and compare the same view again. A console PASS cannot replace looking at the output. Fix unintended blown highlights and unsupported background geometry before adding finer decoration.

Ask of the images: Is the focal point legible? Do the assets belong together? Are the ground and transitions finished? Do props tell a plausible story? Are scale, contact, repetition and material detail convincing at the intended distance? Is the background subordinate? Do not call a result art-approved without the user's judgment.

Technical checking should be proportional: scene loads, required assets render, cameras can show the work. Check a collision or interaction only if this art change could break a user-required one. **Do not build controller suites, benchmark systems, exhaustive collision regressions, or complex review UI for a visual-only task.** Use a static inspection camera or a tiny fly camera when that is sufficient.

For Godot-specific assembly/capture pitfalls, consult [references/godot-delivery.md](references/godot-delivery.md) only as needed.

## Deliver and stop

Provide the editable Godot project/scene, asset provenance, a small set of actual in-engine screenshots and short opening instructions. State remaining visual weaknesses candidly. Keep previous reviewed imagery for comparison when iterating; don't overwrite the only evidence. Follow the project's commit cadence without including caches or unrelated changes.

When explicitly evaluating this skill, give an independent agent only this skill, the visual brief/references, an isolated empty project location, and authorized raw asset sources/cache. Do not hand it the old scene generator or completed environment to copy. Review its actual images, record observed success/failure, and refine only the guidance supported by that trial.
