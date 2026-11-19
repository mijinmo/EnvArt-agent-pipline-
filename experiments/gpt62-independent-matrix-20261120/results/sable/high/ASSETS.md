# 素材与适配

## KayKit Dungeon Remastered 1.0

作者 Kay Lousberg。下载自[作者的 Godot 公开仓库](https://github.com/KayKit-Game-Assets/KayKit-Dungeon-Remastered-1.0)，实际取用 main 分支 ZIP 中的 `addons/kaykit_dungeon_remastered/Assets/obj`。免费包内有独立的墙体、铺面、桌凳、储物和日用器具网格及一张 1024² RGBA 配色图。包内 [CC0 声明](art/licenses/KayKit-Dungeon-Remastered.txt) 允许商用、修改与再分发。EXTRA 与 SOURCE 不在使用范围。

`art/kaykit` 中的 OBJ 与包内同名，保留源坐标、面、法线与 UV，移除 MTL 引用以便 Godot 指定材质。原图 `dungeon_texture.png` 通过原 UV 为桌板、箍圈、容器和台布上色。色图是色带图集，无配套法线及粗糙度图。普通墙宽高各 4 米，底面在 y=0；轴向酒桶自带支座，货桌为 2 × 4 米，原高 1 米。场景分别缩放以保持桌面、货件支撑和白盒轮廓连续。检索的 Kenney Pirate Kit 页面在此环境未能取得包内容，故未使用。

## Godot 对样

`sample_a` 与 `sample_b` 共用机位、灯光、货物与整段墙。A 的墙沿用图集冷灰涂面；B 采用世界米制错缝、细蚀点和深度／法线轮廓。A 的墙上三联凸砖反复出现，桌布与瓶体颜色清楚。B 能在近景区分箍圈、盘边和木板，浅墙与沙地接近参考 01，但墙上凸砖横跨新砖缝，形成两层互相抢读的砖纹。首轮选 B，把工作面正中的凸砖从模块上减去，收敛墙面噪点，再用真实遮棚投影分开桌面与背景。

## 入景文件

| 作者包内源文件 | 在场景中的用途和适配 |
| --- | --- |
| wall、wall_cracked、wall_archedwindow_open | 两个小样测试普通墙、裂墙、带窗墙。首轮起，wall_dressed、wall_archedwindow_open_dressed 保留原网格中连续的墙身、窗洞、压顶与墙脚，去掉分离的装饰砖。大面用 cut_stone 的米制错缝。 |
| pillar、floor_tile_large、floor_wood_large | 门柱包饰、平铺门槛、工作台下的木板。厚度分别适配原门柱、地面标高。 |
| table_long_tablecloth、shelf_large、stool | 原台布货桌、墙上卷图搁板、操作凳。桌面定在约 0.91 米。 |
| keg、barrel_large、crates_stacked、box_small | 靠墙的卧桶、立桶、装箱货堆和三个跳台的箱体覆面。跳台的原碰撞独立保留。 |
| plate、bottle_A_labeled_green | 盘网格缩成吊秤的浅托盘，带签瓶作为桌面小件。 |
| floor_dirt_large_rocky | 终稿的 limestone_spalls 仅取源模型里分离的碎石，去掉方形底板，几组碎石沿墙脚和门柱放置。 |

取用目录的具体版本可在[作者仓库对应版本](https://github.com/KayKit-Game-Assets/KayKit-Dungeon-Remastered-1.0/tree/b0ca9bd96a8072ab36a3a5464f00ed1e06a16d07/addons/kaykit_dungeon_remastered/Assets)查看。色图原样保留；终稿 shipping_paint 保留 UV 图集对木材、陶器和布面的区分，降低金属灰的饱和反差。

## 本局部原创

门冠、吊秤壳体与悬臂、铁件、包绳、印章及砝码由可编辑 Godot 网格节点拼装。缝制棚布、三角旗和盐包为专用 OBJ。门牌、刻度盘、盆地线路图、运单、织纹、货签和字形为本项目绘制的 SVG，未使用冻结截图像素或第三方字体。线路和地名是虚构的。

近景磨损限定在石块接缝、零散蚀点、沙上脚印和少数印刷表面。远处岩层与薄云由天空着色器绘制。细线由 Forward+ 深度与法线缓冲取相邻像素生成，阈值与墨色位于 art/materials/ink.gdshader。[Godot 屏幕读取与法线缓冲说明](https://docs.godotengine.org/en/stable/tutorials/shaders/screen-reading_shaders.html)
