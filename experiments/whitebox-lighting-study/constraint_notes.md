# Whitebox constraints

Source: original `GodotProject/envart-pipline/demo/controller_lab.tscn`, retained as `source/controller_lab.original.tscn.txt`. Root supplied an extraction containing exactly 17 StaticBody3D bodies with their meshes/collisions. `source/whitebox.tscn` is never edited.

Source whitebox SHA-256: `a309dc9fa677d83b490c0223b8cdb62bba718db7ef1b7b812c4a7ebe43373d26`.

The art copy preserves every original transform, BoxMesh size, collision transform, BoxShape size, layer and mask. The independent reload check passed 17/17; see `constraint_check.txt`. Surface materials are the only alterations to these bodies. Door aperture remains x=[-0.6,+0.6], height 2.3 m. Ramp is 3 m wide, 18.43495 degrees. Floor remains 32×32 m. Steps, jump platforms, spawn pad, wall boundaries and passage routes are unchanged.

All additions are independently editable under Art_Added:

- Door jamb face strips x=[-0.7,-0.61] and [0.61,0.7], outside the 1.2 m aperture; header face is above y=2.3. No leaf or threshold inserted in aperture.
- Ramp marks are surface paint outside its x=[-7.5,-4.5] width. No rail, plank, prop or new ramp deck. Landing/ramp seam is original geometry and remains visible.
- Furniture is concentrated along the inside face of the existing east wall, x approximately 7.29–9.56, z approximately -10.63–-5.27. No props occupy doorway/ramp/steps/jump platforms. Chair stays beside the desk within the marked activity pocket.
- Thin back/east wall joint and skirting surfaces are faithful overlays; step marks are on front faces, not on tread surfaces.
- No walls, ceilings, background buildings, roof slabs or new collisions. Door lamp housing spans y=2.60–2.68, above the portal outside its aperture. East wall worklight is y=3.267–3.405 over the furnishing pocket; bracket attaches to original wall top. Ramp flood is mounted on the back wall y≈3.8. These small fixtures are not overhead architecture or route blockers.
- Imported desk/lamp/chair/carton/cabinet bounds are normalized and bottom-centered. Cabinet height 1.634169 m; carton/file supports set to that top. Desk top 0.748125 m. Submillimetre placement tolerances remain.

A/B refer to the identical `art_content.tscn`; all materials including lens emission remain shared. Camera position, rotation, FOV and viewport dimensions are identical. Lighting-only changes are listed separately.
