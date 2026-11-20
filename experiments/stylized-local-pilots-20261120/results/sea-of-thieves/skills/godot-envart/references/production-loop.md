# Production loop and handoff

Use for new jobs, resuming a case, or deciding where a failed visual pass should return. This is an agent-executed working protocol, not a scheduler or a claim that all stages are automated. Small edits reuse valid previous decisions. Do not create empty documents to satisfy a checklist.

## Stages and decisions

| Stage | Inputs and work | Durable output | Move forward when / return when |
| --- | --- | --- | --- |
| Scope | User request, source scene, existing work; establish slice, spatial intent, protection and editable ownership | Short job entry linking the real scene and constraints | Intent is sufficient for the next decision. Clarify a consequential ambiguity; continue independent reference/asset work meanwhile. |
| References | Search/select exact images for the target area; inspect environment visibility and provenance | Qualified reference set with roles, observations, gaps and rejected choices | Environment evidence supports the intended study. Replace character/effect-dominated images or missing views before extracting architectural requirements. |
| Direction | Interpret reference relationships under whitebox constraints | Compact brief with visual anchors, activity/light intent, tolerable adaptations and uncertainties | There is a concrete basis for choosing assets. Resolve conflicting anchors or revise an unsupported inference. |
| Auditions | Search families, check actual license/files, import, adapt and render representative combinations | Candidate decisions in the manifest, source assets, small engine samples | Main form, surface scale and neighboring props work together. Reject unsuitable assets early; escalate a style/scope change to the user rather than silently lowering the target. |
| Production / direction draft | Chosen family and brief; representative architecture/ground, major props, materials and basic light | Saved editable draft and fixed-view engine images | The visual direction can be judged as a whole. Fix technical presentation defects before asking about taste. |
| User calibration, when needed | Draft, qualified references, established user requirements and remaining ambiguity | Scoped user decisions and observable revision targets in the existing brief | Direction is sufficiently clear to refine. Reuse existing decisions; keep consequential unanswered preferences pending. |
| Production / refinement | Calibrated or already-established brief; bounded asset, composition, material and light revisions | New saved pass and concise changes, preserving the draft | The requested visual problems have new evidence for review; route unsuitable main assets back to auditions. |
| Review | Reopened scene, fixed cameras, reference set, user constraints | New frozen captures and evidence-linked issues/verdict | Visible deficiencies are resolved or explicitly left open. Route each failure to its cause; no automatic acceptance from a technical check. |
| Delivery / reuse | Reviewed working pass, provenance, remaining gaps | Human comparison, compact agent entry, scene/version links, scoped lessons | User can inspect/edit the result and resume it. User acceptance and authorization to expand are explicit, distinct from agent review. |

Lighting is part of direction, auditions and production, with a dedicated review dimension. Do not leave all illumination decisions until after materials and props are committed.

## Roles, without requiring more agents

A single agent can switch between art direction (reference interpretation and family choices), production (bounded scene edits) and review (image-based diagnosis). User decisions set the target and acceptance. Recover the project's recorded aesthetic requirements when starting or transferring a job; a procedural skill alone does not carry the user's taste.

If separate agents are explicitly authorized, hand off only the relevant brief, scene/region, protected content, candidate/raw assets and evidence paths. Require findings and editable output to return to the same task records. A reviewer should see images and constraints before the author's self-score; user feedback must never be hidden. Parallel output is not permission to overwrite shared scenes. Model choice is a run detail, not an architectural dependency; use available models and record the actual choice rather than a guessed marketing name.

For calibration and fresh-agent editing use [aesthetic-calibration.md](aesthetic-calibration.md): A produces, B independently diagnoses then edits, and the coordinator reviews the before/after result. Calibrate the representative draft before costly detail work when the direction remains uncertain; established directions do not need repeated approval. Do not leave useful independent review as a final ranking when the authorized task is to improve the scene.

## Keep a small set of authoritative records

Reuse existing names; the following are responsibilities, not a mandatory new schema.

| Record | Authority and minimum useful contents | Not its job |
| --- | --- | --- |
| `ENVIRONMENT.md` or existing job entry | Current scope/stage; source and working scene; protected ownership; brief/reference links; selected pass; next action and affected views | Copy every object transform, all history or the entire issue list |
| Reference/brief section in the entry (separate file only if needed) | Exact images/sources and evidence roles; observed anchors; scoped user constraints/calibration, retained features, open hypotheses and visible revision targets | Assert hidden geometry or permanent lights; treat proposed interpretations as user decisions |
| Existing asset manifest | Actual sources/files/license; representative dimensions/variants; selected/rejected/adapt decisions and sample evidence | Treat a download as visual acceptance; generate a duplicate scene graph |
| Existing review record | Issue, evidence/region, impact, proposed action, affected resources/views, status; changes and new proof when they exist | Convert agent suggestions into user requirements or issue scores into approval |
| Saved scene and resources | Actual geometry, transforms, materials, light and cameras; explicit authored/manual ownership | Be silently rebuilt from stale code after manual edits |
| Pass directory and freeze record | Scene/version, cameras/settings, directly relevant changed dependencies and images | Claim full dependency reproducibility from a partial hash list |
| HTML/comparison | Readable images and decisions derived from the above | Become another independently maintained authority |

