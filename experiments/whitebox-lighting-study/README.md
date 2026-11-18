# Whitebox records-transfer lighting study

> **开始阅读：[ENVIRONMENT.md](ENVIRONMENT.md)** — 当前范围、区域、机位、证据和未解决问题。当前入口是封闭室内 `interior_detailed.tscn`；`lighting_notes.md` 前半部分记录的是早期开放设施照明试验，不用于验收当前室内。

## 2026-11-18 管线接续迁移

当前场景与 `detail-01` 图片未变。完整流程已更新为参考筛选、方向、素材小样、局部制作、实机评审与返工；本案例从“需补环境主参考”继续，旧战斗图保留作局部/氛围证据。先看 [当前阶段和下一步](ENVIRONMENT.md)，再看 [完整管线图文说明](../../docs/envart-pipeline-skill.html)。本次没有重渲染，也不代表新版流程已通过制作验证。

## 2026-11-15 局部细节修订（当前 F5 入口）

F5 打开 `interior_detailed.tscn`：复用混凝土扫描贴图恢复细微色差、粗糙度和法线细节；新增真实货架、交接车与便笺，补齐待处理档案组合；调整冷色天光与暖色工作灯。仍只完成原室内局部。查看 [三个同机位实机对照](../../docs/control-interior-detail.html)。

打开 `interior.tscn` 按 F6 查看上一版；三台相机 room、props、door 的变换与 FOV 一致。新截图冻结在 `captures/detail-01/`，旧 `captures/interior-glazed/` 未覆盖。素材来源见 `detail_manifest.json`，冻结与约束核对见 `detail_freeze.json`。

新增 props 在 `ArtContent/Art_Added`，灯光在 `Lighting`，墙面材质使用 `concrete_detail.gdshader`。可直接编辑保存场景，无需运行构建脚本。`refine_interior.gd` 是可选重建工具，会从 `interior.tscn` 生成并覆盖 `interior_detailed.tscn`；重建前另存手工改动。

复现本轮出图时使用新目录名，避免覆盖冻结图片：

```sh
/Applications/Godot.app/Contents/MacOS/Godot --path /path/to/this/project --rendering-method forward_plus --rendering-driver metal --script res://capture.gd -- interior_detailed detail-next
```

柜体侧面与建筑细部仍较简化，未达到 Control 完成度。新增道具没有追加碰撞，反弹光为手工近似。本轮只检查导入、实际出图、固定机位和原白盒保留；没有增加功能验证套件。

## 2026-11-14 室内初稿（保留对照）

上一版 `interior.tscn` 包含：净高 5.5 m 的室内围护、带玻璃的 3×5 m 顶部采光口、带吊杆的办公灯、桌面暖光、连续混凝土表面与档案告示。打开 `interior_before.tscn` 按 F6 可看同相机的旧开放场景。`Cameras` 下的 `room`、`props`、`door` 可在编辑器预览。

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
