---
name: godot-envart
description: Art-direct and build asset-based Godot environments from whiteboxes or visual briefs, including reference discovery, asset selection, local production, and in-engine visual iteration. Use for environment-art production and visual replication, not controller or gameplay-system development.
---

# Godot environment art

Deliver an editable environment, supported by actual engine images. Treat reference selection, art direction, asset decisions, production and review as one connected workflow. Downloads, prop counts and technical passes do not establish art quality.

## Enter at the right stage

Read the existing task entry (such as `ENVIRONMENT.md`), current scene and relevant evidence before acting. Recover user constraints, current work, open issues and the last reviewed pass. Do not restart discovery for a narrow edit unless its premise has failed. For a new job or a pipeline handoff, use [production-loop.md](references/production-loop.md) for stage outputs, return paths and record ownership.

The working loop is:

**Scope → reference selection → art direction → asset auditions → local production → engine review → delivery and scoped reuse.**

These are decisions and artifacts, not seven approval requests. Advance autonomously within the user's authorized scope. When evidence fails, return to the responsible stage instead of endlessly decorating an unsuitable scene. One agent can perform every role; no orchestration platform or multiple agents is required.

## 1. Establish the job

Identify the input scene, one reviewable slice, spatial type, expected player/viewing distances and permitted changes. Preserve the supplied whitebox's routes, clearances, ramps, steps, jump surfaces, collisions and required sightlines; visual-only dressing can still obstruct these. An empty project does not imply an unconstrained layout.

Resolve indoor/outdoor/semi-open intent, intended enclosure, openings and allowed shell additions before architecture or light-rig decisions. A missing whitebox roof does not imply outdoors. Read [whitebox-input.md](references/whitebox-input.md) when preparing that handoff. Reuse established answers; ask only for consequential missing decisions while continuing independent work.

## 2. Find and qualify references

Use [reference-selection.md](references/reference-selection.md) when finding or replacing references. Even user-provided imagery needs a statement of what it can establish; keep the user's intended direction while supplementing missing evidence.

Prefer legible in-game environments or relevant environment-artist breakdowns. A character key visual, battle explosion or dramatic promotional crop rarely supports architecture, material and dressing decisions. Select by visible environment evidence, not game fame, search rank or image resolution. Promotional origin alone neither qualifies nor disqualifies an image.

Keep exact image/source identifiers. Actually inspect each selected image, checking its identity when viewing batches. Label primary environment evidence, supplemental mood evidence and rejected candidates. If the current reference set cannot establish the work area's environment, repair it before deriving a style brief or replacing major assets.

## 3. Establish art direction

Read [art-direction.md](references/art-direction.md) for reference interpretation, asset compatibility and dressing decisions. Record a compact visual brief: dominant forms, surface/detail scale, material family, palette, density rhythm, activity, light sources and focal hierarchy. Tie important choices to particular reference regions.

Keep user requirements, image observations and implementation hypotheses distinct. Separate permanent environment from characters, UI, combat effects and post-processing. Internal consistency and reference fidelity are separate judgments. Do not silently substitute retro, low-poly or generic realism for the chosen target.

## 4. Audition an asset family

Search suitable local/catalogue assets and external sources for the visible architecture and representative props. Cached convenience does not establish suitability. Verify actual downloadable/free contents, commercial-use and redistribution conditions; record sources, authors, chosen files and adaptations, and retain licenses. Use bounded download retries and move to a viable alternative rather than spending the task on one file.

Inspect representative imports for dimensions/pivot, useful variants, UV/PBR channels, alpha and normals. Compare a small number of plausible families in Godot at target scale and distance: main architectural/surface element plus adjacent props under readable light and the intended light direction. A full-wall sample must expose repeated stains, holes and normal/roughness patterns, not merely test texture seams.

Record which candidate fits the brief, what adaptation it needs and why alternatives fail. Wrong silhouette/proportion or surface language returns to selection; an import problem returns to adaptation. Lack of a suitable main asset is an explicit production gap, not permission to replace the scene with procedural boxes. Use Blender when a specific adaptation or missing asset warrants it, following the available Blender workflow.

## 5. Produce one complete local slice

Plan region/node ownership and dependencies before editing. Reuse the current saved scene; use an alternate scene or bounded changes for risky candidates. Do not run a builder that overwrites hand edits merely because it exists.

Establish architecture, ground, thresholds, boundaries and a working light rig early. Build activity-based prop groups with believable supports, scale and access; finish surface transitions and selective wear, then refine light and depth. Evaluate materials under actual lighting throughout production. Procedural work fills suitable gaps such as distribution or background terrain; it does not bypass main-asset selection.

Work by region/shared resource, not independently per screenshot. Preserve module proportions and texture density. Vary function, state and grouping rather than grid-repeating boxes. When resizing vegetation, reassess coverage as well as blade scale. For a lighting-focused iteration read [lighting-review.md](references/lighting-review.md).

## 6. Review, diagnose, revise

Save and reopen the scene before capture. Use stable overall, transition and close views as relevant, plus a nearby angle when contact, geometry or traversal visibility is uncertain. Freeze submitted passes and write new images to a new directory. Generated illustrations and retouched screenshots cannot prove an editable 3D result.

Look at the images before inheriting prior agent conclusions. Review reference fidelity, asset-family consistency, detail/activity, and lighting; keep technical validity and user acceptance separate. Identify the few largest visual failures, record evidence and affected regions/cameras, and choose a return path using [production-loop.md](references/production-loop.md). Mark edits as awaiting visual review until new images have actually been inspected. If a revision adds complexity without improving the target, retain the better pass and change approach.

Only validate importing, loading, actual rendering and constraints directly affected by the change. Do not create controllers, general regression suites, review UI or benchmarks for an art task. Consult [godot-delivery.md](references/godot-delivery.md) for concrete assembly/capture traps.

## 7. Deliver and preserve useful decisions

Provide the editable scene, actual same-view comparisons, asset provenance, opening instructions and unresolved weaknesses. Update the task entry and issue status together; do not claim user approval from agent review. Commit independent reviewable stages according to repository conventions, preserving unrelated changes.

Carry forward asset-specific adaptations, accepted reference/asset choices and scoped user decisions. Recheck them when their source, reference or intended distance changes. Expand only within the requested scope; a successful hero view does not establish completion of the whole level.

For an explicitly requested skill/model trial, keep reference inputs, whitebox constraints, raw asset access and work allowance comparable; record actual model and skill version when known. Separate first-pass results from feedback-assisted revisions. Do not supply the intended answer or old completed scene to an independent replication trial. Model availability is not evidence of better art; evaluate its selections and saved-engine images.
