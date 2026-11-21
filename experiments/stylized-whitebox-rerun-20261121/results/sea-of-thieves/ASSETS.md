# 素材与取舍

主建筑、地面和桶箱来自 Kay Lousberg 的 KayKit Dungeon Remastered 1.0。已下载作者公开仓库 b0ca9bd96a8072ab36a3a5464f00ed1e06a16d07 的免费 GLB，检查网格、材质和枢轴。CC0 允许商用、修改与再分发，原许可保存在 art/licenses/KayKit.txt。使用范围为公开基础包。[作者仓库](https://github.com/KayKit-Game-Assets/KayKit-Dungeon-Remastered-1.0/tree/b0ca9bd96a8072ab36a3a5464f00ed1e06a16d07) · [作者下载页](https://kaylousberg.itch.io/kaykit-dungeon-remastered)

原始墙段长 4 m、高 4 m，底边中心为枢轴。大石板为 4 × 4 m；单小桶约 1 × 1.02 m，大桶 1.8 × 2 m。架板枢轴在靠墙侧的地面，板面高 1.2 和 2.7 m。GLB 有位置、法线、UV0、索引和内嵌 1024² 渐变色图集，粗糙度与金属度为常数，采用不透明表面。转存为共享图集的 glTF，移除门扇节点。石板压薄贴近原面。

小样 captures/audition 已逐张查看。overall 显示整面墙的孤立小砖重复，折墙的原面穿出装饰；close 里桶箍和独立桶端清楚，但门梁横切拱眼，地面与煤油灯位置过亮，架板缺立柱；transition 的网格与窄坡轮廓便于核对。保留桶、架、石板与门套轮廓。正式稿调整墙面砌缝、梁后填板、暗色桶箍与地面，按真实高度覆装坡面和跳台，给光源加吊挂支撑。

### 交付文件和适配

| 实际使用的免费文件族 | 局部用途及处理 |
| --- | --- |
| wall、wall_scaffold、wall_cracked、wall_window_closed、wall_doorway | 后墙、折墙与入口。保留源网格轮廓，导出 open_arch 时只保留门框，调整拱眼以包住原矩形净空。石面和木构拆为不同材质。 |
| floor_tile_large | 同一石板模块的四个 UV 分区保存为 flag_course_0 至 3，原地面上方毫米级视觉覆面。 |
| barrel_large、barrel_small、barrel_small_stack、box_large、box_small | 桶的底边枢轴用于立桶；横放堆桶直接落在地面和架板上。运输箱按各跳台占地、高度适配，加覆横板并压暗框木。 |
| shelves、table_medium、stool、trunk_medium_B | 架板依原支架方向摆放，补货架立柱和搁梁。桌面承托样瓶和盘绳。 |
| bottle_A_labeled_green、bottle_B_brown、bottle_C_green、keyring_hanging | 分装工作区及门柱挂件，按木板接触面与悬挂点调整尺寸。 |

art/kaykit 保存小样所用的共享原色图集和模型；art/cellar 保存近景用的适配版与四个石板分区。木石分面取材自原调色图，另外制作分劈橡木、砌石和不规则铺地的表面贴图，石墙、铺地另有对应法线。源图集的 UV 和内嵌 PBR 信息保留在小样版中。原始 GLB 下载保存在本组 .work，版本库交付可直接导入的模型、贴图和导入设置。

art/fittings 的削面梁、拱券和柱石、船灯、盘绳，art/surfaces 的木石图，以及 art/marks 的鲸标、旗和门牌由本次 Codex 辅助编写几何与绘图代码生成。鲸标等为本次原创图形。场景采用常规 PBR 材质；截图全部来自编辑场景的实机渲染。Joachim Coppens 的原作图仅作视觉参考，未用作贴图或可再分发模型。
