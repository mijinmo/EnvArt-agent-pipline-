# 素材与小样

Kay Lousberg 的 KayKit Dungeon Remastered 1.0 为本次墙、门、地面和主要道具的来源。从作者公开仓库 main 的压缩包中实际取出 Assets/gltf 下的模型，并核对 Assets/LICENSE.txt。CC0 1.0 允许修改和再分发；随包许可见 [KayKit-LICENSE.txt](assets/cellar/KayKit-LICENSE.txt)。采购范围为该仓库免费版，另售的 EXTRA 和 SOURCE 版本未使用。[作者仓库](https://github.com/KayKit-Game-Assets/KayKit-Dungeon-Remastered-1.0) · [版本说明](https://kaylousberg.itch.io/kaykit-dungeon-pack)

首次小样可在 audition.tscn 重开。4×4 米墙段、2 米高的桶、2 米宽的架板均取自实际 glTF 顶点范围。模型以 Y 向上，架板原点靠墙，几何上表面在原点以上 0.1 米，横桶 keg 含原有底托和塞子。glTF 有法线及渐变图集 UV，只有一张颜色图，未提供法线或粗糙度贴图。将内嵌图像抽出共享，保留网格和门页变换。原样的整体和近景可见连续平墙、小片凸砖、白亮铁箍与大块纯色，选用其轮廓和装配尺度，近看表面需要适配。[原样整体](captures/audition/overall.png) · [原样近景](captures/audition/close.png)

第二种处理沿用同一组实物、灯位和相机。从原墙的崩角凸砖提取石块，铺成错缝饰面并沿门洞放射排列。保留门页和门环。按原图集颜色区分木、石、金属，给近景表面另配方向 UV、木纹、石纹和手绘风桶头标。第一次重开时部分首材质呈灰白，已把顶点色明度转成显式 glTF 材质色。修正样里可辨认蓝灰石、褐色桶板及深铁箍，采用此组进入初稿。[修正前](captures/audition_painted/close.png) · [修正样近景](captures/audition_color/close.png)

检索过 Quaternius 的 CC0 Pirate Kit。公开页以角色及海盗外景为主，本局部所需的墙门、架板与桶箱已在 KayKit 免费版中取得，未将该套包纳入交付。[作者页面](https://quaternius.com/packs/piratekit.html)

机位在小样阶段一次调整。overall 从入口左侧同时看见货架和折角门，close 对准端板及分装台，transition 从右侧走道回看左侧搬运区。自首次小样起保持不变。

## 交付文件与适配关系

原包压缩文件记录的版本为 `b0ca9bd96a8072ab36a3a5464f00ed1e06a16d07`。下表使用原包基名；门模块是 wall_doorway.glb，其余模型后缀为 .gltf.glb。交付把来源模型拆为 [glTF 与共享图集](assets/kaykit)，适配版本放在 [painted](assets/painted)。各 glTF 引用同目录的 .bin；材质包含粗糙度与金属度常量。[固定版本](https://github.com/KayKit-Game-Assets/KayKit-Dungeon-Remastered-1.0/tree/b0ca9bd96a8072ab36a3a5464f00ed1e06a16d07)

| 实际来源文件基名 | 使用位置与改动 |
| --- | --- |
| wall、wall_cracked、wall_doorway | 小样保留原轮廓和门页。交付的 ashlar_west、ashlar_east、strapped_door 采用 wall 的墙芯及切角石岛。门边石放射重排，并补合叶带、门钉与门槛石。 |
| floor_tile_large、floor_wood_large | 成组地砖旋转拼接，木板翻转封顶。采用石面与纵向木纹。 |
| shelf_large | 保留带托架的架板，取其木板几何制作 rack_upright、梁、牌背和箱上斜撑。 |
| keg、barrel_large、barrel_small、barrel_small_stack、box_large | 保留桶腹、铁箍、木塞和原底托；横桶端面重新展开，绘制铃铛和鲱鱼两种批次标。braced_case 在原箱上增设撑条与钉头。 |
| table_small、stool、keyring_hanging、bottle_A_labeled_green、bottle_C_brown | 用于分装和取样。桌凳按木构件调整表面，钥匙加挂点，两个原瓶型配烟色玻璃与暗色瓶塞。 |

本次自制的船灯、三股盘绳、釉陶量壶、试饮杯、卷边货单、招牌字面、酒桶图记及表面图像随包提供。招牌和铃铛、鲱鱼商标面均为本次绘制。近景的红蓝端板借用参考的配色关系。自制新增几何与纹理按 [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/) 提供；KayKit 原作及改形保留原许可。原游戏截图仅用于观察，交付纹理未使用截图像素。
