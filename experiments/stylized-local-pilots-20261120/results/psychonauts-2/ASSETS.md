# 素材与试装

| 来源与作者 | 实际免费文件与适配 |
| --- | --- |
| [Furniture Kit，Kenney](https://opengameart.org/content/furniture-kit) · [下载包](https://opengameart.org/sites/default/files/kenney_furniturePack.zip) | 使用包内 Models 的 OBJ 几何。wall、floorFull、rugRounded 构成墙、地及毯；sideTableDrawers、cabinetTelevisionDoors、desk、bookcaseOpen 构成台架。televisionVintage、radio、books、cardboardBoxOpen 分别转为屏幕、接收器、日志和料箱。各自重设底部中心原点、尺度和材料。老电视正面原先朝 −Z，转至 +Z，单独投射屏幕 UV，机壳作轻微剪切。 |
| [Space Kit，Kenney](https://opengameart.org/content/space-kit) · [下载包](https://opengameart.org/sites/default/files/space-kit-1.0.zip) | buildingCorridorOpen 提供后墙拱罩。satelliteDish、alienBones、rocksOre、barrel、console、pipeStraight 是本次取样的实际模型。改成台架仪器、陈列件和设施零件。 |
| [Rosewood Veneer 1，Jenelle van Heerden](https://polyhaven.com/a/rosewood_veneer1) | 1K JPEG 的 diff、nor_gl、rough 三张，柜体、工作面、弯木包边共用。 |
| [Concrete Floor Worn 02，Dimitrios Savva](https://polyhaven.com/a/concrete_floor_worn_02) | 同三通道用于地面和墙板，墙板另调橄榄灰。 |

两份 Kenney 包的原许可证在 assets/licenses，均标明 CC0，允许商业使用和再分发。本站直连失败后从作者公开的 OpenGameArt 包核对实际 OBJ 和 License.txt。Poly Haven 表面贴图同属 CC0。[表面许可](https://polyhaven.com/license) · [CC0 法律文本](https://creativecommons.org/publicdomain/zero/1.0/)

原模型没有可用的写实 PBR 细节，OBJ 的平铺 UV 与法线随几何转入 GLB。木材和水泥按表面职责应用独立贴图，使用 OpenGL 法线并减弱强度，粗糙度取灰度图绿色通道。原电视包围盒约 4.10 × 2.70 × 2.70 源单位，改成约 1 m 宽的设备；前脸和旋钮材料分开。模型没有依赖透明排序。

**看图选择**见 captures/material-study。单台、后墙、地面、展盒和表头已在相同空间试装。保留拱罩、实木边、金属壳和亮布衬的分工。红木和空白收音机面板需要适配。选择老电视的厚外壳，舍弃原包的薄平板 computerScreen。贴身表头、折臂灯、黄铜卷边、波纹毯印花及仪表盘由本项目制作。字体仅栅格化进铭牌，为 Barlow Condensed（Jeremy Tribby，SIL OFL）。[字体来源](https://github.com/google/fonts/tree/main/ofl/barlowcondensed)

小样阶段将 overall 移至较靠中线，以同看柜台两端；close 对准右台的刻度和电极；transition 从左前方平视相邻台段。views.json 从本阶段起冻结。

**定稿装配。** 来访者左侧的收音喇叭和右侧的脑波校准仪为本项目造型，表针、弧形电极、双臂灯和独立铭牌均有实体几何。墙板、拱罩、地板、台柜、两侧货架和可辨认的展品仍使用上述下载模型。资产与其贴图共同保存在 assets/models、assets/surfaces、assets/graphics。收音机的调谐带、扬声器孔布、接线图、蓝图卷和仪器上的字样均为项目内绘制。另取 Furniture 包的 cabinetBedDrawer，作为左右台下零件抽屉。

柜台用 fumed-veneer.jpg 派生自原玫瑰木漫反射，保留纹理走势，旋转、抑制高频并重染为灰褐。展盒边缘保留较暖的原色。贴图过滤和管道回弯的修改对应 REVIEW.md 的同机位复拍。阶段提交保留小样与初稿当时的所有依赖和照片。
