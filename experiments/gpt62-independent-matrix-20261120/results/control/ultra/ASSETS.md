# 素材与引擎小样

Poly Haven 的下列资产可单独免费下载。作者将资产以 CC0 1.0 发布，可改造、商用并随项目分发。下载使用官方 API 所列的 glTF 1K 文件及其 include 清单，各文件与该清单的 MD5 核对。许可正文随本包保留。尺寸按作者资料换算为米，集合资产列出整个集合范围。[资产许可](https://polyhaven.com/license) · [CC0 正文](art/licenses/CC0-1.0.txt)

## 建筑与地坪

| 下载项 | 作者 | 单次平铺的原始尺寸 |
|---|---|---|
| [wood_textured_concrete](https://polyhaven.com/a/wood_textured_concrete) | Dimitrios Savva | 1.80 × 1.80 m |
| [terrazzo_tiles](https://polyhaven.com/a/terrazzo_tiles) | Amal Kumar | 2.00 × 2.00 m |
| [concrete_slab_wall_02](https://polyhaven.com/a/concrete_slab_wall_02) | Amal Kumar | 2.10 × 2.10 m |
| [old_linoleum_flooring_01](https://polyhaven.com/a/old_linoleum_flooring_01) | Charlotte Baglioni | 1.99 × 1.99 m |

实际交付于 `art/surfaces/`。每组采用 Diffuse、OpenGL 法线与 Rough 三张 1K JPG。自写 Godot shader 用米制世界坐标投影，按表面分别控制去饱和、冷色染色、法线强度与光泽。没有引入位移以改变白盒碰撞。

## 邻接家具小样

| 下载项 | 作者 | 长 × 深 × 高 |
|---|---|---|
| [metal_office_desk](https://polyhaven.com/a/metal_office_desk) | Ulan Cabanilla | 2.00 × 0.95 × 0.79 m |
| [filmstrip_projector_8mm](https://polyhaven.com/a/filmstrip_projector_8mm) | PeterM | 0.25 × 0.60 × 0.35 m |
| [vintage_wooden_drawer_01](https://polyhaven.com/a/vintage_wooden_drawer_01) | James Ray Cock | 1.72 × 1.01 × 1.09 m |
| [SchoolChair_01](https://polyhaven.com/a/SchoolChair_01) | Ethan Place | 0.57 × 0.68 × 1.01 m |

`art/models/<资产名>/` 保留 glTF、二进制几何和实际引用的纹理。钢桌由两组可独立选择的抽屉和托盘组成；索引柜已带几个拉开程度不同的抽屉。两者正面均朝模型局部 +Z，转向走道。放映机保留双片盘、机身、电缆和开关，在桌面上转动以看清绕片路径。蓝色管脚椅等比缩至 90%。模型沿用各自 UV、颜色、切线空间法线和金属粗糙度通道。

## 固定机位 A/B

两案保留相同围护、钢桌、木索引柜、椅、放映机和中性偏冷的顶光。A 的纵向模板混凝土在整段右墙上能看出竖痕，桌面以上的墙仍能留给纸张。水磨石在近景有颗粒，但远处的细点偏亮，首轮应过滤远处高频并压低点光在地面的高光。选 A。[A 全墙](captures/sample-a1/props.png) · [A 近景](captures/sample-a1/close.png)

B 的板缝有明确厚度，但全墙出现两排完全相同的横格，墙角也延续同样节奏。旧油毡的棕色几何花纹与木柜争夺注意力。B 保留为可重开的材质对照。[B 全墙](captures/sample-b/props.png) · [B 近景](captures/sample-b/close.png)

初次提交 A 截图请求时，场景文本中的小数缺少前导零，加载在取图前停止。修正数值写法后重新打开并使用新目录 sample-a1；A/B 比较使用两套成功的 Metal 实图。

## 首轮的构件与桌面材料

下列模型同为 Poly Haven CC0 glTF 1K。灯具集合只取 A 型 912 mm 灯管，保留原发光图并设发光强度。门和窗口各取未涂鸦的模型，单件实际宽分别为 1.08 m、1.60 m，分别用于后墙库门和收件窗口。三者均裁出独立可实例化几何、重排索引并只附带所需贴图。

| 下载项 | 作者 | 原始尺寸或集合范围 |
|---|---|---|
| [binder_notebook](https://polyhaven.com/a/binder_notebook) | DaDrood | 0.58 × 0.20 × 0.03 m |
| [office_notepads](https://polyhaven.com/a/office_notepads) | Ulan Cabanilla | 1.10 × 0.66 × 0.02 m |
| [vintage_stapler](https://polyhaven.com/a/vintage_stapler) | Mateusz Sadek | 0.21 × 0.05 × 0.10 m |
| [desk_lamp_arm_01](https://polyhaven.com/a/desk_lamp_arm_01) | Yann Kervran, Kuutti Siitonen | 0.62 × 0.41 × 0.88 m |
| [cardboard_box_01](https://polyhaven.com/a/cardboard_box_01) | Rahul Chaudhary | 0.39 × 0.52 × 0.34 m |
| [wall_clock](https://polyhaven.com/a/wall_clock) | PierreB3D | 0.32 × 0.05 × 0.32 m |
| [clipboard](https://polyhaven.com/a/clipboard) | ProgrammerOnCoffee | 0.23 × 0.34 × 0.04 m |
| [fire_alarm](https://polyhaven.com/a/fire_alarm) | Slinc | 0.10 × 0.03 × 0.14 m |
| [mounted_fluorescent_lights](https://polyhaven.com/a/mounted_fluorescent_lights) | Ulan Cabanilla | 0.91 × 0.65 × 0.04 m |
| [rollershutter_door](https://polyhaven.com/a/rollershutter_door) | MP | 3.08 × 0.30 × 2.40 m |
| [rollershutter_window_02](https://polyhaven.com/a/rollershutter_window_02) | MP | 3.60 × 0.17 × 1.56 m |


活页本拆出打开和合拢两个状态；纸品集合选出法律纸垫、索引卡、A4 纸叠，取消原排列位移，分别成为独立 glTF。其余桌面模型保留原始材质。工程使用自制的圆形片罐、原跳台尺寸的平图柜覆面、门洞衬框、横梁和护墙补足白盒的特殊尺寸。

首轮专用的 concrete_cast 与 terrazzo_honed 来自小样 A 的两组表面。混凝土降低了弥散纹理对比，水磨石把粗糙值集中在较哑的区间并低通过滤，开启生产用纹理的 mipmaps。小样仍引用原始资源。

印刷品位于 `art/print/`。走片图为本项目绘制的双盘侧视示意，表单、识别牌、编号与标签均为原创排版。平面使用 Barlow Condensed Bold（Jeremy Tribby）和 IBM Plex Mono Regular（IBM），已栅格化。字体采用 SIL Open Font License 1.1。[Barlow 许可](art/licenses/Barlow-OFL.txt) · [Plex 许可](art/licenses/Plex-OFL.txt)

## final 独立资源

- 入件车来自 Savva Zakharov 的 **Tool Cart**。实际下载的是带轮、两抽屉和下层搁板的单件 1K glTF，尺寸约 1.27 × 0.75 × 0.96 m。保留原锈蚀、金属与法线，按模型的托盘承托高度陈列片罐和案卷，文件在 `art/models/tool_cart/`。CC0。[模型页](https://polyhaven.com/a/tool_cart)
- Rob Tuytel 的 **Blue Metal Plate** 提供 2.5 m 尺度的蓝色喷漆钢板。交付 1K Diffuse、OpenGL normal、Rough，沿用实物磨痕分布，以终版 enamel_final shader 调整为档案柜与护墙使用的深蓝绿色。CC0。[表面页](https://polyhaven.com/a/blue_metal_plate)
- `counter_part_open.gltf` 从 MP 的未涂鸦卷闸另存。以局部高度 0.71 m 裁掉下部，重建截线处顶点，插值原 UV 与法线。Godot 中另设压条、导轨和有实际进深的柜台，继续引用原 CC0 贴图。[原卷闸](https://polyhaven.com/a/rollershutter_window_02)
- `art/records/` 的 accession、release、review 是本项目制作的三种带索引耳纸夹。可独立实例化的 glTF 包含分层纸芯、弯折封面、外露标签和三套原创栅格印刷。柜顶和收件窗按不同堆叠厚度摆放。立式片罐、托架和卷边按工作台尺寸制作。
- `terrazzo_final.gdshader` 在已筛选的水磨石表面加入米制分隔缝。终版场景单独保存两个 shader 的参数、局部反射和实景灯光。
