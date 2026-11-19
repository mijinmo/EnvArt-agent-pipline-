# 盐路七号 · 素材与小样

## 免费素材范围与来源

建筑与实物道具来自 Kay Lousberg 的 **KayKit Dungeon Remastered 1.0**。取自作者公开仓库的 OBJ 子目录，版本 `b0ca9bd96a8072ab36a3a5464f00ed1e06a16d07`。检查了实际 OBJ、MTL 及 `dungeon_texture.png`。此目录同时提供墙段、家具、瓶罐、箱桶、地板、旗帜等；本项目只交付下列选用件的 GLB 改件。作者在包内注明 CC0，可商用、修改与再分发。许可保存在 [KayKit-Dungeon-Remastered.txt](art/licenses/KayKit-Dungeon-Remastered.txt)。[公开源文件目录](https://github.com/KayKit-Game-Assets/KayKit-Dungeon-Remastered-1.0/tree/b0ca9bd96a8072ab36a3a5464f00ed1e06a16d07/addons/kaykit_dungeon_remastered/Assets/obj) · [作者产品页](https://www.kaylousberg.com/game-assets/dungeon-remastered)

| 实际源 OBJ | 项目 GLB（art/models） | 使用和适配 |
| --- | --- | --- |
| wall、wall_arched、wall_pillar | DressedAshlar、BlindRecess、BondPier | 原件主跨为 4 × 4 m，墙体含上下束带及外凸小石块。右墙按三跨排满 10 m。平面投影换成灰泥或浅砌石印纹。 |
| wall_doorway_sides | WeighGate | 保留拱形石肩和独立侧墩，沿厚度压到门框附近。 |
| floor_tile_large | YardPavers | 4 × 4 m 拼石源件，保留不规则板边，用于门槛与地面。 |
| table_long、stool | Trestle、ClerkStool | 桌源件 2 × 1 × 4 m，实际缩为窄面作业台；凳随人体尺寸。 |
| box_large、box_small_decorated、trunk_medium_A | SlattedCrate、OpenConsignment、TransitTrunk | 1.5 m 货箱、开顶配货件及带箍小箱。按源色区区分木板和蓝绿色包角。 |
| barrel_large_decorated、bottle_A_labeled_green、bottle_B_brown | CooperedCask、SampleFlask、StopperedJar | 原桶含桶顶小物，源高 2.55 m；桌面瓶原高约 0.89 m。分别按货桶和手持容器缩放。 |

源模型顶点法线与独立部件保留，支点统一至底面中心。原 UV 采样的是颜色渐变图集；木、瓶与铁件的色区从图集提取后转成材质色，木件另用本组的细纤维纹。原包此组 OBJ 的 MTL 只有一张漫反射图，无独立法线、粗糙度或透明遮罩。另检查了独立柱、小地砖和长条纹样挂旗的原始尺寸。BondPier 保留作柱式墙段候选，成景使用清理后的直墙。

## 全墙小样

两间小样复用同一处白盒右墙、家具摆位、日光和墨线。A 用暖灰泥拱龛，B 用浅砌石直墙。首次提交给引擎的顶点色方案在桌面及瓶身大面积发白，已改成显式材质色，在新证据目录重拍；原始技术图保留于 `captures/sample-a` 和 `captures/sample-b`。

| 重开场景 | 已查看的画面与决定 |
| --- | --- |
| [sample_a.tscn](sample_a.tscn) · [全墙](captures/recess/props.png) | 大拱龛从桌后延伸到回墙，每跨都出现相同拱肩。暖灰泥与木桌在阳光里靠得很近。 |
| [sample_b.tscn](sample_b.tscn) · [全墙](captures/ashlar/props.png) · [近景](captures/ashlar/close.png) | 错缝横带让人看得出石块尺寸，蓝绿桶箍与木桌面能分开。选 B。凸出的短砖有些横跨缝线，正式墙体将保留原墙段底座及冠部，去掉平墙上的独立装饰砖。 |

## 正式局部的改件与本组制作

- `AshlarBay` 和 `RoadArch` 分别取自 `wall.obj` 与 `wall_doorway_sides.obj`。按连通面保留含基座、墙身、冠部的主件，剔除表面散布的装饰石片。门拱外套、路牌和有分段的金属内衬另建，最终净口为 1.2 × 2.3 m。
- `art/models` 中的双盘秤、砝码盒、车轮与车架、封签单、小袋、卷布、绳结、棚、铺毯、管件与跳台包面均为本组适配此处尺寸制作。木桌、凳子、箱、桶、瓶的主体使用上表的下载模型。
- `art/prints` 的砌石、沙地、布纹、秤盘刻度、盐路图记、货签、运单与搪瓷字牌均在本组绘制。字样使用 The Barlow Project Authors 的 **Barlow Condensed SemiBold**，来源文件为 `BarlowCondensed-SemiBold.ttf`，按 SIL Open Font License 1.1 使用。项目交付栅格字样及 [字体许可](art/licenses/BarlowCondensed-OFL.txt)。[字体源目录](https://github.com/google/fonts/tree/main/ofl/barlowcondensed)
- `art/ink.gdshader` 从屏幕深度跳变和相邻法线的折角提取细线，`strength` 控制墨色强度。对照场景只关闭 `Art/InkContours`。同一台面在对照中仍有木色和投影；加线后，桌脚交叉处、瓶肩和暗墙上的凸缘更容易分开，远处接缝也稍显碎。保留细线版。[同构图常规材质对照](captures/ashlar-control/props.png) · [有墨线的小样](captures/ashlar/props.png) · [Godot 空间着色参考](https://docs.godotengine.org/en/stable/tutorials/shaders/shader_reference/spatial_shader.html)
- `art/distance.gdshader` 绘制露天背景的低矮分层地平线。冻结截图仅供观察，场景材质均取自上述授权素材或本组制作。
