# Asset search and selection — 2026-11-13

This is an independent study built in an empty directory. No old scene, scene builder, controller or trial code was read. Only authorized raw asset archives were reused.

| Candidate / verified source | Actual free scope and commercial use | Selection |
|---|---|---|
| [Quaternius Stylized Nature MegaKit](https://quaternius.com/packs/stylizednaturemegakit.html) | CC0. Included Standard license states 68/116 models; full Pro and engine shader Source editions are paid. | Used raw cached Standard ZIP `/private/tmp/stylized-nature-standard.zip`: five Pine variants, terrain rocks, ferns, grasses, mushrooms and pebbles. Free package includes branching trunks and leaf cards, but round-01 proves its scalloped foliage is too coarse for Firewatch. No paid preview or shader was represented as delivered. |
| [Kenney Survival Kit 2.0](https://kenney.nl/assets/survival-kit) / [creator upload on OpenGameArt](https://opengameart.org/content/survival-kit) | CC0, 80 models. Creator explicitly permits commercial use. | New retrieval this trial. Official ZIP returned HTTP 403 after one retry; switched to author's OGA upload, downloaded 1.9 MB successfully. Chosen shelter, flooring, workbenches, tools, containers, signpost and fallen logs. Strong functional variety, but geometry is comparatively simplified. |
| [Poly Haven Fir Tree 01](https://polyhaven.com/a/fir_tree_01) | CC0; realistic needle and branch structure. Default 4K Blender configuration is about 956.6 MB. Independent API check found 1K glTF with dependencies about 487.4 MB and 1K FBX about 270.8 MB; neither is a small download. | Rejected for first pass: very large and photographically textured; would need deliberate palette adaptation and alpha validation, not wholesale realistic-scene substitution. |
| [Grab3D Pine Tree](https://grab3d.com/models/nature/pine-tree/) | Source claims CC0, GLB 927 KB. | Rejected: described as mint-green wavy tiers/cozy stylization, incompatible with reference's needle silhouette. Not downloaded. |
| [Toolbench low-poly forest kit](https://toolbenchdev.com/gamedev/cc0-game-assets/low-poly-forest-kit/) | Source claims CC0 and 24 models. | Rejected: total 5,372 triangles across pack and simplified pine form would worsen branch/needle fidelity. Not downloaded. |

Download actually used: https://opengameart.org/sites/default/files/kenney_survival-kit.zip . Archive is outside delivery; supplied license retained in `assets/licenses`.

Materials retain original UVs and alpha textures. Round 01 intended material overrides did not persist because imported instances were not marked editable. Round 02 fixes this with `set_editable_instance`, and reopened native-scene captures now verify the overrides. Terrain alone is authored as a continuous mesh with a world-space path blend. Main architecture, furniture, plants, rocks and props are downloaded models.

## Round 02 bounded texture replacement

Source leaf RGB is flat green with a broad source silhouette; the original glTF UVs and alpha were present. A second problem was found: override edits on imported child meshes were not serialized until the parent instance was marked editable. Round 01 images are left intact as evidence of both failures.

Retrieved only [Pine Tree 01](https://polyhaven.com/a/pine_tree_01) `twig_diff` 1K JPG (510,932 bytes) and `twig_alpha` 1K PNG (351,928 bytes), via https://api.polyhaven.com/files/pine_tree_01 . The [publisher license](https://polyhaven.com/license) is CC0 and allows commercial reuse. No large pine model was downloaded. Original files are retained in `assets/pine_twigs`.

Inspected both maps separately. The atlas includes pinecones and isolated needles outside the left-upper twig island. The shader maps the measured Quaternius leaf U range ~0.169–0.821 and V range ~0–1 specifically into atlas U 0–0.245, V 0–0.46, so unrelated atlas regions are excluded. It reads alpha's red channel explicitly (not diffuse RGB as an alpha surrogate), uses a .45 cutout, and reduces photo-color variation into a restrained forest palette. This is a limited material adaptation: some near branches remain long/coarse, and it does not claim the silhouette fidelity of the original Firewatch assets.

Also reused a wood trim texture from authorized cached Quaternius Medieval Village Standard raw assets, with the supplied CC0 license retained. Only the wood-grain strip is sampled. Its luminance modulates muted timber tones; the source Kenney palette still distinguishes metal/container regions.
