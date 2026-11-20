# 林地短石桥与残破桥头

Godot 4.7.2 · Forward+ · 室外环境局部 · `awaiting_user_calibration`

在 Godot 中打开本目录的 `project.godot`，等素材导入完成后按 **F5**。默认场景为 [revised.tscn](revised.tscn)。可单独打开冻结的 [draft.tscn](draft.tscn)，按 F6 查看原稿。角色位于南端桥面，启动视点为俯视总览。北岸残柱旁设有修石工具，另一侧的灯杆和太阳旗标出过桥方向。

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

## 本次限定修订

冻结稿左河的连续金带抢走了桥头的亮度，两岸草带在过渡视点连成一圈。修订版把林间暖光落在北端铺石、残柱和木桶上，沿暗水保留几组短反光，并从岸草之间露出岩面。近看浅石仍偏亮，水纹偏柔，远岸树形仍有重复。三机位复核后选用修订版作为 F5 入口。[协调反馈](COORDINATOR_REVIEW.md) · [看图记录](REVIEW.md)

## 实机图与阶段

|阶段|总览|近景|过渡|
|---|---|---|---|
|限定修订，当前 F5|[总览](captures/revised/overall.png)|[北桥头](captures/revised/close.png)|[南岸](captures/revised/transition.png)|
|冻结初稿，修复后|[总览](captures/repair/overall.png)|[北桥头](captures/repair/close.png)|[南岸](captures/repair/transition.png)|
|初稿，修复前|[总览](captures/draft/overall.png)|[北桥头](captures/draft/close.png)|[南岸](captures/draft/transition.png)|
|石桥材质与工具小样|[总览](captures/study/overall.png)|[近景](captures/study/close.png)|[过渡](captures/study/transition.png)|

各图均为重新加载保存场景后的 1280×800 Godot 捕获。初稿场景及当时的可变依赖保存在提交 `db5e0e4`，修复后场景对应 `4b16747`。在本包的协调渲染环境中，导入运行 `python3 render.py import`，复拍运行 `python3 render.py capture revised.tscn captures/local-check`；每次复拍使用新的输出目录。

[参考依据](RESEARCH.md) · [素材与许可](ASSETS.md) · [看图自查与剩余问题](REVIEW.md)
