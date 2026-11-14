# Whitebox records-transfer lighting study

## 2026-11-14 室内局部修订（当前 F5 入口）

F5 现在打开 `interior.tscn`：净高 5.5 m 的室内围护、带玻璃的 3×5 m 顶部采光口、带吊杆的办公灯、桌面暖光、连续混凝土表面与档案告示。打开 `interior_before.tscn` 按 F6 可看同相机的旧开放场景。`Cameras` 下的 `room`、`props`、`door` 可在编辑器预览。

原 17 个白盒几何与碰撞保留，新增顶棚、墙体上部和外围围护；主要完成墙边办公区与门洞，其他测试场区域仍未完成美术。新增围护目前用于视觉样板，未新增玩法或碰撞系统。图文对照见 [室内修订报告](../../docs/control-interior.html)。

`build_interior.gd` 仅用于可选重建，会覆盖 `interior.tscn` 和 `interior_before.tscn`，正常打开无需运行。素材与适配见 `interior_manifest.json`。下文为前一轮照明试验说明；其场景和冻结截图仍保留，原主工程默认入口不受影响。

A constrained Control-language sample built on the **exact original controller laboratory whitebox**. This is an open maintenance / records transfer hall, with an office activity group, a dressed 1.2 m doorway and an unchanged 3 m ramp. The source references are `control-3.jpg` and `control-4.jpg`; the scene is an interpretation of their concrete, archive furniture and motivated-light language, not a room reconstruction.

Open this directory's `project.godot` in **Godot 4.7.2**, with **Forward+ / Metal**. F5 opens the new indoor scene; the earlier static lighting scenes remain available via F6. Native scenes:

- `whitebox_review.tscn`: original whitebox, original lab sun/ambient, shared review cameras.
- `art_base.tscn`: shared authored content, original lab sun/ambient.
- `art_lit.tscn`: exactly the same `art_content.tscn` and cameras, changed illumination/environment only; final light pass 02. `art_lit_01.tscn` and `art_lit_02.tscn` preserve both review passes.
- `art_content.tscn`: editable geometry/materials, original bodies under `Whitebox/World`, all decoration under `Art_Added`.

There are no controllers, added interaction systems or review UI. Four Camera3D nodes (`overall`, `door`, `ramp`, `props`) are editable under `Cameras`; select a camera and preview it in the 3D editor. In a copy of the scene, mark another camera Current to run that view.

## Evidence

Saved scenes were loaded in a fresh graphical Godot process, rendered with Metal Forward+ on Apple M5, then captured at 1600×1000. `captures/whitebox/`, `captures/art-base/`, and `captures/art-lit-01/`, and `captures/art-lit-02/` each contain the same four camera views. A/B have no auto exposure. First review pass is frozen; later lighting edits must use a new capture directory.

To reproduce a capture (from any working directory):

```sh
/Applications/Godot.app/Contents/MacOS/Godot --path /path/to/this/project --rendering-method forward_plus --rendering-driver metal --script res://capture.gd -- art_lit art-lit-02
```

The optional last argument is one camera name. `build.gd` is the authored scene builder, not required to open/play the saved native scenes. It rebuilds the shared art and initial lighting scenes; `refine_lighting.gd` applies the documented second light pass. Do not run either builder while making a lighting-only comparison. `check_constraints.gd` performs only the directly relevant 17-body preservation and A/B camera/content checks; see `constraint_check.txt`.

Read `constraint_notes.md`, `lighting_notes.md`, and `asset_manifest.json` for scope and limitations. This is a small art/lighting trial, **not user art approval**. Overall view remains deliberately an open test layout; no architectural enclosure was invented to hide the whitebox. The cabinet model has low-detail sides and the ramp finish is still plain at close range.
