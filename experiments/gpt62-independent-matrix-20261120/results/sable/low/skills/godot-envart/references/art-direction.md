# Art direction, asset families and scene dressing

Use to turn qualified references into production choices and to diagnose visual mismatch. Keep the brief compact and tied to exact visible evidence; it is not a description of every pixel.

## Direction anchors

Identify the few relationships that determine the target: spatial enclosure and dominant proportions, silhouette/edge language, surface continuity and detail scale, material family and wear, color/value relationships, density rhythm, activity, light sources and focus. For each major anchor distinguish:

- User requirement: what the user selected or prohibited.
- Observation: what an identified image region actually shows.
- Hypothesis: how to reproduce that relationship within the protected whitebox.
- Uncertainty: hidden space, transient light, unclear surface, or conflicting references.

A compact example is “broad continuous concrete surfaces beside precise office furniture; subtle texture at close range; brighter working area within readable shadow”. It is not “use asset X, add seams, make everything dark”. Implementation proposals stay replaceable.

When the whitebox has different proportions from the reference, state which visual relationships can transfer and what cannot. Preserve the designed layout rather than silently rebuilding the reference room. Do not infer ceilings or openings solely from a missing whitebox surface.

## Search and choose families

Prioritize the assets that dominate the final views: architecture/ground, major furniture or vegetation, then smaller activity props. Compare candidates by silhouette and proportion, material/detail scale, age/wear, historical/function context and adaptation cost. Treat visual fit, actual license/file availability, and technical usability as separate decisions.

Use a compatible architectural family with supporting assets, not necessarily one vendor. A scanned desk, flat low-detail cabinet and simplified vegetation can conflict despite sharing colors. Reject, replace or adapt the weak member rather than degrading all materials to match. Familiar local kits are options, not the default answer to every art direction.

Inspect actual downloadable contents; paid full-pack promotional images cannot prove the free subset delivers the required pieces. Retain source/license evidence and actual selected variants. Use existing assets directly when suitable; use targeted Blender adaptation for missing dimensions/openings or specific defects. Use authored geometry only for necessary gaps, not as a hidden substitute for main-asset search.

## Audition at scene scale

A dominant surface needs a representative full wall/floor plus a close view. Seamless textures can still show periodic stains, holes and roughness/normal patterns. Test the intended joint scale and texture density. Do not hide repetition with darkness, extra grime or oversized UVs; do not remove all variation to escape repetition and then call a flat gray surface finished.

Use neighboring representative props to establish shared scale and quality. Compare under readable inspection light if needed, then the intended environment lighting. Freeze cameras and content for a lighting-only comparison; disclose mixed changes. Candidate evaluation is a visual decision, not a PBR-channel checklist.

## Compose the local place

Build the visible ground, entrance/threshold, enclosure, level changes and depth layer. Keep background subordinate; a gray floor or unfinished transition can dominate an otherwise detailed image. Match structural modules to their designed proportions instead of stretching entire buildings into openings.

Organize props by an activity: incoming → checking → outgoing, repair → parts → discarded material, or movement → waiting → access. Give groups a support surface, reach/access direction and relationship to architecture. Vary object states and group density while preserving deliberate empty space. Empty routes are useful; unrelated isolated display islands are not a functioning room. No fixed prop count proves richness.

Place surface wear and scatter where use, exposure, drainage or accumulation explain them. Repeated closed boxes with random rotations remain repeated closed boxes. Plants need compatible leaf shape, material rendering and scale; resizing plants changes coverage and requires checking the distribution again. Procedural distribution/background terrain may supplement selected assets, but must retain this visual direction.

## Light while producing

Establish a working key, readable fill and motivated local sources early so material choices are made in context. Refine hierarchy, contact, shadow softness, material separation and depth as the slice fills out. Darker shadows or stronger color are not inherently better. Fog should explain distance rather than hide weak construction.

For detailed lighting diagnosis use [lighting-review.md](lighting-review.md). For import/persistence issues use [godot-delivery.md](godot-delivery.md); do not reinterpret a technical defect as a reason to change the art direction.
