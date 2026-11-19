# 07 · Cell Exchange

工业设施里的电芯交接角。门前的黄色导向绕开原有跳台，穿过人员门后，右墙的确认终端、夹取工位、压力分配箱和出库托盘构成一段连续的交接流程。

## 打开与试玩

用 Godot 4.7.2 打开 [project.godot](project.godot)，资源导入完成后按 **F5** 进入 [final.tscn](final.tscn)。启动时从门外观察。

|按键|作用|
|---|---|
|5 / 6 / 7|门洞 / 工作角 / 设备近景|
|1 / 2|第一 / 第三人称玩家|
|3|自由相机|
|WASD、鼠标、Space、Esc|移动、转向、跳跃、释放鼠标|

想改门套、滚筒、机械臂或周转箱，可以在 final 的 `Art` 下展开 `PersonnelGate`、`InspectionCell` 和 `OutboundCases`。灯位在 `PracticalLighting`，屋面灯体在 `RoofAndServices`。场景继承 whitebox，`BaseLab` 继续承载原控制器与碰撞。

## 场景和实图

|阶段|可检查内容|
|---|---|
|参考方向 · `6e12bf9`|两张冻结图的观察与本站的设计假设。[RESEARCH.md](RESEARCH.md)|
|素材小样 · `c596817`|相同墙跨、道具、光照下的连续材质和漫画描边。[A](sample_a.tscn) · [B](sample_b.tscn) · [选材记录](ASSETS.md)|
|首轮 · `8f9ab93`|独立冻结的 [first.tscn](first.tscn) 与三机位实图。[门洞](captures/first/door.png) · [工作角](captures/first/props.png) · [近景](captures/first/close.png)|
|最终|门柱、绕行地坪、管道下接、机械关节和放行终端经一次自主修订。[门洞](captures/final/door.png) · [工作角](captures/final/props.png) · [近景](captures/final/close.png)|

本组 GPU 导入与所有实图均使用 `python3 render.py`。复拍可运行 `python3 render.py capture final.tscn captures/my-review`，使用尚不存在的输出目录。本次固定出图为 Metal Forward+、1280 × 800。

## 范围与可见不足

门洞保持 1.2 × 2.3 m 净空。整体场地、坡道外侧和工作角以外仍按白盒处理，props 右缘能看见外侧网格。近景里的细小铭牌仍比主屏难读，机械臂轮廓比参考中的设备更规整。诊断、修订效果和终端 UV 技术修复见 [REVIEW.md](REVIEW.md)。
