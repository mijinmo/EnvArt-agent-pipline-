# 素材与适配

从 Poly Haven 官方目录按物件功能、外廓和表面筛选。以下资产均可单独免费下载，使用 CC0 1.0，允许修改、商用和随项目再分发。实际交付为 1K 素材，未下载整站包；源侧许可见 [CC0 法律文本](licenses/CC0-1.0.txt) 与 [Poly Haven 许可说明](https://polyhaven.com/license)。

|实际目录与源页面|作者|本组使用|
|---|---|---|
|[wood_textured_concrete](https://polyhaven.com/a/wood_textured_concrete)|Dimitrios Savva|竖向模板墙、梁、门墩的整面 A 小样|
|[concrete_slab_wall](https://polyhaven.com/a/concrete_slab_wall)|Dimitrios Savva|横向板缝的 B 小样|
|[terrazzo_tiles](https://polyhaven.com/a/terrazzo_tiles)|Amal Kumar|通行地面，石粒去红并调至灰绿|
|[metal_office_desk](https://polyhaven.com/a/metal_office_desk)|Ulan Cabanilla|双座抽屉台、抽拉板，长 2 m，台高 0.788 m|
|[drawer_cabinet](https://polyhaven.com/a/drawer_cabinet)|Ulan Cabanilla|1.88 m 开架及下部抽屉|
|[metal_stool_02](https://polyhaven.com/a/metal_stool_02)|Ulan Cabanilla|操作位，座高约 0.46 m|
|[vintage_radio_transceiver](https://polyhaven.com/a/vintage_radio_transceiver)|Mateusz Sadek|收件通联设备，带麦克风、天线、线缆|
|[cassette_player](https://polyhaven.com/a/cassette_player)|Oday Abuzaeed|听录台，保留磁带与机器两部件|
|[desk_lamp_arm_01](https://polyhaven.com/a/desk_lamp_arm_01)|Kuutti Siitonen（建模、贴图），Yann Kervran（绑定）|钳夹式台灯，支点对齐桌板|
|[wall_clock](https://polyhaven.com/a/wall_clock)|PierreB3D|接收区墙钟，表针独立|
|[office_notepads](https://polyhaven.com/a/office_notepads)|Ulan Cabanilla|从纸品组合选取单件，保留原 UV|
|[binder_notebook](https://polyhaven.com/a/binder_notebook)|DaDrood|摊开的登记册与闭合本|

各模型目录有官方 glTF、外部 BIN 及实际引用的贴图。材质沿用 glTF 的 base color、OpenGL normal 与打包的 occlusion / roughness / metallic 通道；个别材质仅使用源文件提供的通道。建筑表面有 diffuse、rough、nor_gl 三张 JPEG，finish 是从 diffuse 灰度重映射的版本。下载时按官方 API 的 MD5 检查。图源尺寸为木模 1.8 m、预制板 2.3 m、水磨石 2 m，小样采用 3.2 m 三平面投射，同时显示纹理组织和整墙重复。

## 小样结论

在相同的顶光、任务光与物件位置下比较 [木模整墙](captures/sample-a/props.png) 和 [预制板整墙](captures/sample-b/props.png)。A 的竖向纹理在门洞侧壁有方向感；B 的黑色水平缝绕过墙角、与柜架层板争线。选 A。A 的桌面、上部墙过亮，地面反光像一层密砂；制作阶段将降低顶光，收敛地面颗粒反差，保留纸面和金属设备之间的明度差。
首轮增加 [Industrial Storage Cart](https://polyhaven.com/a/industrial_storage_cart)（Jule Bielitz）与 [Cardboard Box 01](https://polyhaven.com/a/cardboard_box_01)（Rahul Chaudhary），同为 Poly Haven CC0 1K glTF 包。转运车等比缩至 85%，根据车盘网格高度放置包件。纸品变体复用原 BIN、材质与 UV，移除目录陈列偏移，单件定位到桌面。

门牌、卷盘图解、四款流转表、档案夹与卷箱标签为本次原创栅格印刷图。字形采用 IBM Plex Sans Condensed 与 IBM Plex Mono，图中文字已栅格化，许可见 [SIL OFL](licenses/IBM-Plex-OFL.txt)。[字体来源](https://github.com/IBM/plex)

## 最终新增与独立版本

- PeterM 的 [Filmstrip Projector 8mm](https://polyhaven.com/a/filmstrip_projector_8mm) 使用 1K glTF、BIN 和原材质，保留红黑卷盘、开关、接头和线缆。场景中等比 1.13 倍，侧面对着操作位，用于声画同步校验。
- Rob Tuytel 的 [Blue Metal Plate](https://polyhaven.com/a/blue_metal_plate) 使用 1K 漫反射、粗糙度和 OpenGL 法线。提取明度重映射为灰绿漆，保留接缝和刮痕，用于柜壳、护墙板与窗框。
- Jenelle van Heerden 的 [Walnut Veneer](https://polyhaven.com/a/walnut_veneer) 使用同样三种 1K 通道，适配桌面及递单窗台。以上三项与首轮模型使用相同 CC0 许可。
- 最终墙地材质存于 `art/finishes/`，印刷图存于 `art/press_final/`。墙、地和纸面副本单独启用 mipmaps；地面收敛粗糙度范围并强调水磨石铺缝。新金属漆、木面和卷盘机也使用各自独立的导入设置。首轮资源及其源侧导入设置保留在原处。
