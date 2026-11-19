# 档案交接室选材小样

基于 interior_detailed 的续作。GPT-6.2 Astra 使用 ce9bf03 版环境技能，三个原机位锁定。对照用旧图 detail-01。小样均先保存场景再以 Godot 4.7.2 Metal Forward+ 拍摄 room。

## 参考图

- [储藏室实机图](https://cdn.mos.cms.futurecdn.net/naFRXRm5Rufg52AvrWMD4i.jpg)，来自 [PC Gamer 光追实测](https://www.pcgamer.com/control-is-the-best-most-complex-implementation-of-ray-tracing-in-a-game-so-far/)。主参考。右上货架档案箱成组、桌上收音设备、混凝土墙上制度海报和地坪细碎骨料均可辨识。左前人物遮住部分地坪，反射强度受实测设置影响；不据此推断完整房间几何。
- [Dead Letters 实机图](https://image.jeuxvideo.com/medias-md/156691/1566905271-9637-capture-d-ecran.jpg)，来自 [Jeuxvideo 任务攻略](https://www.jeuxvideo.com/wikis-soluce-astuces/1097312/appel-anonyme.htm)。辅助过渡空间参考。门侧横排目录、木饰面、上方点灯及金属分隔可读。红毯与关闭的双扇门属于原图所在区域，本局部门洞维持净空。两张参考仅链接供研究，未复制到项目或作贴图。
- 历史 control-3、control-4 的角色及战斗光效遮挡工作区，只保留为氛围补充。Remedy 区域作者 Anne-Lynn Sottas 的 [Communications Department](https://lynnn.artstation.com/projects/L2WvyP) 文字印证分拣、指派、派送的空间用途；未以未看清的作品图作观察依据。

## 真实素材与全墙小样

| 小样 | 本地资源与许可 | 实机选择 |
| --- | --- | --- |
| sample_a.tscn | 既有 Poly Haven concrete_wall_009、concrete_floor_worn_001，CC0。 | 墙、天花出现大斜线与直缝，超出连续墙要求。地面磨耗裂纹也偏仓库。淘汰。 |
| sample_b.tscn | 既有 smooth_concrete_floor 的颜色/粗糙/GL 法线用于墙面；新增 [Terrazzo Tiles](https://polyhaven.com/a/terrazzo_tiles)，Amal Kumar，完整免费材质的 1K JPG 实际三张。| 墙面大尺度斑驳和地坪细骨料可见。地坪反差略高，正式版再压低。两样都将既有三个档案柜转向，柜门和把手可从工作区读取。 |
| 门后饰面 | [Plywood](https://polyhaven.com/a/plywood)，Rob Tuytel，免费完整材质的 1K JPG 实际三张。 | 黄褐自然纹理将用于局部门后饰面，调成低光泽深色木材。 |

下载文件位于 materials，diff 为 sRGB，rough、nor_gl 为数据。两个新增材质的免费可商用/再分发范围见 [Poly Haven CC0](https://polyhaven.com/license) 与项目 licenses/PolyHaven_CC0.txt。下载地址遵循 https://dl.polyhaven.org/file/ph-assets/Textures/jpg/1k/ 包含资产 ID 及原文件名；本地省略原文件名的 _1k。旧场景既有道具的作者、实际免费范围及完整源目录见上级 asset_manifest.json、detail_manifest.json、interior_manifest.json。没有游戏素材进入工程。
