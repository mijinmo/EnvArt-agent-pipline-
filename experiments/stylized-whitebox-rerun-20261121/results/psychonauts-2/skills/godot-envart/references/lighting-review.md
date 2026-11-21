# Lighting as environment art

Use for a dedicated lighting iteration or capability evaluation. Judge the rendered image, not the number of lights or enabled effects.

Start from the established indoor/outdoor/semi-open brief and actual enclosure. An interior reference needs the intended ceiling, boundaries and openings accounted for; open-sky lighting on a roofless test layout cannot validate matching that interior. If adding a missing enclosure is authorized, establish it before freezing the lighting comparison and include it in both A/B scenes.

## Look for visible evidence

- **Hierarchy and navigation:** key activity, threshold and path are legible; brightest areas support the intended focus. A clear silhouette is useful, but crushing every shadow is not depth.
- **Source logic and form:** sun/openings/practicals explain direction, shadow length and softness. Broad fill supports shaded forms without flattening the whole scene. Deliberate stylization is acceptable when it serves the reference.
- **Contact and scale:** furniture feet, wall/floor junctions, foliage roots and small props sit convincingly on their supports. Watch for detached shadows, excessive AO halos and leaking light.
- **Material response:** stone, painted metal, wood and paper remain distinguishable; highlights retain useful detail. Do not change every roughness value to compensate for an unbalanced light rig.
- **Depth and consistency:** foreground, activity area and distant layer separate at more than one camera angle. Fog should recede into distance instead of washing out nearby props. Check doorway/ramp readability as well as the hero view.

## Isolate a lighting comparison

Keep geometry, asset placement, material parameters (including emissive surfaces), camera transforms/FOV and capture settings fixed. Save a shared art scene and separate baseline/refined light environments when convenient. A baseline should represent the existing usable setup, not a deliberately degraded all-shadows-off image. Disclose changes to exposure, tone mapping, ambient/sky light, local sources, GI, reflection and fog. If geometry or materials change, freeze a new shared baseline before claiming a lighting-only comparison.

Use a few already-needed art views: overview, threshold or ramp, and prop close-up. Capture the saved/reopened scene, with auto-exposure disabled or consistently controlled. Retain both versions. State which improvements are visible and what remains weak; a darker or more colorful version is not automatically better. Do not infer the isolated contribution of lighting from earlier iterations that also changed assets and materials.

## Godot choices

Select an indirect-light solution that fits the actual scene. Uniform ambient light, art-directed bounce lights, real-time GI and baked lightmaps have different costs and limitations; a small test does not require a GI bake or a new framework. SSIL is a screen-space supplement, not a replacement for full-scene bounced lighting; off-screen geometry and view changes can affect screen-space results. Reflection treatment and diffuse bounce are different concerns. Check the current engine's [environment documentation](https://docs.godotengine.org/en/stable/tutorials/3d/environment_and_post_processing.html) and [GI comparison](https://docs.godotengine.org/en/stable/tutorials/3d/global_illumination/introduction_to_global_illumination.html) when choosing a method.

For fixed-whitebox work, do not add light-blocking walls or ceilings inside required space merely to force a prettier shot. Declare any added structure, keep it identical in the lighting A/B, and review it against the whitebox constraints. Validation remains limited to visible correctness, saved-scene delivery and directly affected constraints.
