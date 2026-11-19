# Sirocco Rotor Works · 东盆地叶轮检修站

Godot 4.7.2，Forward+ / Metal，1600 × 1000。此工程是 Sable 同输入续作的一组。沿用露天修理棚、白盒动线与三个相机。技能版本为本试验冻结时仓库中的 `skills/godot-envart`。模型与 effort 的运行元数据由总试验登记。

## 场所与参照

[09 号主参考](https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/757310/ss_ef49b11e14ab919a138a20739d50fd04fdd806ad.1920x1080.jpg)中，棚架占画面一侧，红环透空，黑色杆索在亮天空上可辨，悬挂小件在黄色舱壁前有清楚的剪影。地面大幅留空，远处紫灰岩的对比度很低。[00 号](https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/757310/ss_f7cf5d40340dfcfc534daff63be314fdbb9e6817.1920x1080.jpg)提供崖顶、台肩与非等距沉积层形的辅助依据。[15 号](https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/757310/ss_eef53ec54dda09b085b5435c276e9c765250fea0.1920x1080.jpg)中吊物与交叠杆件能说明作业方式。

起点全景中三只跳台完全裸露，门头、后墙与东墙重复同一块箭头。近景的磨轮和工具可以辨认，旁侧包箱遮住大片空地；缺乏在修的零件。原远岩浑圆而大块。把门后的棚设为风沙盆地中的叶轮检修站，来货、检查、吊修分别落在近处货箱、图纸工作台、后侧吊具上。固定门、墙、坡、跳台定义了在地设施的比例。

## 资产与表面

Quaternius 的 [Modular Sci-Fi Megakit](https://quaternius.com/packs/modularscifimegakit.html) 和 [Sci-Fi Essentials Kit](https://quaternius.com/packs/scifiessentialskit.html) 取自本机已有免费 Standard 文件。只采用实存的 glTF、二进制网格和底色贴图。两套 CC0 许可原文在 `baseline/assets/quaternius/`。保留 [Kenney Survival Kit](https://kenney.nl/assets/survival-kit) 的磨轮、器皿和卷包，许可在 `baseline/assets/kenney/Kenney_Survival_CC0.txt`。起点及继承资产的清单在 `provenance/`。本轮没有增加下载。游戏参考图权利归原权利人。

| 实际网格 | 适配与位置 |
| --- | --- |
| Door_Frame_Square、WallBand_Straight、Column_Pipes | 保留接边、法线、UV，将原 trim sheet 的凹槽、主面和色带分开重映射为海绿漆、暖灰板与陶土色。 |
| Prop_Crate3、Prop_Crate4 | 调整为三种高度的扁平货箱，压在三个原跳台的外形范围内。每个货箱、其封闭顶面与支撑均可独立检查。 |
| Prop_Fan_Small_Propeller、Prop_Clamp、Prop_Crate_Tarp | 原叶轮竖吊在滑轮与吊带下，钳具压在工作台上，防尘布箱放在吊装区地面。保留色图上的零件分区。 |
| 本组新制 | 转臂、支撑杆、滑轮组、吊索、检视灯和风向袋列在 `workshop/LiftingGear.gltf`；手绘标识与结构图、砂面、天空、盐生草簇与分层远崖均在 `workshop/`。 |

砂面以世界 XZ 对应 32 米整块地面，刻出断续轮压与风纹。切石材质用世界高度、横向偏移和局部断层衰减控制泥岩节理。`stone`、`seam`、`salt` 是三组色，`relief` 是纹层反差。天空贴图中的薄云与以上印记均为静态。墨线沿用起点的深度／法线屏幕着色器。Godot 的空间与逐片元计算参考[官方空间 shader 文档](https://docs.godotengine.org/en/stable/tutorials/shaders/shader_reference/spatial_shader.html)。

## 第一轮实机审图

[全景](evidence/pass01_overall.png)的货箱已形成前中后景，但前两箱反差过强。岩顶排得太齐，天空薄云在投影后成为很长的锯齿白带。[工位](evidence/pass01_detail.png)能辨认起吊叶轮、支柱和箱盖；叶轮过浅，吊灯横穿拆装图，面板上的大片同色区域降低了读图层次。[门洞](evidence/pass01_transition.png)中招牌可读，下面的大块面板与门芯仍像一张平板，远墙的小字刚好切在门楣上方。

第一轮存档为 `pass01.tscn`。初次图形请求排队 100.60 秒，读取到两处缺前导零的小数，加载失败，无截图；修正后重开加载，再排队 109.99 秒，以 Metal 实拍三个固定机位。17 个原碰撞体的简表与三个相机简表逐字节等同起点。未做额外艺术预拍。
