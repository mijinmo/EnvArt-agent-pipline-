# Lighting comparison: baseline, pass 01 and pass 02

> **范围提示（2026-11-17）**：本文件记录的是早期“开放设施”照明 A/B（`art_lit*`，四机位）。当前 `interior_detailed.tscn` 是封闭室内、三机位；这里的照明结论不能直接当作当前室内的验收依据。当前范围见 [ENVIRONMENT.md](ENVIRONMENT.md)。

The intended hierarchy is the records desktop and doorway, with a cooler ramp landing/path cue and restrained open-sky fill. This is an open facility, not an enclosed office. No geometry was added to manufacture interior shadows.

## Fixed A/B conditions

Both use `art_content.tscn`, all identical imported meshes, placements, surface materials and lens emission. Four cameras and 1600×1000 capture settings match. Shadows are on in both. Filmic tone mapping in both; baseline exposure 1.0, pass-01 exposure 1.05, final pass-02 exposure 1.0 globally for all four cameras. No automatic exposure, fog, depth of field or camera-specific grade.

## A — original lab baseline

Directional light rotation (-48,-32,0), energy 1.4, color (1,.92,.8); shadows enabled. Original blue procedural sky with ambient source **3 (SKY)**, energy .65. Stored ambient color (.65,.77,.9) is retained from the original. Engine-probed enum values: background=0, disabled=1, color=2, sky=3. A preliminary unsubmitted baseline accidentally used COLOR=2; all final baseline/whitebox captures were rerendered after restoring source=3. Sky reflection source. No local lights, AO, SSIL, SSR or local reflection probe. This is a usable clear daylight baseline, not a degraded comparison.

## B1 — art_lit_01 / pass 01

- Open warm directional key: rotation (-38,-55,0), energy .7, color (1,.88,.68), 1.5° angular size. Creates coherent wall/prop shadows while reducing flat white daylight.
- Lower blue sky/ambient: color (.48,.61,.69), ambient energy .42. Keeps shadow faces readable without matching key brightness.
- Portal warm practical: (0,2.64,-3.55), energy 4, range 8, 68° cone; associated with the fixed overhead lens. Marks opening and threshold.
- Records worklight: (8.75,3.35,-7.1), energy 5, range 7, 64° cone; corresponds to wall-mounted fixture above work pocket.
- Ramp flood: (-6,3.8,-11.5), energy 5, range 14, 45° cone, cool (.72,.86,1); associated with back-wall flood fixture. Reads as a cool patch on landing and floor approach; its coverage of the entire slope remains weak.
- Desk lamp: near imported lamp head, energy 1.5, range 2, 52° cone, warm; concentrated desktop light.
- Manual warm floor-bounce approximation: omni (7.7,.6,-7), energy .45, range 4, no shadows. This is artistic indirect fill, not physical GI.
- Open-sky fill approximation: omni (-2,5,3), energy 1.1, range 18, shadows on, cool tint. Supports unlit faces from the open side.
- SSAO radius .6/intensity 1.3 improves small contacts. SSIL radius 3/intensity .45 is a screen-space supplement; it is **not full-scene GI**. No SDFGI, VoxelGI or lightmap bake. This small open trial uses explicit manual bounce to avoid a bake stage.
- Local ReflectionProbe centered (6,1.8,-6), size (10,5,12), box projection; SSR enabled. These improve view-dependent specular response, not diffuse bounce.

## Visible result and limits

Compared with A, B makes the office warmer and more localized, gives the landing a separate cool cue, and strengthens near-contact shading. Door side faces and the true opening remain legible. The full overview remains sparse by scope. The ramp itself still lacks a compelling graze and the warm wall has broad fairly even illumination; darker color alone should not be counted as improvement. Cabinet side detail is limited by the source model. Screen-space effects can change across views, and manual bounce has no energy conservation or automatic response to new geometry. These limitations must be judged from the images, not from enabled feature counts.

Method references consulted: [Godot Environment and post-processing](https://docs.godotengine.org/en/stable/tutorials/3d/environment_and_post_processing.html) and [Godot GI comparison](https://docs.godotengine.org/en/stable/tutorials/3d/global_illumination/introduction_to_global_illumination.html).


## B2 — final art_lit / art_lit_02

After root visual review, changed **only lighting/environment**. `art_content.tscn` SHA-256 remains `19ba5b1f67fdfeb9e6481b31e8070200ba2d804b14ec34ef596075d3200d5360`. Cameras and capture settings unchanged. Pass-01 scene and imagery retained.

- Key rotation returns to (-48,-32,0), energy .78, near-neutral color (.96,.98,1), angular size 5° for softer fixture/prop shadows.
- Sky becomes restrained blue-gray; COLOR ambient (.71,.78,.84), energy .38. Exposure 1.0 for every camera, equal to baseline.
- Worklight becomes cool white (.94,.97,1), energy 2.8, source size .6. Portal becomes near-white warm (1,.93,.81), energy 2.5, size .35. Their material lenses remain exactly unchanged, as required by the comparison.
- Warm light is concentrated at the imported desk lamp (energy 1.3). Floor bounce is neutral (.67,.70,.72), energy .65, range 5. Open sky approximation color (.76,.84,.94), energy 1.1, source size 3.
- Back ramp flood reduced to 1.6, 55° cone, aimed toward (-6,1.1,-4), source size .35. Added a broad **open-sky bounce approximation**, at (-7.5,5.5,1.5) toward (-6,.9,-3.4), energy 2.1, range 13, 48°, source size 2. It is an explicit art-directed daylight fill, not a new physical lamp or claimed GI.
- SSAO intensity reduced to 1.0; SSIL/SSR/probe retained. All direct lights still cast shadows; bounce approximation remains non-shadowing as disclosed above.

Observed: white paper/desk, gray painted metal, tan carton and concrete separate more clearly; warm desktop patch is localized. Ramp face has a broader readable gray gradient, rather than a bright blue landing substituting for slope shaping. Wall fixture shadow is softer and less graphic, though still visible. Large source soft shadows show screen-space/dither grain at this capture quality; no denoising or postprocessing of PNGs was performed. The overall remains sparse and the strip fixture attachment is visually underdeveloped; no geometry edits were made to hide these assembly limitations.

Final review limitations: wall/door soft shadows retain visible grid/grain; doorway header has a small bright hotspot; cabinet side remains dark and the full layout is compositionally flat. These are recorded as trial weaknesses; no further iteration or art approval is claimed.
