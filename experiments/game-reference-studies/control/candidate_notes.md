# Candidate decisions

1. **3TD Office Starter Pack — selected partly.** https://opengameart.org/content/3td-office-starter-pack — Ron Kapaun, CC0. Actual free download inspected: DAE office desks, two dividers, filing cabinet, storage, textures and license PDF. The utilitarian dark filing cabinets fit institutional archives. Divider selected as workstation enclosure. Old laminate desks rejected in favor of more detailed PBR desk. Legacy DAE Godot parser fails; files converted to GLB, dummy collision discarded. This is a new search/download, not reused project content.
2. **Poly Haven Metal Office Desk — selected.** https://polyhaven.com/a/metal_office_desk — Ulan Cabanilla, CC0. Full downloadable model; worn steel, handles and drawer detail suit a mid-century bureau. 1K glTF + normal/ARM/diffuse actually downloaded. Native 2m width checked, uniformly scaled to 2.5m for the inspection desk.
3. **Poly Haven Mid Century Lounge Chair — selected.** https://polyhaven.com/a/mid_century_lounge_chair — CC0; 1K glTF actually downloaded. Leather/wood furniture silhouette fits institutional visitor waiting, unlike colorful lowpoly office props. Uniformly calibrated to 0.86m wide.
4. **Poly Haven Desk Lamp Arm 01 — selected.** https://polyhaven.com/a/desk_lamp_arm_01 — CC0. Articulated realistic desk light supplies a purposeful paperwork pool; downloaded 1K PBR glTF.
5. **ambientCG Concrete042 — rejected/failed request.** Search corrected the guessed identifier to Concrete042A/B; B contains exposed mesh/rebar and excessive damage, unsuitable for intact bureau walls. Initial bounded request 404; switched source promptly.
6. **Poly Haven Concrete Panels — selected.** https://polyhaven.com/a/concrete_panels — Amal Kumar, CC0. Actual 1K diffuse/roughness/OpenGL normal maps downloaded for wall casting texture. Normal strength intentionally reduced for close view.
7. **Existing Quaternius sci-fi props — rejected without copying.** Raw local asset names were considered; overt sci-fi silhouette/material family would dilute Control's bureaucratic realism. No old scene, generator or assets used.

## Architecture constraint
No verified downloadable concrete interior module family matched the small room within the timebox. The enclosing slab/portal is authored gap-fill with actual downloaded cast concrete PBR, while the visible archive bank, partitions and primary furnishings use real downloaded geometry. This is a limit of asset sourcing, not a claim of architecture-kit success.

## Download discipline
All new downloads used 35–60 second timeouts and at most one retry. Python urllib produced 403; curl succeeded. Archive scripts were not executed. Source DAE retained as `.dae.source` to avoid repeated Godot import errors. Material and scene files only were extracted.

## Second-round visual correction
The initial **Concrete Panels** choice failed inspection: its dense raised/ribbed panels read as an old FPS industrial wall, not the reference concrete. Replaced with **Concrete Wall 009** (https://polyhaven.com/a/concrete_wall_009; Charlotte Baglioni, CC0), which has large smooth formwork, tie bolts and sparse stains. Inspected downloaded diffuse image, used 2K maps. The floor now uses a separate **Concrete Floor Worn 001** (https://polyhaven.com/a/concrete_floor_worn_001; Dimitrios Savva / Rico Cilliers, CC0), also inspected and downloaded at 2K. Low normal strength and high wall roughness avoid a wet/corrugated look.

Added actual CC0 models: **Binder Notebook**, **Cardboard Box 01**, and **Vintage Radio Transceiver**, all from Poly Haven at their corresponding asset URLs in the manifest. These make a records-check activity legible instead of relying only on primitive paper sheets. Cabinets now face the review cameras; first round mistakenly exposed their plain backs.
