# 盐路修理棚

Godot 4.7.2 Metal Forward+。试作模型 gpt-6.2-astra，启动时未显式指定 reasoning_effort，沿用父任务设置，具体档位未核实。采用 2026-11-19 当前工作树 godot-envart 技能。选取原白盒门洞与东北角，露天商棚服务于旅人载具的修理与物资补给。保留 17 个原始碰撞体。审图素材属于原游戏权利方，工程不分发游戏截图。

## 已审看参考

开发者 Shedworks / 发行商 Raw Fury 的 [Sable 商店页](https://store.steampowered.com/app/757310/Sable/)，截图序号按 Steam appdetails 从 0 起。

- [09 号，主参考](https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/757310/ss_ef49b11e14ab919a138a20739d50fd04fdd806ad.1920x1080.jpg)。黄布、朱红宽环和极细深色杆索围住明亮的修理区域。棚前留空，背侧集中细节。近地沙呈橙色，天际岩柱浅紫，天空蓝绿。原图中商棚架空，本场改为保留原动线的地面修理棚。
- [00 号，辅助远景](https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/757310/ss_f7cf5d40340dfcfc534daff63be314fdbb9e6817.1920x1080.jpg)。岩层的大块轮廓与聚落的小尺度建筑分层。
- [15 号，辅助构造](https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/757310/ss_eef53ec54dda09b085b5435c276e9c765250fea0.1920x1080.jpg)。只采用角色后方的红色分段结构、牵索与小旗。对话与人物占据画面，不能决定空间布局。

## 素材选择与实际范围

| 套件与原作者 | 交付使用的模型 | 取舍与适配 |
| --- | --- | --- |
| Quaternius，[Modular Sci-Fi Megakit](https://quaternius.com/packs/modularscifimegakit.html) | Door_Frame_Square、Column_Pipes、Prop_Vent_Wide、WallBand_Straight、Prop_Crate4 | 门框有真实折边与接合面，墙模块整段可转向安装。保留索引、法线和 UV，按墙厚/白盒门框适配，减少 PBR 高频并将原色图按亮度压为砂灰、灰紫与乳白。 |
| Quaternius，[Sci-Fi Essentials Kit](https://quaternius.com/packs/scifiessentialskit.html) | Prop_SatelliteDish、Prop_Crate_Tarp、Prop_Barrel2_Closed、Prop_Desk_Medium、Prop_Mug | 使用实际 Standard 免费包内的天线、罩布货箱、桶、桌与杯。源 glTF 的 UV 与轮廓保留。两个 Quaternius 包都是 CC0，可商用和再分发。交付各自许可原文。官网套件总数涵盖额外版本，免费范围以本次缓存中的文件为准。 |
| Kenney，[Survival Kit 2.0](https://kenney.nl/assets/survival-kit) | workbench-grind、bucket、bottle、box-open、bedroll-packed | 旧授权缓存来自作者发布的 80 模型 CC0 免费包。保留 palette UV 和原图。磨轮体现修理活动，瓶/桶/卷包标明补给用途。普通工作台、半帐与锤候选未被选为主要建筑；圆环棚架需要保留开放正面。 |

为此局部补制红环、织物、杆索、旗、维修架、两幅原创标识和远层岩丘。它们与真实素材实例分别列在场景树。背后的岩层采用局部轮廓示意。门洞、东墙、跳台与原转向空间由原白盒决定。

## 打开与检视

用 Godot 4.7.2 打开本目录的 project.godot，运行默认 final.tscn。三个 Camera3D 节点名为 overall、detail、transition。可在编辑器选择节点并预览或使其成为当前相机。场景内的维修物件、墙构件、布棚、路签和索具可单独移动。库内 glTF 或 GLB 可以在外部模型编辑器调整。

captures/whitebox 保存原表面的基线，captures/round01 保存首次审图结果。captures/final 与 captures/control 为最终有/无墨线的同场景、同机位、同光照、同贴图比较。分辨率为 1600 × 1000。使用图形模式运行以下命令可重拍任一场景；会写入对应 captures 子目录，请先备份已有证据。

```sh
godot --path . --rendering-driver metal --script res://capture.gd -- final
```

shaders/round03/ink.gdshader 从深度差和预通道法线突变提取轮廓与折线，保留底色和物体投影。ink_opacity 控制混合强度，stroke_px 控制采样距离，ink_color 指定墨色，默认分别为 0.70、1.15 和暗紫棕。control.tscn 仅省略全屏 Ink 节点。材质简化、色图重映射和环境美术均是两组共有条件。该方法使用 Forward+ 法线缓冲，适用于当前三个固定视点。草图式细线在缩略预览中较弱，整体效果主要来自实体框架、遮阳布和索具。[Godot 屏幕读取 shader 文档](https://docs.godotengine.org/en/stable/tutorials/shaders/screen-reading_shaders.html)

首轮截图显示墙板窄边朝向镜头、后墙缺少工作信息、地面与跳台过饱和。第二轮独立修订已保存在 round02.tscn 与 captures/round02，转正墙板，修正箱盒与杯瓶支撑，区分砂岩和地面，加入工作架、软管、工位图示与导向牌。17 个 StaticBody3D、碰撞子节点、BoxMesh 与 BoxShape3D 尺寸及三个机位已经逐项与原白盒或首轮比较。

局限：全景仍可辨出原跳台的整块箱形，门洞近景中的路牌重复，第二轮近景左侧棚架遮住工作图与磨轮，第三轮已调整。远景岩柱的规则截面和真实参考中的细腻层理有差距。小棚与原商车的悬浮底盘、活动吊装结构存在造型区别。此局部尚待用户美术验收。

## 主审反馈后的第三轮

主审在看过第二轮全景、过渡、工位及关闭墨线的细节图后指出，棚前红环遮住工位，褐色工作台与墙板重叠。round03 将棚前红环向外移并减窄，在原支柱间补三根回拉构件。保留门洞的另一道红环，调整 Quaternius 工作台为灰绿搪瓷、Kenney 磨轮支架为浅青绿，工具架保留更深的蓝绿。抬高工位图示，并把原本横跨图示的通风口移到右侧。固定相机与灯光沿用第二轮。近景现在能读到整台磨轮、工作图和挂工具的架子，左缘仍留有红环，标明棚入口。全景里的跳台箱形、远岩轮廓仍较规则。

第三轮有线与无线的场景及实际截图分别保存在 round03.tscn、control03.tscn 和两个同名 captures 子目录。final.tscn 和 control.tscn 分别对应这两个版本，shaders/round03 保存本轮的墨线源文件。round01 与 round02 保留各轮原始资源和照片。
