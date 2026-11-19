# 素材与适配

## 下载内容和许可

下表数量按实际下载的 ZIP 中独立 GLB 计。只交付场景用到的派生模型、贴图和许可。三个 Kenney 包都有独立下载，无需购买合集。包中同时含 FBX、OBJ、预览图和调色板。CC0 允许修改、商用和再分发。包内许可原文与 CC0 全文在 [art/licenses](art/licenses/)。

| 作者、免费包 | 实际核查 | 本局部取用 |
| --- | --- | --- |
| Kenney · Fantasy Town Kit 2.0，167 个 GLB。[作者页](https://kenney.nl/assets/fantasy-town-kit) · [作者上传的 ZIP](https://opengameart.org/sites/default/files/kenney_fantasy-town-kit_2.0.zip) | 木墙和灰泥墙共用一米单元并带端柱。另含窗、屋顶、搁架、摊位和木板。 | 小样中 wall-wood → BoardBay，wall → LimeBay，stall-bench → TrestleTable。 |
| Kenney · Pirate Kit 2.1，72 个 GLB。[作者页](https://kenney.nl/assets/pirate-kit) · [作者上传的 ZIP](https://opengameart.org/sites/default/files/kenney_pirate-kit_2.1.zip) | 打开的板箱有内底，箍桶有分面桶壁和两道突出的箍。包内也有船、码头和工具。 | crate → LandingBox，barrel → BrineCask。 |
| Kenney · Food Kit 2.0，200 个 GLB。[作者页](https://kenney.nl/assets/food-kit) · [作者上传的 ZIP](https://opengameart.org/sites/default/files/kenney_food-kit.zip) | 整鱼、砧板、剁刀、贝类是可分开使用的模型。 | fish → SilverCatch，cutting-board → ButcherBlock，cooking-knife-chopping → Cleaver。 |
| Dimitrios Savva 摄影、Rico Cilliers 处理 · Weathered Brown Planks。[材质页](https://polyhaven.com/a/weathered_brown_planks) · [1K 漫反射原图](https://dl.polyhaven.org/file/ph-assets/Textures/jpg/1k/weathered_brown_planks/weathered_brown_planks_diff_1k.jpg) | 1.8 米宽的旧横板。免费取得 1024×1024 JPG。 | 抑制细纹、压缩明度并调成偏中性的 SaltBoards；从单块板取样生成 SawGrain。 |
| Rob Tuytel · Cobblestone Floor 03。[材质页](https://polyhaven.com/a/cobblestone_floor_03) · [1K 漫反射原图](https://dl.polyhaven.org/file/ph-assets/Textures/jpg/1k/cobblestone_floor_03/cobblestone_floor_03_diff_1k.jpg) | 2.4 米宽的石铺地。免费取得 1024×1024 JPG。 | 保留大石块轮廓，滤去颗粒并重画灰褐明度，成为 QuaySetts。 |

Poly Haven 两张素材按其公开的 CC0 授权使用。此次只取漫反射通道，两张图均为不透明表面，粗糙度按木、石和金属另设。[Poly Haven 许可](https://polyhaven.com/license)

## 导入检查

Kenney GLB 的源 UV 取样共享颜色表，带模型法线。原墙占 X=0.4 至 0.5，长和高各 1 米。移轴至底边中心，保留柱与内板的厚度差，再按白盒做成 2.5 × 3.14 米开间。源台凳长 0.94 米、高 0.226 米，取其立腿、横档与上板做 3.06 × 1.02 × 0.93 米工作台。原鱼沿 Z 长 0.621 米，重配冷色皮肤、眼睛与金属感，交付模型长 0.71 米。木构按面方向重投 UV，铁箍、鱼皮和刀刃保留独立材质。改造后的 GLB 可直接在建模软件中编辑。

初次导入让几种模型在阳光下几乎全白，箱、桌和鱼背丢失了颜色关系。将色值写到各自 glTF 材质的底色，保留木纹 UV，再用新目录重拍了两套小样。最初的导入诊断图留在本组工作目录。

## 全墙小样

两套采用相同太阳、地面、四跨长墙和两跨折返。在同一位置摆入鱼、板、刀、台、箱和桶。

- A 的近图可以沿横缝看出木墙方向，绿色墙和暖木台容易分开。整墙图也暴露出相邻开间内反复出现的深色掉漆块。[整墙](captures/boards/props.png) · [近图](captures/boards/close.png)
- B 的浅面能衬出鱼的深背，木柱更突出，但两面整墙在台面上方形成一片过大的亮色。[整墙](captures/limewash/props.png) · [近图](captures/limewash/close.png)
- 采用 A 作棚下背板，保留 B 给门楼和库房窗间墙。用窗、托架和工作记录打断整墙的斑痕重复，保持跨距连续，仅在不同开间错开纹理起点。

## 场景里其余的素材

| 来源 | 包内文件 → 交付模型 | 适配和用途 |
| --- | --- | --- |
| Fantasy Town Kit | wall-doorway-square → OpenWeighGate | 按源模型的洞口、框边、侧柱分别映射宽高，保留方形穿口、柱内浅墙及 0.60 米进深。 |
| Fantasy Town Kit | roof-gable → GableCap、StoreRoof；roof → ShedSheet | 门楼与后库采用不同跨度的双坡构件。长棚使用单坡屋皮，移除了原屋面下的实心封山面，露出托臂。压暗檐边，并给顶面绘制红色金属咬口。 |
| Fantasy Town Kit | wall-wood → BoardBayB；wall-wood-detail-horizontal → BoardRailBay；wall-window-glass → SashBay | 错开板缝图的起点，保留横档和十字窗棂的实形。库房窗背另加深色窗面。 |
| Fantasy Town Kit | overhang → BracketShelf；planks → FloorBoards；lantern → WharfLight；chimney → Flue | 有托座的搁架、冲洗区木板和货运墩外皮。街灯裁去杆脚，留下金属灯罩和发光玻璃。烟道缩至后库屋脊尺度。 |
| Pirate Kit | crate-bottles → BottleBox；tool-paddle → Oar | 保留玻璃瓶与箱板的材质区分，木桨收在折返墙旁。 |
| Food Kit | mussel-open → OpenMussel；bowl → EnamelTray | 张开的贝壳用青黑外壳和暖肉色区分；压浅碗身，放在秤后的收样搁架。 |

弹簧秤、三点悬挂的秤盘、搪瓷吊灯、网片、浮标、盘绳、鱼段、提桶与系环是为本场景制作的独立网格，见 [art/tackle](art/tackle/)。近景印刷包括秤面刻度、鱼纹商号、收货黑板、装箱烙印和工位号。只在招牌与印刷品中使用字形，保留字号层级和刻度的原始像素文件。[印刷图版](art/print/) · [Barlow Condensed 来源](https://github.com/google/fonts/tree/main/ofl/barlowcondensed) · [Crimson Text 来源](https://github.com/google/fonts/tree/main/ofl/crimsontext)

两款字体的 SIL Open Font License 副本随项目保留。后景山脊、稀疏针叶树和云片用本场景的分面网格组成，远岸只作背景。冻结的 DREDGE 图片没有用作网格贴图或天空盒。

## Final 的独立资源

- [模型](art/final/models/)中的 Mackerel 沿用 Food Kit 的整鱼轮廓，将胸鳍贴向鱼侧，按鱼体纵轴展开自绘鲭纹、侧线、鳃盖和眼睛。SortingBench 保留原摊凳的托架，减薄上板，重做台面与板边 UV。木面从同一份 CC0 旧木板漫反射中分条取样，补画接缝、钉头和切痕。
- 同目录的门楼、屋顶、墙跨、桶、排水板和箱板沿用上表对应的 Kenney 模型。不同用途的木板各有色值，屋面另存暗红漆色。GableVent、GateLamp、PackingCloth、BoxIce、SlipsAndPencil 和远岸航标是本次自制补件。
- [终版图版](art/final/textures/)包含静态天空全景、鱼皮、窗上反光、木面、布纹和收货单。布条跨过台边，收货单放在秤旁；均为场景中的有位置和尺寸的物体。收货单沿用上述 OFL 字体。first 所引用的文件继续使用首轮版本。

