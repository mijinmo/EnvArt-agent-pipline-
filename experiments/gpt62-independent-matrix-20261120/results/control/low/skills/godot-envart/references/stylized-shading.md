# Reference-driven stylized shading

Use when the reference's visual language needs a shader or when the user explicitly authorizes shader reconstruction. It is a production route alongside asset selection, not a requirement to add effects to every scene.

Identify the visible mechanism before implementation: light/shadow bands, line thickness and edge selection, simplified material response, controlled texture frequency, brush-like variation, fog/depth separation, or water movement. Distinguish actual evidence from a hypothesis about the original game's rendering. Replicate the visible relationship; do not claim to have recovered proprietary shaders.

Build one small, reusable shader on representative imported geometry before applying it to the slice. Keep geometry proportions, major detail, material identity and intended viewing distance in view. An outline cannot fix the wrong architecture; flat shading does not make unrelated kits one family. Preserve source assets and retain useful albedo/normal/alpha information rather than indiscriminately replacing every material with one flat color.

Expose a few meaningful controls such as band thresholds, edge width, palette response, roughness or wave scale. Scope treatment by material role: wood, stone, foliage, metal and water may need different responses. Avoid outlining every triangle, flickering fine noise, dark AO halos and excessive edge thickness. Prefer stable world/object-space detail where appropriate and check near/far views and grazing angles. Flat or toon style still needs readable contact and depth.

Check current official Godot shader/rendering documentation for implementation details. Use the project's intended rendering backend. Preserve camera, light and geometry for a shader comparison. A fair control retains the selected material palette/textures and substitutes an ordinary or continuous shading response; do not deliberately make it gray, dark or broken. If an effect affects shadows, alpha or silhouettes, declare those linked changes. Freeze an animated shader at the same time/phase for still comparisons, then inspect a short actual in-engine motion sample for stability if movement is important.

Capture the same overall/close/transition views of the reopened scenes. Judge whether the shader increases reference fidelity while retaining object readability. Also preserve the first/final full-art iteration separately: material, prop and lighting changes together are not shader-only evidence.

If the shader hurts the result, adjust, limit its coverage or retain the conventional material. Deliver editable shader source and a short parameter/use note with the scene; do not build a generic shader editor or backend framework. Only generalize reusable guidance after seeing actual results.
