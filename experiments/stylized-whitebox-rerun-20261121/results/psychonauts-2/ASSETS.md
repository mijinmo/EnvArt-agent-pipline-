# 素材与试装

| 来源与作者 | 实际文件与适配 | 使用范围 |
| --- | --- | --- |
| Kenney，Space Kit 1.0。[发布页](https://opengameart.org/content/space-kit) · [免费原包](https://opengameart.org/sites/default/files/space-kit-1.0.zip) | 检查 Models 下 OBJ/MTL 的各材质面、法线、UV 与顶点界限。选用舱段、金属踏板、仪器台、管、碟形天线与模型飞船。舱段原尺寸约 10 × 10.37 × 10 单位，在小样中宽 3.65 m。 | CC0，可改作、商用、再分发。包内许可保存在 art/licenses/Kenney-Space.txt。 |
| Kenney，Furniture Pack 1.0。[发布页](https://opengameart.org/content/furniture-kit) · [免费原包](https://opengameart.org/sites/default/files/kenney_furniturePack.zip) | 桌、抽屉柜、敞架、木凳、收音机、灯、电视与天线。Vintage TV 原尺寸 4.1 × 2.7 × 2.7，正面朝 −Z，枢轴在角上。转为底心枢轴和 +Z 正面，烤入分材质的搪瓷、木色、金属色。保留原网格、法线与 UV，导出各自可复用的 GLB。 | CC0，包内许可在 art/licenses/Kenney-Furniture.txt。 |
| Poly Haven，Dimitrios Savva 摄影、Rico Cilliers 处理。[Concrete Floor Worn 001](https://polyhaven.com/a/concrete_floor_worn_001) · [许可](https://polyhaven.com/license) | 实际下载 1K Diffuse JPEG。约 3 m 取样范围，可见细划痕、斑驳与小孔。作为局部地面磨损调制，弧形嵌带与板间缝另行配色。 | 免费 CC0，可随工程分发。 |
| Poly Haven，Dimitrios Savva 摄影、Rico Cilliers 处理。[Wood Table 001](https://polyhaven.com/a/wood_table_001) | 下载并查看 1K Diffuse，原物理范围约 1.5 m。用于工作台面、展柜木边、墙裙和中跳台外壳，按表面方向投射，压低近景木纹对比。 | 免费 CC0，可商用及再分发。 |
| Google Fonts。[Lobster](https://github.com/google/fonts/tree/main/ofl/lobster) · [Barlow Condensed](https://github.com/google/fonts/tree/main/ofl/barlowcondensed) | 原版 Regular、SemiBold TTF。用于场景里真实安装的招牌、仪表和铭牌。 | SIL Open Font License 1.1。两份署名与许可随字体保存在 art/licenses。 |

### 小样选择

实际打开 captures/material-study 的三个固定机位。近景看清显像管中细线、木框凹槽、暖反射板与单件模型，选用这组比例。原桌与椅支撑清楚。整体图中原舱模像一个独立罩子，过渡图只看到绿侧板，决定放回后场，开口转向工作面并接入墙与棚线。金属踏板原中心是附透明网纹的薄片，改成闭合防滑嵌芯，原平面网格保留。原门和坡的饱和占位色在此阶段保留以对照。小样没有固定相机以外的补拍。

场景专用的钣金截面、印花、示波器曲线、仪表刻度和陈列组合由本次 Codex 辅助建模、绘制；未使用生成式位图或原游戏提取资产。原作图片只供研究。

### 可编辑文件

art/models 交付 Space Kit 的 buildingCorridorOpenEnd、metalTile、pipeStraight、consoleScreen、satelliteDishAntenna、spaceCraft1，以及 Furniture Pack 的 desk、kitchenCabinetDrawer、stoolBar、radio、televisionVintage、televisionAntenna、bookcaseOpen、lampRoundTable，均为单件 GLB。lampRoundTable 作为已检查的候选保留在小样阶段记录中；正式台灯按参考的铰臂轮廓制作。两套原包主要使用 OBJ 材质色，选中部件没有随包的粗糙度或法线贴图。闭合踏芯取代了 metalTile 的透明网纹，供三座跳台使用。

art/fixtures 保存压边构件与按工位分开的 Godot 场景。art/marks 的 SVG 是可编辑的印刷图与静态示波器信号；搪瓷、木饰面、暖色衬板和无描边照明各有独立材质。地面和木作原始 1K JPEG 位于 art/surfaces。各贴图保留 Godot 导入设置。
