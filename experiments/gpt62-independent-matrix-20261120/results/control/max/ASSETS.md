# 素材来源与小样

## 实际取用范围

Poly Haven 文件来自各条目公开的 1K 下载。模型取 glTF、对应二进制与条目列出的 JPG 附件，保留 UV、OpenGL 切线法线与 ARM 打包纹理。没有购买素材包。素材可修改、商用与再分发。工程附完整 [CC0 1.0 许可](art/licenses/CC0-1.0.txt)。[Poly Haven 授权说明](https://polyhaven.com/license)

### 建筑表面

下表文件夹均在 `art/surfaces/`。每组包含实际下载的 `color.jpg`、`normal.jpg`、`rough.jpg`，以及从 color 调整明度、色相与对比所得的项目色图。Godot 材质位于 `art/materials/`，使用米制世界三平面映射，粗糙度与法线按数据读取。

| 工程材质 | 物理周期 | 输入文件夹、作者及公开条目 |
| --- | --- | --- |
| BoardCast | 1.80 m | Dimitrios Savva · [wood_textured_concrete](https://polyhaven.com/a/wood_textured_concrete) |
| Slab | 2.10 m | Amal Kumar · [concrete_slab_wall_02](https://polyhaven.com/a/concrete_slab_wall_02) |
| Terrazzo | 2.00 m | Amal Kumar · [terrazzo_tiles](https://polyhaven.com/a/terrazzo_tiles) |
| Linoleum | 2.00 m | Rob Tuytel · [linoleum_brown](https://polyhaven.com/a/linoleum_brown) |
| Acoustic | 2.00 m | Dimitrios Savva · [ceiling_interior](https://polyhaven.com/a/ceiling_interior) |
| Veneer | 1.10 m | Jenelle van Heerden · [rosewood_veneer_02](https://polyhaven.com/a/rosewood_veneer_02) |

### 可编辑模型

下表的文件在 `art/models/<条目名>/` 下。按实际网格边界测量，选定变体后重新置底居中。目录中的 glTF、bin 与材质贴图共同构成可编辑来源。

| 实际 glTF 文件 | 免费内容与适配 | 作者及条目 |
| --- | --- | --- |
| desk | 2.00 × 0.95 m，台高 0.788 m，桌架与六屉、二托盘保留为独立网格 | Ulan Cabanilla · [metal_office_desk](https://polyhaven.com/a/metal_office_desk) |
| strip | 下载库中有七个灯具变体，取约 0.91 m 的 A 号。顶面为吊装基点，沿用原发光图 | Ulan Cabanilla · [mounted_fluorescent_lights](https://polyhaven.com/a/mounted_fluorescent_lights) |
| anglepoise | 带夹座的折臂灯，保留原夹口基准 | Kuutti Siitonen（建模、材质），Yann Kervran（原绑定） · [desk_lamp_arm_01](https://polyhaven.com/a/desk_lamp_arm_01) |
| ledger_open、ledger_closed | 左右摆拍的开、合笔记本分别抽取，重置支点 | DaDrood · [binder_notebook](https://polyhaven.com/a/binder_notebook) |
| legal_pad、carbon_copies、memo_pad | 十个独立根网格中选三套有厚度的纸垫与纸叠 | Ulan Cabanilla · [office_notepads](https://polyhaven.com/a/office_notepads) |
| radio | 原机壳、话筒、刻度盘、支架及连接线保持原相对位置 | Mateusz Sadek · [vintage_radio_transceiver](https://polyhaven.com/a/vintage_radio_transceiver) |
| shelving | 0.59 × 0.50 × 2.14 m 的木搁板钢架 | James Ray Cock · [steel_frame_shelves_02](https://polyhaven.com/a/steel_frame_shelves_02) |
| clock | 直径 0.32 m，含三根独立指针与表面玻璃 | PierreB3D · [wall_clock](https://polyhaven.com/a/wall_clock) |
| terminal | 带磨损的金属设备箱，源高 1.12 m | James Ray Cock · [utility_box_01](https://polyhaven.com/a/utility_box_01) |
| carton | 带束带和折盖的旧纸箱，源高 0.34 m | Rahul Chaudhary · [cardboard_box_01](https://polyhaven.com/a/cardboard_box_01) |

Innerscene 各条目标明为其原创模型、CC0；使用网页的 Download GLB 取得实际文件。将内嵌图拆为同目录贴图，场景使用独立 glTF。金属度、粗糙度、UV、材质分区与网格保留。下列尺寸按宽、深、高排列。

| 文件夹与 glTF 文件名 | 尺寸、选材及适配 | 作者与公开条目 |
| --- | --- | --- |
| reel | 0.446 × 0.195 × 0.475 m，木边、磁头、穿带和双盘独立 | Innerscene · [Open Reel](https://www.innerscene.com/tools/library/3d-parts/open-reel-tape-recorder-a168fd2e) |
| chair | 0.466 × 0.545 × 0.895 m，连续弯管、脚套与皮垫，调整皮色因子 | Innerscene · [Chrome cantilever chair](https://www.innerscene.com/tools/library/3d-parts/chrome-cantilever-chair-upholstered-46c45fb8) |
| cabinet | 0.80 × 0.491 × 1.30 m，双玻璃门、悬挂屉与两层夹册，调整板金与夹册色组 | Innerscene · [Lockable steel filing cabinet](https://www.innerscene.com/tools/library/3d-parts/lockable-steel-filing-cabinet-with-glass-doors-787d3529) |
| pedestal | 0.43 × 0.553 × 0.662 m，三层活动柜，保留轮组及五金 | Innerscene · [INDEX 42](https://www.innerscene.com/tools/library/3d-parts/index-42-mobile-filing-cabinet-2a3c1eef) |

## 同灯位整墙比较

两套小样均在正式门洞、10 m 右墙及顶板下摆放同一钢桌，使用固定三机位。各组图内的模型、比例与照明均来自重新打开的 Godot 场景。

- A 的竖向模板印能跨过墙面连续阅读，近处可见木纹与斑点。卷盘的圆轮从中景就看得出功能。大面积水磨石颗粒偏抢眼，玻璃柜和椅背则在侧光中压成了黑块。[A 整墙](captures/audition-a/props.png) · [A 近景](captures/audition-a/close.png)
- B 的水平方块沿两侧墙壁呈规律重复，横槽甚至令人错读门柱的构造。亚麻地板使桌腿落地更清楚；矮柜把手可读，但小型收发机在中景退成一团。[B 门洞](captures/audition-b/door.png) · [B 近景](captures/audition-b/close.png)
- 主墙取 A 的竖纹，地面用 B 的细亚麻面分铺，局部再用水磨石划分过门。主工位使用卷盘机；收发机可承担相邻联络位置。工作台和资料板需要侧向照明与适量反射，座椅和罩漆柜另做材质适配。

最初的两个小样请求因场景浮点文本缺少前导零而未生成图像。修正序列化后改用 `captures/audition-a` 与 `captures/audition-b` 取证。

## 项目制作件

门套、上亮窗、交接窗、顶格、收边和周转台面按白盒尺寸制作。纸夹面皮、卷盘附加挡片为本项目网格；包件内的页块、标签、包角与扣件在 Godot 中可单独选择。登记桌和书柜另存皮垫与喷漆材质版本，保留小样所用版本。`art/printing/` 为本项目绘制的穿带图、部件图、交接表、仪表刻度和标牌。没有导入冻结参考图的像素。

印刷文字使用 Jeremy Tribby 的 Barlow Condensed 和 IBM 的 IBM Plex Mono，按 SIL Open Font License 1.1 处理。游戏显示烘入印刷件的字形。许可随包保存在 `art/licenses/`。[Barlow Condensed 项目](https://github.com/google/fonts/tree/main/ofl/barlowcondensed) · [IBM Plex Mono 项目](https://github.com/google/fonts/tree/main/ofl/ibmplexmono)

## Final 修订用料

- DRAFT 110 Plan Chest 由 Innerscene 发布为 CC0。实际 GLB 含钢制柜壳、滑轨、分层抽屉、镍色把手和橡木顶面，测得 1.230 × 0.918 × 0.882 m。拆出嵌图，保留材质与结构，文件为 `art/models/plan_chest/plan_chest.gltf`。交接窗下使用原尺度，中段跳台将同一模组以 0.98 倍装进原碰撞轮廓。[素材条目与下载](https://www.innerscene.com/tools/library/3d-parts/draft-110-plan-chest-c476de7a)
- Vintage Stapler 由 Mateusz Sadek 在 Poly Haven 发布为 CC0。使用 1K glTF 包中的上盖与底座，两枚单独演示的钉件留在源下载中。工程文件为 `art/models/vintage_stapler/stapler.gltf`，长约 0.21 m。[素材条目与下载](https://polyhaven.com/a/vintage_stapler)
- 钢桌的 `desk_open.gltf` 将左上屉向前移 0.166 m。档案柜的 `retrieval_case.gltf` 打开左侧玻璃门，钟的 `clock_matte_glass.gltf` 使用低反射面罩，`loose_master.gltf` 抽取卷盘机原有盘圈、轮辐、盘芯和带卷。上述变体各自引用原文件夹中的几何与贴图。
- `art/final/wood/` 采用同一 Rosewood Veneer 02 源图，另制较暗的台面色图，保留粗糙度、法线并启用 mipmap。`art/final/printing/` 含本次绘制的监录波形、卷带号签及出库副本，材质使用同一套项目排印。
