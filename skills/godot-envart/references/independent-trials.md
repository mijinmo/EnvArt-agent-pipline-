# Independent art trials

Use this only when the user requests a pipeline/model comparison. Ordinary production does not need an experiment harness. The deliverables remain editable environment art and actual engine images.

## State what the trial can establish

Choose one mode before making input packages:

| Mode | Starting input | Valid question |
| --- | --- | --- |
| Continuation | Same frozen existing art, references, raw asset pool and whitebox | Which run improves this existing slice within the allowance? |
| Independent production | Raw whitebox, spatial intent, qualified reference brief and equal asset-source access | Can the pipeline select assets and build a coherent slice independently? |

A finished scene already encodes asset choice, composition, dressing and lighting. Four copies can converge without anyone reading a peer's work. Never label a continuation comparison as independent reconstruction, discovery quality or evidence of design diversity.

For independent production, exclude prior completed scenes, screenshots, generated shaders, builders, result reports, producer critiques and solution-bearing README/history. Always supply the relevant **user requirements and aesthetic decisions**, together with permitted original reference evidence; do not erase the user's target in the name of isolation. The coordinator extracts scoped constraints from history without providing a completed solution or another candidate's critique. Give necessary whitebox dimensions, indoor/outdoor/semi-open intent, traversal limits and fixed review cameras. If the whitebox has several possible regions, select the same slice before distribution.

Freeze qualified references when comparing effort on the same art problem. To evaluate reference discovery itself, instead give the same spatial/art brief and search access; each producer independently records image selection and rejection using reference-selection.md. Likewise, a fixed asset pool tests selection/adaptation within that pool, not external asset discovery. Declare which choices are fixed and which are being evaluated. Do not vary reference search, input scene and effort simultaneously and attribute all differences to effort.

## Separate producer workspaces before launch

The coordinator packages only allowed inputs, the skill snapshot, source licenses and neutral capture helpers. Hash the package and record the input scene, renderer, camera poses, model/effort, allowance and permitted feedback. A neutral helper must not contain art decisions or peer paths.

Give each producer a fresh context and a separate directory **with its own newly initialized Git repository**, outside the archive of previous results. Do not use linked worktrees of the production repository: they share object history and can expose other samples. Give each run its own temporary directory, output directory and tool caches where configurable. Copy a shared helper into each package before launch; never borrow another agent's temporary script.

Permit only the assigned package, its own work/temp files, required skill/tool resources and approved external source access. Prohibit reading/listing sibling runs, host result directories, global experiment Git status/log/diffs, other conversations and peer-generated caches. Do not put the full result matrix or other producers' paths in a producer prompt. Parent collection and final repository integration happen after the run.

Where available, enforce filesystem read boundaries or run on separate accounts/machines. Directory separation and prompt instructions alone are **logical isolation**, not proof that access is impossible. State the actual protection used; do not invent a sandbox guarantee. Heavy infrastructure is optional, honest reporting is mandatory.

Producers make local stage commits in their own repository. The coordinator alone integrates accepted artifacts into the host repository, checking licenses and file ownership. This preserves frequent reviewable commits without exposing peer commit titles or sharing a staging area. Producers of different candidates do not message each other about art or inspect each other's work. Scheduling and technical issues go through the coordinator.

A declared serial handoff within one candidate is different: B may inherit the designated A scene, assets, evidence and calibrated brief through the coordinator. Record the allowed predecessor and stage, keep other candidates inaccessible, and label B's result as assisted revision rather than independent from-whitebox production. See [aesthetic-calibration.md](aesthetic-calibration.md) for A/B/coordinator responsibilities. This exception does not authorize browsing the host archive or other runs.

## Keep the work and feedback comparable

Use the same number of art passes and the same reference/input access for an effort comparison. Every producer inspects its own actual first-pass captures before revision. Permit reference-driven mesh/material/shader adaptation; do not prescribe the same art solution to all runs merely to make them comparable.

Distinguish technical repair (missing import, invalid shader, capture failure) from new art feedback. Record repair attempts and waiting separately. If the coordinator gives art feedback, keep its scope and number comparable and preserve the pre-feedback pass. Do not forward a solution, screenshot or critique learned from a peer. Never silently replace a frozen earlier pass.

If testing the benefit of a fresh editor, fork the same frozen draft into A self-revision and B revision with the same reference, user calibration and art allowance; keep the branches isolated. Calibrate shared preferences before forking where possible. Feedback changes after a fork must be recorded and comparable, or the result cannot isolate the handoff effect. Do not change effort, references and starting assets at the same time and call the difference a context effect.

Use only necessary import/load/render checks and checks of directly affected whitebox constraints. No extra gameplay systems or functional test suites. Stop on the user's machine/launch constraints; documentation work does not authorize deferred production or repeated engine windows.

## Review art before revealing labels

When independent review is authorized, give the reviewer reference evidence, common starting views and randomized result labels; hide model/effort, usage, producer commentary and implementation. Review all assigned fixed cameras, not only the best frame. A reviewer may compare candidates; a producer may not read them. One coordinator can perform the review if no separate agent was requested.

Evaluate reference fidelity and internal unity separately, along with asset selection, functional/narrative detail and lighting/depth. Explain differences with visible evidence; shader counts, downloads and prop counts are not quality scores. Keep unresolved weaknesses and user acceptance separate from an agent's preference.

Compare usage only after visual judgment. Record uncached/cached input and output separately; reasoning may already be part of output. Token count is not money. Raw timestamps containing scheduling, approvals, rendering waits or unexplained clock gaps are not a reliable speed benchmark. Record model/effort from runtime metadata where available, not an assumed UI default. One sample per setting gives a provisional local preference, not a universal best effort.

## Audit exposure and deliver

Inspect available tool access records against the input boundary. Classify any exposure: metadata (names/commit titles), neutral helpers, or actual art/solution content. Record when it occurred relative to capture and what is uncertain. An absence of visible violations is not proof of hard isolation, and unavailable/encrypted records cannot be claimed as inspected.

If peer art or solution content was read, exclude the affected sample from independent conclusions; repeat that sample in a clean workspace only when running is authorized. Metadata/helper exposure must still be disclosed and the boundary repaired; do not assert copying without evidence.

Deliver saved scenes, frozen first/final engine images, references and licenses, concise visual findings, actual usage and an isolation statement. Keep full private conversation logs out of the repository. Preserve old results as historical evidence; mark new-rule trials as pending until actually run.
