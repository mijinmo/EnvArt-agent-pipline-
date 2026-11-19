# Brine Station · 岸上收鱼所
用 Godot 4.7.2 打开 project.godot，等待导入后按 F5 进入 final.tscn。5、6、7 分别查看门口、工作角、台面近景；1、2 切换玩家视角，3 自由相机。WASD 和鼠标移动与观察，Space 跳跃，Esc 释放鼠标。

门楼、沿墙木棚和称鱼台位于 Art 下，OBJ 实例可移动和缩放。BaseLab 保留原场地、碰撞与控制器。地板是干地；木板着色沿用原地面，跳台保留原有落脚面。远端围护只处理进入门口构图的立面，坡道等区域保留测试场体量。

|阶段|可打开的场景|固定机位截图|
|---|---|---|
|暖墙和灰石试装|sample_a.tscn、sample_b.tscn|captures/sample-a、captures/sample-b|
|首轮|first.tscn|captures/first|
|自主修订|final.tscn|captures/final|

终图里棚下台秤、浮具和整鱼形成收货工序。贴近看时，窗玻璃缺少反光，整片木铺地的色差较均匀；门后仓墙的纵深也较浅。三视图的判断见 REVIEW.md，出处与改造见 ASSETS.md。
