# 素材记录
使用 Kay Lousberg 的 [KayKit Space Base Bits 1.0](https://github.com/KayKit-Game-Assets/KayKit-Space-Base-Bits-1.0/tree/6dfbcac9927d06283752c4defd4882cfe0d29666)。作者免费公开包包含 glTF、OBJ、FBX 与共用色板。项目保留 glTF、关联 bin、UV 色板及 [作者许可](art/kit/LICENSE.txt)。CC0 允许商用、改作和再分发。

basemodule_A/B 原约 2 × 1 × 2 米，底部原点，按深度压薄作围护覆面。A 单个宽护板，B 双窄肋；同灯位、相同货件下查看两组 props 实图后选 A 作为长墙。B 保留给回墙。cargo_A_packed 与 cargo_B_stacked 原宽约 0.52 / 1.02 米，保留绑带轮廓。structure_low 作为检测台支脚，roofmodule_cargo_A 的仪器组件安装其上。containers_C 作待交接件。lights 是导入检查件。以上模型保留原 UV 色板和网格；地板、安装件、管道及工位标识为本组制作。
最终独立网格位于 art/final，由对应 glTF 的位置、三角面、法线、UV 转存 OBJ，V 坐标转换到 OBJ 约定。print.gdshader 的 enclosure 开关将围护压到蓝灰色阶，设备沿用共用色板；世界坐标排线、点阵及 ink.gdshader 外壳描边用于近看。诊断屏底图是本组 SVG，文字可在场景内改。
