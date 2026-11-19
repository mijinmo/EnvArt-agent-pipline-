# Aerie · 盐路七号修理棚

用 Godot 4.7.2 打开本目录的 [project.godot](project.godot)，F5 进入 [final.tscn](final.tscn)。修理棚、检修吊架、燃料交换站和货运踏台均可在场景树中单独选取。相机节点为 `overall`、`detail`、`transition`。第一轮保存在 [pass01.tscn](pass01.tscn)，首轮适配资源冻结在 `pass01_art/`。最终场景复用首轮仍适用的资产，另有 `final_art/`。

| 轮次 | 全景 | 工作台 | 门洞 |
| --- | --- | --- | --- |
| 起点 | [overall](evidence/start_overall.png) | [detail](evidence/start_detail.png) | [transition](evidence/start_transition.png) |
| 首轮 | [overall](evidence/pass01_overall.png) | [detail](evidence/pass01_detail.png) | [transition](evidence/pass01_transition.png) |
| 最终 | [overall](evidence/final_overall.png) | [detail](evidence/final_detail.png) | [transition](evidence/final_transition.png) |

## 从参考到局部

主图 09 的朱红大环、带状棚顶和黑色细杆索集中在车辆一侧，沙面与淡青色天空占据大片空白。00 的远岩有清楚的层理，亮度相近的小轮廓在远处仍能分层。15 补充了红白环、挑杆、旗和挂物的接合关系。人物与对话遮住了地面。对应原图及准确地址见[共用输入](../INPUT.md)。

起点已有环、黄布和一台磨轮。全景近处的坡台与跳台仍是一片裸色盒面，近景工具缺少待修部件，门洞内外又重复同一张路牌。我把这个地面局部作为旅人交卸箱货、更换冷却罐和拆修叶轮的盐路站。留出原门洞、跳台落脚面和阶梯净空。远岩仅作为站外布景。

## 两轮制作与读图

1. 首轮用 Quaternius 的门框、平台、货箱、风扇组件、线束、夹具与货架建立入站和检修两组作业。保留模块 UV、原法线与几何轮廓，将底色按部件重映射为青灰、珊瑚红、暖白或黄铜。顶部的轮组、吊带和斜撑把叶轮系在吊架上，工位台钳承托单独的叶片。增加有层理的台地、风纹、旗杆和三种不同用途的标牌。太阳从固定方向斜照，棚下环境光偏冷。首轮全景里货运用途已可辨，但十字形中台显得厚重，背景台地的暗线过重。工作台视图中吊物几乎碰到箱顶。门洞视图的深色铸件仍有大片空面，图后仅见空架。
2. 第二轮给原门柱装压力表、排气百叶、紧固件和序号牌。门洞后布置歧管接头、旋阀、冷却罐、备油和盐路图，近棚与门之间增加一片拼接布帆。中台改用真实系带帆布箱；东面转角用黄漆窗模组与红色压顶衔接工棚。缩小吊架下面的货箱，拉开叶轮与箱顶。工作台增加组合扳手、轴套与磨轮手摇柄。最终三图中能沿门框看到后墙补给，工位机位能辨出吊带、被拆叶轮和下方货箱的间隙。

最终全景仍显出场地试验坡道的直边和阶梯的规律间距。右侧窗面偏平，远柱的层理比参考图简化。工作台图中棚杆遮住工单的一部分，棚前红环在近景左端占比较大。门洞局部只能看到压力表的一部分。此次仅检查固定画面，尚待用户美术验收。

## 资源与编辑

