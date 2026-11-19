# 素材与小样

建筑和货件来自 Kay Lousberg 的 **KayKit Dungeon Remastered 1.0** 免费公开包。[作者发布仓库](https://github.com/KayKit-Game-Assets/KayKit-Dungeon-Remastered-1.0/tree/main/addons/kaykit_dungeon_remastered/Assets/gltf) · [本地原许可](assets/kaykit/LICENSE.txt)。CC0 允许商用、改造和再分发。这里仅用了仓库内的 GLB，未取用 EXTRA / SOURCE 内容。

assets/kaykit 内同名 glTF 与 bin 对应上游的 NAME.gltf.glb，提取共用的 dungeon_texture.png。实测 wall 和 wall_cracked 原尺寸约 4×4 米，中心在底边，法线与调色图 UV 随网格保留；均为不透明材质。墙与柱换成粗糙砂岩色，道具沿用源渐变色图。柱柱头和桌腿等形体由源网格提供。

- 建筑候选为 wall、wall_cracked、wall_arched、pillar_decorated。
- 货件和家具为 barrel_large_decorated、barrel_small_stack、box_stacked、box_small_decorated、table_medium、stool、bottle_A_labeled_green、trunk_medium_B。桌原宽深各 2 米、高 1 米，场内收窄到 1.34×1.54 米，台面高 0.8 米。堆箱以 0.5 倍原尺寸落地。
- 第一次小样中原墙 Mesh 遮住了石面。隐藏该视觉节点、保留碰撞后重新开场拍摄。有效对照为 sample_a.tscn / captures/stone-a 和 sample_b.tscn / captures/stone-b。最初遮挡的图留在 captures/sample-a、sample-b，仅作排错记录。
- A 的长裂纹在十米墙上连成锯齿，远比桶箍醒目。B 的浅石压顶能衬出酒红木板和桶口，选 B。石面上三块一簇的凸砖仍有周期，制作中用有功能的挂件与棚影打断。此对照同时改变石面颜色与模型，未将差异归因于单一着色参数。

最终另取同包 pillar.gltf.glb，底面约 1.5×1.5 米、高 4 米，换成浅石材质，柱身置于原门洞两侧。wall_arched 与 box_small_decorated 为检视候选。自制网格 awning、valance、pennon 保留 OBJ 和 UV；日山站徽、织带与木箱面为本组原创 SVG。秤、管件与印章等可在场景内逐件编辑。细边线取自屏幕深度和法线变化，ink.gdshader 的 strength 控制着墨浓度。沙地及天空着色器各自独立。
