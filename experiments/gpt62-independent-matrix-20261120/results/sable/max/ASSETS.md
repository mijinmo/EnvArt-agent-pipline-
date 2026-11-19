# 素材与改造

## 可再分发素材

- **KayKit Dungeon Remastered 1.0，Kay Lousberg。** 取自作者公开仓库的免费 GLB，版本 `b0ca9bd96a8072ab36a3a5464f00ed1e06a16d07`。下载目录实际包含独立的门、墙、地板、家具和容器。选取的原文件在 `art/sources/kaykit/`，运行用 OBJ 在 `art/meshes/kaykit/`。原包许可允许个人和商用、修改与再分发。未使用付费 Extra 或 Source 增补包。[作者仓库](https://github.com/KayKit-Game-Assets/KayKit-Dungeon-Remastered-1.0/tree/b0ca9bd96a8072ab36a3a5464f00ed1e06a16d07) · [随包 CC0 声明](LICENSES/KayKit-Dungeon-Remastered.txt)
- **Sandstone Blocks 08，Rob Tuytel / Poly Haven。** 免费 CC0，取 1K JPG 的 Diffuse、AO、Displacement、OpenGL Normal。漫反射给出石面明度，AO 与法线偏移挑出接缝、孔眼。检查高度图后，以平面贴图和模块本身的倒角保留尺度；没有向通道挤出几何。原版 3 m 宽，试片按 3 m 平铺。[素材页](https://polyhaven.com/a/sandstone_blocks_08) · [许可](https://polyhaven.com/license)
- **Aerial Sand，Rob Tuytel / Poly Haven。** 免费 CC0，取 1K Diffuse、Displacement 的凹痕与受压沙地信息，压成低反差暖色，斜转映射方向。两套实测表面的原始 JPG 在 `art/sources/poly_haven/`，转换贴图在 `art/surfaces/`。[素材页](https://polyhaven.com/a/aerial_sand) · [CC0 正文](LICENSES/CC0-1.0.txt)

两套实测材质的下载文件与校验值可在作者文件清单按 `1k/jpg` 定位。[砂岩原文件](https://api.polyhaven.com/files/sandstone_blocks_08) · [沙地原文件](https://api.polyhaven.com/files/aerial_sand)

## 模型检查

| 原件 | 原始包围尺寸，宽 × 高 × 深，m | 适配 |
| --- | --- | --- |
| wall、pillar | 4 × 4 × 1、1.5 × 4 × 1.5 | 保留墙根、挑檐与独立凸石，沿白盒墙跑向排段，柱当转角收口。 |
| wall_doorway | 墙框 4 × 4 × 1 | 门扇是单独带铰点的子网格。抽出石框，调整内外门垛与厚度，另存 portal。 |
| table_long | 2 × 1 × 4 | 实木板台面与两副桌腿保持成套，适配到 0.87 m 操作高。 |
| barrel_small、box_large | 1 × 1.02 × 1、1.5 × 1.5 × 1.5 | 依据绑定箍、木板、扣边的原 UV 岛换色。保留顶盖和侧边的几何。 |

GLB 的模型法线和 UV 保留，原点移到底面中心。原始 1024² 渐变图集使用 UV 岛区分木料、金属和织物，重新配色成 `freight_palette.png`。上述模型为不透明表面，原包没有独立的法线或粗糙度贴图。砂岩饰面使用世界米制投影，避免随模块缩放拉宽石缝。

## 引擎小样与选择

两个样片共用机位、物件、场地、日光、填充和色系。A 用连续漫反射和保留晕染的砂岩；B 用同源的石缝与崩点提色、分段漫反射，并按深度和法线变化落一层细线。这是两套材质处理的整体对照。[A 全墙](captures/sample-a-wash/props.png) · [B 全墙](captures/sample-b/props.png)

逐张检查两套的 door、props、close。A 近景中，石块上的云斑比前方木箱的板面信息更密；桌板之间缺少清楚的分界。B 能读出桶盖外圈、木台拼板和门框内缘，门洞在远处也有完整细线，采用 B。两套都暴露出连续模块上的凸石反复成对出现，B 的大块纹理叠在凸石后尤其明显。正式墙面将保留低处石基，在主要操作面使用灰泥、悬布和接缝收边。[A 近景](captures/sample-a-wash/close.png) · [B 近景](captures/sample-b/close.png)

`relay_surface.gdshader` 的 `meters_per_tile` 决定世界映射尺度，`band_mix` 调节明暗分段，`sheen` 控制金属的小面积亮部。`pen.gdshader` 的 `density` 调节结构边的深浅。空间着色与屏幕深度读取遵循引擎接口。[空间着色器](https://docs.godotengine.org/en/stable/tutorials/shaders/shader_reference/spatial_shader.html) · [深度纹理](https://docs.godotengine.org/en/stable/tutorials/shaders/advanced_postprocessing.html)

## 首轮用件

| 原包中实际文件 | 在驿站的作用 |
| --- | --- |
| floor_foundation_allsides、floor_wood_large | 跳台石座、顶板和盐袋托盘分件落位。跳台顶面按原白盒标高封口。 |
| floor_tile_large、floor_tile_big_grate | 门口铺板和靠侧门垛的集砂格。 |
| keg、stool、shelf_small、bottle_B_green、bottle_A_labeled_green | 配水桶原有横桶、鞍座和桶箍，另加出水嘴；凳、托架、带标签的瓶与宽腹瓶保留原件比例关系。 |
| wall 的一版分件 | 以连通面选出原墙的主体，在灰泥段去掉成对的凸砖；原来的墙脚和上部挑出依然存在。另存 `rendered_wall.obj`。 |

**Quaternius 的 Bag 与 Bag Open。** 两个独立公开下载的 CC0 GLB，原件在 `art/sources/quaternius/`。前者是放倒的软袋，后者含袋壳与独立的内容物网格。解析原有轴向 / 单位变换，按接地中心归一，以一米宽为基准；两者宽高深比约为 1 × 0.38 × 0.71、1 × 0.70 × 1.35。原件为不透明单色网格，无 UV。为布料补环形 UV，将敞袋的填料作粗盐。色带、袋印与盐晶肌理为本次绘制。[Bag 原页](https://poly.pizza/m/VRfAODZ0Xk) · [Bag Open 原页](https://poly.pizza/m/rJuZexcuhU) · [CC0 正文](LICENSES/CC0-1.0.txt)

**Barlow Condensed SemiBold，The Barlow Project Authors。** 从 Google Fonts 开源目录取 `BarlowCondensed-SemiBold.ttf`，用于搪瓷门牌、舆图、票据与表盘的烘印。原字形文件和 OFL 声明随包保留。项目文字、燕形驿印、地图与图案为本次设计。[字体原件](https://github.com/google/fonts/tree/main/ofl/barlowcondensed) · [随包 OFL](LICENSES/Barlow-Condensed-OFL.txt)

针对称量台的功能缺口，另作机械秤壳、镶圈、刻度盘、可单独旋转的指针、铜盘、检重砝码与封签包。遮阳帆、包边绳、挂绳、陶壶、手章、票据和织毯均可在子场景或网格里独立选取。远景为天空材质上的分层盐碱台地，未用冻结截图作贴图。

## 修订用件

**Pipes，Quaternius。** 为桶上方的配水接口选取该作者公开的单个 CC0 GLB。原件是两根带弯头的平行直管，另有一组接头材质。保留管身和管箍的两组原网格与法线，转正轴向，竖装成 1.49 m 长的双管，并将两组改为哑光蓝绿和铜色。轮阀、加注软管和有水滴标记的检查盖按装配位置另作。原件位于 `art/sources/quaternius/Pipes.glb`。[素材页](https://poly.pizza/m/GB6AFkoiZb) · [作者发布的 GLB](https://static.poly.pizza/ab52d5ee-95b3-4842-b2b8-27151a67275b.glb) · [CC0 正文](LICENSES/CC0-1.0.txt)

终版另存一套用于远近观察的印刷纹理。地图沿用三个站点并加宽路线，表盘减少细分刻线，吊签改为可从秤前看到的正面纸片。终版门牌、挂图、布料等印刷表面单独导入 mipmap。首轮资源保留原图案与原导入配置。[首轮近景](captures/first/close.png) · [终版近景](captures/final/close.png)