| 实际取用 | 适配与落点 |
| --- | --- |
| Quaternius Modular Sci-Fi Megakit 免费缓存的 Door_Frame_Square、WallBand_Straight、WallAstra_Straight_Window、Platform_CenterPlate、Prop_Crate3 等 | 门框保留原折口，黄漆窗连成转角办公面；钢踏板按原坡台、阶梯的表面尺寸贴装。原白盒网格和碰撞体留在 World 下。中、高跳台的原 Mesh 保留在原位并隐藏显示，单独的美术实例匹配其外包尺寸。 |
| Quaternius 本地两个包内的 Prop_Fan_Small、Prop_Fan_Small_Propeller、Prop_Clamp、Prop_Cable_1、Prop_Crate、Prop_Crate_Tarp、Prop_Shelves_ThinShort、Prop_Ammo_Small、Prop_Barrel1、Prop_Barrel2_Closed、Prop_Vent_Wide | 拆为静态吊装件与台面工具，保留风扇原壳体、叶片、箱体织带、挂钩和折边。小器材盒用于表具收纳；原纹理转换为哑光色阶。保留原工位中的搪瓷桌、杯瓶和现有道具。 |
| Kenney Survival Kit 起点缓存 | 使用已有磨轮、工具卷、敞口箱、桶、瓶。手柄与轮缘圆环对准原轮轴；色板 UV 仍由原资产提供。 |

本轮使用仓库中实际存在的免费文件，没有下载新包。两个 Quaternius 包和 Kenney 资产均为 CC0。包内容、作者和来源见[起点授权与资源清单](provenance/README.md)。许可原文分别见 [Modular Sci-Fi](baseline/assets/quaternius/ModularSciFi_License.txt)、[Essentials](baseline/assets/quaternius/Essentials_License.txt) 和 [Survival Kit](baseline/assets/kenney/Kenney_Survival_CC0.txt)。

新增 glTF 中，`ServiceDavit` 是起重立架、滑轮与双吊带；`SplicedTransitFly` 是静止的拼接帆与支杆；`ExchangeCanopy` 包括薄檐、歧管及阀门；`CastPorticoPlates` 和 `BenchServiceHardware` 包括压力表、铸盖、扳手和轮轴。路线图、设备号牌、风轮标志均为本轮绘制。远景的堆积坡、岩帽和尖柱均以多截面网格造形。沙地、云与远岩皆未使用时间输入。

`drift.gdshader` 的 sand / crest / lee 控制底色、风脊和背风浅痕；`salt_render.gdshader` 的 plaster / plinth / repair 控制挡墙抹面、墙脚与局部修补；`sky.gdshader` 的 horizon / zenith / cloud 控制晴空与静止薄云。最终的 `distance_ink.gdshader` 继承起点的深度和法线描线，在远处减弱混合强度。共用墨色参数保持 1.12 像素采样宽度和 0.76 混合强度。两轮同时改动了造型、布景及材质，图像用于比较整套美术处理。[Godot 空间 shader 文档](https://docs.godotengine.org/en/stable/tutorials/shaders/shader_reference/spatial_shader.html) · [天空 shader 文档](https://docs.godotengine.org/en/stable/tutorials/shaders/shader_reference/sky_shader.html)

## 运行记录

两轮美术制作，每轮保存并重开场景以 Metal Forward+ 拍摄三个 1600 × 1000 固定视点。首轮提交 `5e7f8d6`，最终提交可用本目录中的 `git log -1 -- final.tscn` 查询。两份输出的 17 个 StaticBody3D、子网格及碰撞、三个相机参数均与冻结的起点清单逐字段一致。140 个冻结输入的 SHA-256 全部一致。

共启动五次串行截图。首轮第一次因 TSCN 颜色参数省略小数前的零而解析失败，无图；修正后首次成功。尺寸核对发现阶梯钢面比原踏步宽，收回到 2 米范围后技术重拍并冻结首轮。最终轮首次出图后，在核对桌面标高时发现一根细杆穿过工作台，将杆底截至台面 0.809 米并技术重拍。五次锁等待依次为 0、3.94、0、0、0 秒，合计 3.94 秒。首轮文件及最终文件各保留一套三图。制作使用仓库 2026-11-19 工作树中的 godot-envart 技能，模型档位以父实验的运行元数据为准。