When starting, record only known facts. When resuming, the entry must answer: what is editable, which pass is real, what remains uncertain, and what action comes next. Do not mark a past stage validated just because a finished-looking scene exists. Use `existing, evidence missing` for retrospective gaps rather than inventing earlier auditions.

### Compact record examples

A candidate decision can be a few fields in the existing manifest:

```text
candidate: cabinet-A / source and actual files / license evidence
role: near-view archive furniture beside selected desk
decision: reject (or inspect / adapt / select-for-slice)
reason: side construction visibly simpler than the desk at props distance
sample: captures/audition-01/props.png
adaptation or next candidate: ...
```

For a review issue, keep observation and proposed remedy separate:

```text
id / evidence image and region / affected scene nodes or resource
observation / visual impact / user requirement or reference anchor
proposed action / return stage / affected cameras
status: open → editing → needs-render → needs-review → visually-verified
changes + verified_in: add only when the edit and new image exist
user acceptance: separately recorded, unknown until expressed
```

`deferred` means outside the active slice or deliberately postponed, not resolved. Reopen a verified issue if its material, geometry, lighting or reference premise changes. These state names may map to existing project vocabulary; do not build a state-machine service.

## Diagnose before revising

| Visible failure | First question / return path |
| --- | --- |
| Cannot tell what the target environment actually looks like | Reference stage: find an unobscured view; do not invent detail from characters or combat effects. |
| Wrong spatial type or misleading reference interpretation | Scope/direction: resolve enclosure and anchors before further construction. |
| Architecture/tree/furniture silhouette is fundamentally wrong | Auditions: replace or deliberately adapt the asset; color grading and more clutter will not fix it. |
| Material looks tiled, flat or inconsistent with its neighbors | Auditions or production: test the source at full surface scale and readable light; distinguish material choice, mapping and illumination. |
| Props feel sparse, repetitive or unrelated | Production: revise activity, support and density rhythm; return to sourcing if the required object roles are absent. |
| Focus, shadow readability, material response or contact fail | Lighting/material diagnosis within production; hold content fixed for a lighting-only comparison. |
| Newly saved scene loses an override or asset | Implementation: repair persistence/import, reopen and recapture; do not change the art target. |
| Main camera works but another view breaks | Production: fix shared region/geometry; do not make separate contradictory scenes for each camera. |

A round can address one related group of failures; it need not change only one numeric parameter. Name the hypothesis and expected visible gain. If several causes change together, describe it as a combined art revision, not a controlled lighting experiment.

## Bounded iteration and recovery

- Preserve the prior scene/pass before risky changes. Keep changes inside the chosen region or explicitly named shared resources. Respect repository commit cadence.
- Spend work first on the dominant mismatch and costly-to-reverse choices. Usually a few candidates or one focused round yields a useful decision; the count is not a ritual.
- Use bounded asset-download retries. If a revision visibly fails or repeats the same failure, stop that approach, retain the stronger pass, and return to the appropriate upstream decision. Do not spend hours adding detail to rescue a rejected foundation.
- Reuse saved images only for unchanged visual content or text-only reassessment. A shared shader/light change may invalidate several camera comparisons even if only one region was intended.
- Update issue state, task entry and comparison from the same pass. Never describe `edited` as `visually-verified` before inspecting the new render, or `visually-verified` as user acceptance.
- For ambiguous depth, contact or line of sight, use one nearby camera or the existing player/free camera; do not add an interaction system to prove a visual point.

## Learn and extend

At delivery, retain the specific asset's useful scale/variant/material correction, rejected family with visual reason, scoped user feedback and unresolved limitations. Distinguish reusable evidence from taste and from untested hypotheses. A Control wall decision does not forbid joints on all concrete; a failed free asset does not establish that all free assets are poor.

If extension is authorized, reuse the accepted family, activity principles and material/light relationships in the next connected region; review transitions and shared-resource effects. Do not clone prop arrangements mechanically. If the local sample is still unaccepted, preserve that status instead of representing broad coverage as success.
