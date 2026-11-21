---
name: godot-envart
description: Art-direct and build asset-based Godot environments from whiteboxes or visual briefs, including reference discovery, asset selection, local production, and in-engine visual iteration. Use for environment-art production and visual replication, not controller or gameplay-system development.
---

# Godot environment art

Deliver an editable environment, supported by actual engine images. Treat reference selection, art direction, asset decisions, production and review as one connected workflow. Downloads, prop counts and technical passes do not establish art quality.

## Enter at the right stage

Read the assigned task entry (such as `ENVIRONMENT.md`), current scene and permitted evidence before acting. Stay within the task's input boundary; an independent trial must not browse the host repository's other results or history. Recover user constraints, current work, open issues and the last reviewed pass when supplied. Do not restart discovery for a narrow edit unless its premise has failed. For a new job or a pipeline handoff, use [production-loop.md](references/production-loop.md) for stage outputs, return paths and record ownership.

The working loop is:

**Scope → reference selection → art direction → asset auditions → local direction draft → user calibration when needed → refinement → engine review → delivery and scoped reuse.**

These are decisions and artifacts, not a sequence of approval requests. Reuse established user decisions and advance autonomously within the authorized scope. When evidence fails, return to the responsible stage instead of endlessly decorating an unsuitable scene. One agent can perform every role; no orchestration platform or multiple agents is required.

## 1. Establish the job

Identify the input scene, one reviewable slice, spatial type, expected player/viewing distances and permitted changes. Preserve the supplied whitebox's routes, clearances, ramps, steps, jump surfaces, collisions and required sightlines; visual-only dressing can still obstruct these. An empty project does not imply an unconstrained layout.

Resolve indoor/outdoor/semi-open intent, intended enclosure, openings and allowed shell additions before architecture or light-rig decisions. A missing whitebox roof does not imply outdoors. Read [whitebox-input.md](references/whitebox-input.md) when preparing that handoff. Reuse established answers; ask only for consequential missing decisions while continuing independent work.

Carry spatial completeness into the actual task brief: outdoor views need their visible background/depth and ground-to-distance transition; interiors need continuous intended walls, ceiling and readable space beyond the foreground. A local slice limits production area, not these visible relationships. Do not downgrade required enclosure to an optional canopy to keep a high inspection camera unobstructed. A cutaway requires an explicit presentation decision and cannot substitute for the intact playable interior.

## 2. Find and qualify references

Use [reference-selection.md](references/reference-selection.md) when finding or replacing references. Even user-provided imagery needs a statement of what it can establish; keep the user's intended direction while supplementing missing evidence.

Prefer legible in-game environments or relevant environment-artist breakdowns. A character key visual, battle explosion or dramatic promotional crop rarely supports architecture, material and dressing decisions. Select by visible environment evidence, not game fame, search rank or image resolution. Promotional origin alone neither qualifies nor disqualifies an image.

Keep exact image/source identifiers. Actually inspect each selected image, checking its identity when viewing batches. Label primary environment evidence, supplemental mood evidence and rejected candidates. If the current reference set cannot establish the work area's environment, repair it before deriving a style brief or replacing major assets.

## 3. Establish art direction

Read [art-direction.md](references/art-direction.md) for reference interpretation, asset compatibility and dressing decisions. Record a compact visual brief: dominant forms, surface/detail scale, material family, palette, density rhythm, activity, light sources and focal hierarchy. Tie important choices to particular reference regions.

Keep user requirements, image observations and implementation hypotheses distinct. Separate permanent environment from characters, UI, combat effects and post-processing. Internal consistency and reference fidelity are separate judgments. Do not silently substitute retro, low-poly or generic realism for the chosen target.

Recover the project's recorded aesthetic requirements and acceptance history from permitted inputs. Carry applicable user decisions into the brief with their scope; a new coordinator must not rely on unstated conversation memory. Do not turn an agent's preferred candidate into user approval. For a new direction, unresolved taste or a substantial style change, read [aesthetic-calibration.md](references/aesthetic-calibration.md).

## 4. Audition an asset family

Search suitable local/catalogue assets and external sources for the visible architecture and representative props. Cached convenience does not establish suitability. Verify actual downloadable/free contents, commercial-use and redistribution conditions; record sources, authors, chosen files and adaptations, and retain licenses. Use bounded download retries and move to a viable alternative rather than spending the task on one file.

Inspect representative imports for dimensions/pivot, useful variants, UV/PBR channels, alpha and normals. Compare a small number of plausible families in Godot at target scale and distance: main architectural/surface element plus adjacent props under readable light and the intended light direction. A full-wall sample must expose repeated stains, holes and normal/roughness patterns, not merely test texture seams.

