# FLUX WORKS · 07 冷却回路交接站

用 Godot 4.7.2 打开本目录的 `project.godot`，等待导入后按 **F5**。入口为 `final.tscn`，初始视角对着门。画面采用 Metal Forward+，固定审查图为 1280 × 800。

| 操作 | 用途 |
|---|---|
| 5 / 6 / 7 | 门洞、工位全貌、仪表近景 |
| 鼠标左键 | 捕获鼠标 |
| 1 / 2 / 3 | 第一人称、第三人称、自由相机 |
| WASD、鼠标、Space | 移动、观察、玩家跳跃 |
| Esc | 释放鼠标 |

## 场景与实图

| 阶段 | 可编辑场景 | 同机位截图 |
|---|---|---|
| 统一输入 | [白盒](whitebox.tscn) | [door](captures/whitebox/door.png) · [props](captures/whitebox/props.png) · [close](captures/whitebox/close.png) |
| 素材小样 A，结构墙 | [sample_a.tscn](sample_a.tscn) | [door](captures/sample-a/door.png) · [props](captures/sample-a/props.png) · [close](captures/sample-a/close.png) |
| 素材小样 B，分段板墙 | [sample_b.tscn](sample_b.tscn) | [door](captures/sample-b/door.png) · [props](captures/sample-b/props.png) · [close](captures/sample-b/close.png) |
| 首轮 | [first.tscn](first.tscn) | [door](captures/first/door.png) · [props](captures/first/props.png) · [close](captures/first/close.png) |
| 一次自主修订 | [final.tscn](final.tscn) | [door](captures/final/door.png) · [props](captures/final/props.png) · [close](captures/final/close.png) |

## 编辑

`BaseLab` 实例保留原白盒的物理与控制器。新增内容位于 `Art`；门在 AccessGantry 和 PersonnelPortal 下，主机、管线、仪表分别在 PressureTest、ProcessPiping、PumpInstruments 下。FilterChangeout 包含打开的筒体托座、换下的滤芯与台钳。设备读数和警告牌是贴在实体表面的静态图形。

共用网格放在 `art/meshes`；最终的墨线、材质、软管网格与带 mipmap 的印刷纹理位于 `art/final`。两轮场景均可独立打开。GPU 导入和截图均使用 `python3 render.py`，再次取证时给出新目录，例如 `python3 render.py capture final.tscn captures/recheck`。

## 范围与不足

制作范围集中在原门洞和右侧墙角。相邻后墙加了滤芯库卷帘，入口和工位上方补了顶棚，靠近机位的原跳台和台阶做金属覆面。其余运动场保持白盒；从工位右侧开口可以看到边界外的网格地面。门保留 1.2 m × 2.3 m 净空。原碰撞、玩家与相机脚本沿用冻结输入；验证包括重开场景实际出图、入口和场景覆盖项检查，未作人工键盘走图。

终图的屏幕与机械表都能读数。重复管节和两块同编号跳台盖板仍较规整，细长金属件上的墨线偏密。参考依据、选材过程与逐图评价见 [RESEARCH](RESEARCH.md)、[ASSETS](ASSETS.md) 和 [REVIEW](REVIEW.md)。

初次系统 Git 调用的全局配置读取及临时缓存写入被沙箱拒绝。后续提交使用本组目录内的临时位置并禁用全局 Git 配置。
