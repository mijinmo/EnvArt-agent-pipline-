# 林地短石桥与残破桥头

Godot 4.7.2 · Forward+ · 室外环境局部 · `awaiting_user_calibration`

在 Godot 中打开本目录的 `project.godot`，等素材导入完成后按 **F5**。默认场景为 [draft.tscn](draft.tscn)。角色位于南端桥面，启动视点为俯视总览。北岸残柱旁设有修石工具，另一侧的灯杆和太阳旗标出过桥方向。

|操作|按键|
|---|---|
|总览、近景、南岸过渡书签|5、6、7|
|第一、第三人称|1、2|
|自由巡检|3|
|移动与转向|WASD、鼠标|
|自由巡检下降、上升|Q、E|
|释放鼠标|Esc|

## 场景编辑

`TwinArch` 下可逐块选取铺面、断栏与拱圈，原桥体为 `WortmannSpan`。`NorthAbutment` 管理残柱和靠岸踏石，`WaykeepersTools` 管理灯旗和修石工具。`Woodland` 内分河床、水、岩块、林木及岸边植被；`WalkableCrossing` 包含桥面、岸坡和栏边碰撞。`Inspection` 复用随包的巡检场景。主要建筑与布置集中在约八米长的短跨及两端，外围岸线、树木和坡地作为视点背景。

## 实机图与阶段

|阶段|总览|近景|过渡|
|---|---|---|---|
|交付场景，修复后|[总览](captures/repair/overall.png)|[北桥头](captures/repair/close.png)|[南岸](captures/repair/transition.png)|
|初稿，修复前|[总览](captures/draft/overall.png)|[北桥头](captures/draft/close.png)|[南岸](captures/draft/transition.png)|
|石桥材质与工具小样|[总览](captures/study/overall.png)|[近景](captures/study/close.png)|[过渡](captures/study/transition.png)|

各图均为重新加载保存场景后的 1280×800 Godot 捕获。初稿场景及当时的可变依赖保存在提交 `db5e0e4`，修复后场景对应 `4b16747`。在本包的协调渲染环境中，导入运行 `python3 render.py import`，复拍运行 `python3 render.py capture draft.tscn captures/local-check`；每次复拍使用新的输出目录。

[参考依据](RESEARCH.md) · [素材与许可](ASSETS.md) · [看图自查与剩余问题](REVIEW.md)