Record which candidate fits the brief, what adaptation it needs and why alternatives fail. Wrong silhouette/proportion or surface language returns to selection; an import problem returns to adaptation. Lack of a suitable main asset is an explicit production gap, not permission to replace the scene with procedural boxes. Use Blender when a specific adaptation or missing asset warrants it, following the available Blender workflow.

## 5. Produce one complete local slice

Plan region/node ownership and dependencies before editing. Reuse the current saved scene; use an alternate scene or bounded changes for risky candidates. Do not run a builder that overwrites hand edits merely because it exists.

Establish architecture, ground, thresholds, boundaries and a working light rig early. Build activity-based prop groups with believable supports, scale and access; finish surface transitions and selective wear, then refine light and depth. Evaluate materials under actual lighting throughout production. Procedural work fills suitable gaps such as distribution or background terrain; it does not bypass main-asset selection.

Make the first local draft representative enough to judge form, material and lighting together. Where direction still needs user calibration, present that saved-engine draft before spending the allowance on decorative detail. Follow [aesthetic-calibration.md](references/aesthetic-calibration.md) to capture useful feedback, preserve settled decisions and translate it into visible revision targets. Known technical defects remain the agent's responsibility.

Work by region/shared resource, not independently per screenshot. Preserve module proportions and texture density. Vary function, state and grouping rather than grid-repeating boxes. When resizing vegetation, reassess coverage as well as blade scale. For a lighting-focused iteration read [lighting-review.md](references/lighting-review.md).

When a distinctive reference calls for stylized rendering, a dedicated shader is an allowed production tool. Use [stylized-shading.md](references/stylized-shading.md) to identify the visual mechanism, audition it on real assets, preserve material roles and compare against a fair same-scene control. Shader work supplements suitable geometry and dressing; it does not replace their selection.

## 6. Review, diagnose, revise

Save and reopen the scene before capture. Use stable overall, transition and close views as relevant, plus a nearby angle when contact, geometry or traversal visibility is uncertain. Freeze submitted passes and write new images to a new directory. Generated illustrations and retouched screenshots cannot prove an editable 3D result.

Look at the images before inheriting prior agent conclusions. Review reference fidelity, asset-family consistency, detail/activity, and lighting; keep technical validity and user acceptance separate. Identify the few largest visual failures, record evidence and affected regions/cameras, and choose a return path using [production-loop.md](references/production-loop.md). Mark edits as awaiting visual review until new images have actually been inspected. If a revision adds complexity without improving the target, retain the better pass and change approach.

First check required spatial completeness against the brief. Missing interior walls/ceiling, exposed void or unfinished visible background is an open production requirement, not merely a style preference awaiting calibration. Do not label such a result a complete local slice because protected whitebox geometry and traversal pass. Retain structural inspection views; when they sit outside the intended room, add stable interior views of the intact saved scene instead of removing the enclosure.

When a fresh-agent revision is authorized, use the A/B/coordinator handoff in [aesthetic-calibration.md](references/aesthetic-calibration.md): A makes the draft, B independently diagnoses then edits, and the coordinator compares the saved before/after evidence. Share the calibrated user requirements throughout. Independent review must influence the next edit when improvement is the task; a final ranking alone does not revise the scene.

Only validate importing, loading, actual rendering and constraints directly affected by the change. Do not create controllers, general regression suites, review UI or benchmarks for an art task. Consult [godot-delivery.md](references/godot-delivery.md) for concrete assembly/capture traps.

## 7. Deliver and preserve useful decisions

Provide the editable scene, actual same-view comparisons, asset provenance, opening instructions and unresolved weaknesses. Update the task entry and issue status together; do not claim user approval from agent review. Commit independent reviewable stages according to repository conventions, preserving unrelated changes.

Carry forward asset-specific adaptations, accepted reference/asset choices and scoped user decisions. Recheck them when their source, reference or intended distance changes. Expand only within the requested scope; a successful hero view does not establish completion of the whole level.

For an explicitly requested skill/model trial, follow [independent-trials.md](references/independent-trials.md) before preparing inputs or launching agents. Distinguish continuation of existing art from independent production from a whitebox. Keep the relevant inputs and work allowance comparable, isolate each producer's files and history, and record actual model/effort and skill version when known. Separate first-pass results from feedback-assisted revisions. Model availability is not evidence of better art; evaluate its selections and saved-engine images. Do not launch a deferred trial merely to validate a documentation change.
