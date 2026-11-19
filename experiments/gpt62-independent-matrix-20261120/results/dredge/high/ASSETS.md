# 岸上称量所 · 素材账

三个下载均来自作者 Kenney 在 OpenGameArt 发布的免费包。各包随附的原文 License.txt 在 art/town、art/pirate、art/food 内。CC0 1.0 允许修改、商业使用及随项目分发。本项目只提取用到或实际试样的部件。压缩包保留在私有工作目录。

| 包和下载 | 实际免费内容及本项目用途 |
| --- | --- |
| [Fantasy Town Kit 2.0](https://opengameart.org/content/fantasy-town-kit) · [ZIP](https://opengameart.org/sites/default/files/kenney_fantasy-town-kit_2.0.zip) | 检查 Models/OBJ format 中的半木结构灰泥墙、木墙、窗板、坡屋面、板面、摊凳、柱和灯。墙段纵向长 1、高 1、平墙厚 0.10，模型枢轴在原格中心，墙实际偏到 x=0.4..0.5。 |
| [Pirate Kit 2.1](https://opengameart.org/content/pirate-kit) · [ZIP](https://opengameart.org/sites/default/files/kenney_pirate-kit_2.1.zip) | 实包有船、栈台、城堡、桅杆、桨、岩石和物资。barrel 高 1.229、宽 1.336，独立箍圈；crate 高 0.770，四角立柱高出台边。 |
| [Food Kit](https://opengameart.org/content/food-kit) · [ZIP](https://opengameart.org/sites/default/files/kenney_food-kit.zip) | 实包有整鱼、鱼骨、贝、案板和料理刀等 OBJ。fish 长轴沿 Z，长 0.620、高 0.322；侧放后按鱼身厚度落案。 |

## 导入与适配

所选 OBJ 转为 art 下同名 glTF。保留原三角面、面法线和材料分区，重定底部中心轴。原有 UV 主要从 colormap.png 的色格取色，缺乏可连续平铺的纹理坐标。按原色格区分抹灰、板面、骨架、桶箍、鱼背和鱼鳍，沿面主方向重新投影木纹或灰泥笔触。art/surfaces 为本项目绘制的色面纹理，无外部照片。硬面保留分面法线；鱼皮、铁箍用较低粗糙度。上述素材均为不透明表面。

## 整墙对照

同光、同机位、同台面与道具，在十米主墙和四米回墙上替换墙族。A 的浅灰泥凸显深柱和窗形，但近景跨数米的空白和浅黄台面黏连；其窗洞模块在小样中还露出过宽的深色衬底。B 的灰绿横板能衬出鱼腹，板缝在近景可辨，整墙连续使用时，亮色长划痕和等距双柱开始重复。主棚采用 B，回墙和门柱保留 A 的浅色以断开横向纹理，窗背衬后撤。对照实图见 [A](captures/sample-a/props.png)、[B](captures/sample-b/props.png) 及各自 close。

## 场景实装及最终副本

- 门墙及檐棚使用 wall、wall-wood、wall-wood-window-shutters、wall-window-small、wall-detail-diagonal、roof、pillar-wood。后场收边的烟囱使用 chimney-top。planks 用于作业地板与货箱盖，stall-bench 改为约 3.25 × 1.02 m 的操作台，stall-stool 保留为独立小凳。贴墙窗、板材与引入项目的其他待选模块可在 art/town 查看。
- 码头组使用 barrel、crate、crate-bottles、tool-paddle。鱼台使用 fish、cutting-board、cooking-knife-chopping、bowl、mussel、mussel-open。资源文件名对应包中 OBJ 的名称，导入后的模型可独立移动、缩放和替换。
- 作业灯、弹簧秤、滑轮、吊绳、浮子、网、抹布、门牌、秤面和业务记录为本组制作。art/final 下的鱼在原网格上收拢贴板一侧的鳍尖，侧面重新投影手绘鱼皮。该目录另存木墙、台面、屋顶与地板的配色副本、启用 mipmap 的字牌及远海全景。远海为背景，场内无水面碰撞。
- 牌匾使用 Barlow Condensed Bold 和 DM Serif Display Regular 的字形路径。字体来自 Google Fonts 公开目录，项目内分发的是 SVG 牌面。版权信息及 SIL OFL 1.1 原文随 art/lettering 保留。[Barlow Condensed](https://github.com/google/fonts/tree/main/ofl/barlowcondensed) · [DM Serif Display](https://github.com/google/fonts/tree/main/ofl/dmserifdisplay)
