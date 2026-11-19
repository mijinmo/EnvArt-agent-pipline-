# 素材与小样

## 来源和许可

采用 Quaternius 的 **Modular Sci-Fi MegaKit / Standard** 建筑和设备、**Sci-Fi Essentials Kit / Standard** 家具及周转件。两包各自的 License_Standard.txt 均明确 Standard 免费，允许按 CC0 1.0 使用、改造、再分发和商用。实际下载的是下列 glTF 系列和对应二进制、图集；PRO / SOURCE 及其示例工程不在取材范围。原许可见 licenses/MegaKit-CC0.txt 和 licenses/Essentials-CC0.txt。[建筑作者页](https://quaternius.itch.io/modular-sci-fi-megakit) · [道具作者页](https://quaternius.itch.io/sci-fi-essentials-kit)

文件来源为公开模型目录中两个同名 Standard 目录，下载固定于 db3df04d1e4714298a09510b26fb6de6645138a2，使用 glTF/Walls、Platforms、Props 和 Essentials 的 glTF。镜像的 MegaKit 目录缺少贴图，同作者配套 Essentials 提供了 Trim 01、02、03 的同名法线、ORM、颜色图及线缆图。02 的红色版本使用同图集的普通配色，去除缺图的原装饰贴花，控制器屏面另作处理。[固定文件目录](https://github.com/agentkaerf/FreeModels/tree/db3df04d1e4714298a09510b26fb6de6645138a2)

| 来源 | 实际选择 | 几何 / 材质处理 |
|---|---|---|
| MegaKit 建筑 | WallAstra_Straight、WallAstra_Straight_Flat、WallBand_Straight、TopCables_Straight、Door_Frame_Square、Platform_Squares、Platform_Metal2、Platform_CenterPlate | 4 m 墙段按原表面方向拼接，把墙面和灯的锚点移至安装位置。门槛低面顶点压至地坪以下。保留压筋、UV 和法线，地板原件是无厚度的向上覆面。 |
| MegaKit 设施 | Prop_Computer、Prop_Barrel_Large、Prop_Light_Wide、Prop_Vent_Wide | 保留屏幕外壳、桶箍、灯座和百叶；重新指定发光。 |
| Essentials | Prop_Desk_Medium、Prop_Chair、Prop_Mug、Prop_Chest、Prop_Locker、Prop_Shelves_ThinShort、Prop_Crate_Tarp | 保留多材质网格、原 UV 和可拆部件。原桌约 2.84 × 1.03 m、高 0.94 m。原椅高 1.64 m，装配时缩小。 |
| 两包表面 | Trim_01、Trim_02、Trim_03、Props_Batch2、Props_Crates | 在 art/surfaces 保留彩色、切线法线与 ORM 的对应关系。颜色按亮度映射至钢蓝 / 灰白，红色机械色带转橙黄，货物蓝篷布转青绿。缩至最长边 1024，降低法线、金属性，保留材质角色。 |
| 现场字样 | Barlow Condensed Bold Italic，IBM Plex Mono Medium | 用于自制标牌和读数。随附两份 SIL OFL 1.1；排版与图案为本局部绘制。[Barlow 字体源](https://github.com/google/fonts/tree/main/ofl/barlowcondensed) · [Plex 字体源](https://github.com/google/fonts/tree/main/ofl/ibmplexmono) |

## Godot 小样决策

A 与 B 都在实长右墙相同位置布置一整排面板、桌椅、终端、杯和周转盒，沿用固定 props / close 距离与顶灯。A 的 Astra 锥肋从墙上突出，多次从桌后露出白尖，占据将来管线安装的位置。B 的 Band 接缝可读，较平整，允许用真管件及仪表给墙面分组。两组反复出现的细竖槽和下沿仍可见，后续让管架、底裙和转角打断长墙。

B 另有同灯、同材质、同模型的无印刷处理对照。对照中的椅脚和桌角靠明度划分；B 在椅背、终端边缘和线槽间增加细墨线，暗处可见点阵，远处光斑基本保留。采用 B 的墙与描线，把 A 的压肋用于次要墙段。三个样片的桌面、地面都偏亮，近景周转盒的分离部件在桌面上方看似悬空。正式局部需收光并落稳道具。[A 全墙](captures/sample-a/props.png) · [B 全墙](captures/sample-b/props.png) · [B 近看](captures/sample-b/close.png) · [相同 B 场景关闭印刷处理](captures/sample-b-control/close.png)

art/press_ink.gdshader 的 line_weight 控制几何交界的墨色，print_strength 控制阴影中的点阵 / 斜线。依赖 Forward+ 的法线和深度缓冲。

## 正式装配与终版专用资源

公开镜像的这两个 Standard 目录分别列有 190 和 37 个 glTF。上述数字是目录清单，实际使用的文件族见表。工作间内可辨认的门框、面板、线槽、地板、桌椅、立式控制器、柜、灯、篷布货物与周转箱均来自这两包。Platform_Metal2 保留为备选地面。主体使用 Platform_Squares 与 CenterPlate 的配色变体。

DeckSlate、DeckInset、WallBlue、WallRib、WallReturn、GateFrame、WorkDesk、WorkSeat、StorageCabinet 共用对应原件的二进制几何，分别调整材质因子。TransitCase 由 Essentials 的 Prop_Chest 箱体与盖静态装配，终版按导入后网格世界包围盒校正底高。OperatorChair 共用 Prop_Chair 的网格与图集，分开皮垫和支座的颜色。

管路须对接本白盒特定的墙、阀与表组，使用本组绘制的弯管 OBJ、法兰和支承。仪表外壳、手轮、圆表、替换滤芯、门口导向、冷机标识、FLUX 叶轮标志及 BLEED THE LINE 海报均为本组设计。海报轮阀、屏幕曲线、刻度、移交单和地面漆直接制作成纹理，场景内可逐件编辑。冻结游戏画面仅供参照。
