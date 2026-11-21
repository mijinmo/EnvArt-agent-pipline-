# Resonance · 意航员 2 工坊局部

用 Godot 4.7.2 打开本目录的 project.godot，按 **F5** 进入 [draft.tscn](draft.tscn)。项目默认从整体书签开始。**5** 看原布局，**6** 看校准门与仪表台，**7** 从坡脚看平台和后场。三张交付图均为 1280 × 800。[整体](captures/selected/overall.png) · [门洞近景](captures/selected/close.png) · [坡道过渡](captures/selected/transition.png)

沿用原 Inspection、Player 和 CameraRig。单击视口捕获鼠标，1 / 2 切第一或第三人称，WASD 移动，空格跳跃，Shift 加速，Esc 释放鼠标。F / 3 切换自由观察。

### 场景编辑

| 在 draft.tscn 中打开子场景 | 负责区域 |
| --- | --- |
| CalibrationEntrance | 原门柱与门楣的外观、门槛、指针表、招牌 |
| WorkAndExhibition | 右侧调试桌、示波器、两个试制品展盒、抽屉工作台与后侧测试舱 |
| RearElevation、ServicePartition | 后墙分配器、线圈图、货架、墙灯、局部顶棚、折墙内衬与外侧标志 |
| InclineStation、ServiceStairs、三个 Impulse | 坡面与平台饰面、平台后方接收设备、台阶和三座跳台的可见外壳 |

根节点下的 BaseWhitebox 以单位变换实例化 [原始物理场景](source/whitebox.tscn)。17 个 StaticBody3D 的位置、形状、几何尺寸、碰撞层与掩码通过正式出图核验。门洞保留 1.2 m 净宽和 2.3 m 净高，坡面与踏面保持开放。场景层只覆盖局部占位 Mesh 的材质或可见性。新增美术节点均为视觉构件。

### 当前阶段

代表性局部已提交，状态为 `awaiting_user_calibration`。外围网格地面、出生区、后墙两端和整间房的顶棚留在白盒或剖开状态。Resonance 是为本稿设定的仪器工坊名称。素材小样保存在 [audition.tscn](audition.tscn)，首次试装的完整资源版本见提交 `8719611`。每次复拍均使用 `python3 render.py capture draft.tscn captures/新目录`，素材导入使用 `python3 render.py import`。

[参考观察](RESEARCH.md) · [素材与许可](ASSETS.md) · [逐图自查与阶段记录](REVIEW.md)
