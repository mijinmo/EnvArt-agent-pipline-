# 素材与许可

下列文件实际从 Poly Haven 官方公开 API 的文件清单下载，使用免费 1K glTF、关联图像与二进制网格、1K JPG 表面；背景取自官方全景 JPG。模型和表面下载后按清单 MD5 检查，按真实节点和 POSITION 边界挑选子件，枢轴校准至底部。场景内的模型使用本地文件。资产以 CC0 1.0 发布，可商用、修改并随工程再分发。[提供方许可](https://polyhaven.com/license) · [随包许可全文](art/licenses/CC0-1.0.txt)

| 资源 | 作者 | 交付位置 | 实际用途与适配 |
|---|---|---|---|
| modular_fort_01 | Rico Cilliers | `art/models/modular_fort_01/` | 实取薄墙直段 02 / 03 / 04 与 gate_01。22 个节点中拆出四个，门模块只用于小样。三个直段依原后墙和折墙落位。 [来源](https://polyhaven.com/a/modular_fort_01) |
| modular_wooden_pier | Rico Cilliers | `art/models/modular_wooden_pier/` | 从 7 个子件提取 planks，原约 2.52 × 0.08 × 2.20 米。三段沿原坡面旋转，平台一段水平。 [来源](https://polyhaven.com/a/modular_wooden_pier) |
| rock_moss_set_01 | Kless Gyzen | `art/models/rock_moss_set_01/` | 原 6 个分块中选 rock01 至 rock05，分布于门脚、树下和坡外。 [来源](https://polyhaven.com/a/rock_moss_set_01) |
| tree_small_02 | Rico Cilliers | `art/models/tree_small_02/` | 保留实物干、枝与 UV。按原冠层采样，将高密度叶面改为 7400 枚折叶并使用秋色色带。 [来源](https://polyhaven.com/a/tree_small_02) |
| fern_02 | Rob Tuytel, Rico Cilliers | `art/models/fern_02/` | 提取 a、b 两个蕨簇，使用源材质的遮罩和双面叶片。 [来源](https://polyhaven.com/a/fern_02) |
| shrub_03 | Rico Cilliers | `art/models/shrub_03/` | 从四种中取 a 型，配合石床边缘。 [来源](https://polyhaven.com/a/shrub_03) |
| wooden_table_02 | Serhii Khromov | `art/models/wooden_table_02/` | 原约 1.13 × 0.80 × 0.71 米，调为 1.68 × 0.83 × 0.80 米工作台。 [来源](https://polyhaven.com/a/wooden_table_02) |
| wooden_hammer_01 | James Ray Cock | `art/models/wooden_hammer_01/` | 木锤贴工作台摆放。 [来源](https://polyhaven.com/a/wooden_hammer_01) |
| handsaw_wood | Konrad Szałankiewicz | `art/models/handsaw_wood/` | 约 0.63 米长的手锯平放于工作台。 [来源](https://polyhaven.com/a/handsaw_wood) |
| wooden_bucket_01 | James Ray Cock | `art/models/wooden_bucket_01/` | 桶和提环保留共同原点关系，地面收纳用。 [来源](https://polyhaven.com/a/wooden_bucket_01) |
| wine_barrel_01 | James Ray Cock | `art/models/wine_barrel_01/` | 保留桶盖、塞和桶底的相对位置，置于篷下。 [来源](https://polyhaven.com/a/wine_barrel_01) |
| wooden_lantern_01 | James Ray Cock | `art/models/wooden_lantern_01/` | 灯体、门、提手配套，分别作桌灯与右门柱吊灯。 [来源](https://polyhaven.com/a/wooden_lantern_01) |
| forest_floor | eye-candy.xyz | `art/surfaces/forest_floor_*` | 林下落叶底面，与门路渐变。 [来源](https://polyhaven.com/a/forest_floor) |
| mossy_cobblestone | Sơn Nguyễn | `art/surfaces/mossy_cobblestone_*` | 门槛至后场、坡脚接门和工作位的铺路。 [来源](https://polyhaven.com/a/mossy_cobblestone) |
| medieval_blocks_03 | Rob Tuytel | `art/surfaces/medieval_blocks_03_*` | 平台承台、门上内退石砌及小样墙面。 [来源](https://polyhaven.com/a/medieval_blocks_03) |
| mossy_sandstone | Dimitrios Savva | `art/surfaces/mossy_sandstone_*` | 暖色过梁与小样石面。 [来源](https://polyhaven.com/a/mossy_sandstone) |
| lichen_rock | Rico Cilliers | `art/surfaces/lichen_rock_*` | 墨褐岩面的小样基础。按源色图明度调成干燥灰绿石，保留法线与粗糙度。 [来源](https://polyhaven.com/a/lichen_rock) |
| weathered_planks | Dario Barresi, Dimitrios Savva | `art/surfaces/weathered_planks_*` | 木构件、杆件和车圈。 [来源](https://polyhaven.com/a/weathered_planks) |
| autumn_forest_02 | Andreas Mischok | `art/craft/distant_wood.jpg` | 取官方 tonemapped JPG，降对比、暖调并调整天际在俯视方向的高度，存为 distant_wood.jpg。 [来源](https://polyhaven.com/a/autumn_forest_02) |

建筑木石与木器 glTF 保留各自的 UV、底色、法线和材质所用的金属/粗糙度信息。石面和坡边木件采用世界坐标三向映射，色图按颜色输入，粗糙度与 OpenGL 法线按数据输入。木桥板使用模型的原有 UV。

## 本组制作

art/craft 中的分块门石、承压券、日轮浮饰、布篷、岔尾旗与散落叶片由 Codex 在本组以几何和绘纹代码制作。两幅布料纹样也是本组生成，原料实物扫描、模型和全景的来源见上表。木支架、绳结、轮子和挂灯支座在 Godot 场景内以可编辑部件装配。原作参考仅用于观察，参考图来源见 RESEARCH.md。未使用生成式图像服务或外部模型生成服务。

## 素材小样

小样保存在 audition.tscn 和 captures/audition。选用墙段、木桥板、林床材质与木器组合。整体图能读出折墙凹槽，过渡图可辨桶、灯和桌子的支撑关系。近景中完整要塞拱门明显高于原门楣，正式稿换为按原净空适配的石柱与券石。正式版的修正前后证据见 REVIEW.md。
