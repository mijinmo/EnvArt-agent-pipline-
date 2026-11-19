# Sounding House / 港边修理棚

主参考为 Black Salt Games 的 [press kit](https://www.dredge.game/press-kit) 中 [Exploring new places / 12](https://static.wixstatic.com/media/e609d3_1398d6b764a346a69d945f263e8aec34~mv2.png)。图右前方临水屋由短檐、暖色墙、暗柱和下方相连的平台组成，桩、绳与密集屋顶形成不同尺度的剪影。本试作将轮廓压缩到一座局部修理棚，固定近看机位展开工位、磨轮和绳链构造。原图固定的俯视距离不能证明近看的木纹或器具式样。

辅参考为 [The lighthouse will guide you back to shore / 1](https://static.wixstatic.com/media/e609d3_e0eb701824064407a49c0e9a0590b2cb~mv2.jpg)，采用蓝绿海面、红白航标、光斑与琥珀色天光。#9 峡谷仅能说明远层，#2 人物界面遮蔽建筑，均不作为主要装配依据。原作图片不随工程再分发。

## 下载素材
- [Quaternius Medieval Village MegaKit](https://quaternius.com/packs/medievalvillagemegakit.html) Standard 免费 CC0，取墙、窗、木顶、柱、烟囱、檐木。采用本地已下载的真实 glTF、BIN 与贴图。实装列表见 assets/village。
- [Quaternius Fantasy Props MegaKit](https://quaternius.com/packs/fantasypropsmegakit.html) Standard 免费 CC0，取桶、货箱、绳圈、链、挂灯、车与木架。具体文件和贴图见 assets/props，本次没有使用付费包。
- [Kenney Survival Kit](https://kenney.nl/assets/survival-kit) CC0，取磨轮、工台、工具和板料。副本保留原材质贴图。三个许可见 assets/licenses。

## 试装取舍与改造

首轮比较了 Kenney Survival 磨轮/工台与 Quaternius 木器的相邻比例。在玩家距离，Kenney 工台的大体块和高饱和来源图压过绳桶细节。修订换成 Quaternius Workbench / Workbench_Drawers，保留 Kenney 的磨轮作为操作端。窗墙原点在底面中央，单模块约 2×3 m，原顶片约 2.3×1.2×1.6 m。组合后部分转角仍有连续屋檐、木格构的村屋特征。未安装的 Window_Wide_Flat1 为备选窗件；采用模型的可编辑实例以 harbor.tscn 为准。车、绳桶、铁链、沙袋保留原比例或小幅缩放；Kenney 单位较小，磨轮放大 4.5 倍至工位高度。

材质 paint/ 下 wood 与 roof 共用 Village 木纹 UV 来源；boards、cast、fabric、items 对应 Props 的家具、金属、布和杂件图集。plaster、brick、stone 来自 Village 墙面系列。survival 从 Kenney colormap 改绘色域。quay 是为本试作绘制的错缝木板，近处能看到钉位和顺纹刮痕。底彩图集保留 UV 占用和大形以便两组公平切换。自制导向图、鱼形招牌和静态浮标体现修理活动。鱼形牌是本场景的标识设计。
