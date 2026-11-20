# Otto 工坊柜台

用 Godot 4.7.2 打开本目录的 project.godot，按 **F5** 进入柜台全景。主场景是 [draft.tscn](draft.tscn)，使用包内既有巡检控制器。场景树中 Reception、Acoustics、WaveCalibration 分别是接待、声学和脑波校准台；Architecture 下可编辑房间和供给管；五个独立展盒及示波器可单独移动、缩放或替换。可双击 assets/models 中的 GLB 查看各自的零件。

| 操作 | 按键 |
| --- | --- |
| 全景／仪表近景／左侧过渡 | 5／6／7 |
| 第一人称／第三人称／自由巡检 | 1／2／3 |
| 移动及视线 | WASD、鼠标 |
| 自由巡检升降 | Q、E |
| 释放鼠标 | Esc |

工作面集中在后半区。来访者出生在 (0, 0.05, 3)，沿波纹地毯可以走到接待台前。地面沿用 12 × 12 m 白盒碰撞，柜台另有碰撞。

**当前阶段**为代表性局部初稿及一次明确缺陷修复，状态为 `awaiting_user_calibration`。三机位同为 1280 × 800。小样见 [material-study](captures/material-study)，初稿见 [draft](captures/draft)，修复过程见 [repaired](captures/repaired)，当前场景的复拍见 [final](captures/final)。[参考](RESEARCH.md) · [素材与许可](ASSETS.md) · [自查](REVIEW.md)

本包中，导入使用 `python3 render.py import`；复拍使用 `python3 render.py capture draft.tscn captures/new-review`，输出目录需使用新名称。
