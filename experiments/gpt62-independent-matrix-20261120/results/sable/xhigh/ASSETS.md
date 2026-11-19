# 素材与选用依据

| 来源 | 实际取得的免费内容 | 本地用途与改造 |
| --- | --- | --- |
| Kenney · Fantasy Town Kit 2.0 | 作者发布的免费 ZIP 内有 167 个 GLB，另有 FBX、OBJ 和色板。 | 小样使用 `cart-high`、`stall-bench`。保留原网格、车轮子节点和色板 UV，重配共享色板中的木、漆铁及织物色。凳原长 0.94、高 0.226 个单位，沿长向摆放，调整到约 0.70 m 高的作业面。 |
| Kenney · Pirate Kit 2.1 | 免费 ZIP 内有 72 个 GLB，另有 FBX、OBJ 和色板。 | 小样使用 `barrel`、`crate-bottles`。桶原宽 1.336、高 1.229 个单位，原点在底中心。瓶筐的瓶子和木侧板保留各自 UV 色块，桶箍转为蓝灰。 |
| Rob Tuytel / Poly Haven · Sandstone Blocks 08 | 取得 1K Diffuse 与 Displacement JPG。作者标示实物采样宽 3 m。 | 原图见 `assets/sandstone/`。由漫反射保留手凿颗粒，将大色面压入石灰黄；从高度场的局部差提取石缝，生成 `washed.jpg` 与 `etched.jpg`。两图均以 3.2 m 周期按世界坐标铺设，石面为干燥漫反射。 |

两个 Kenney 包均由作者以 CC0 发布，可用于商业项目、改作与再分发。包内原许可在 `assets/licenses/town.txt`、`port.txt`。Poly Haven 扫描同为 CC0，法律文本保存在 `assets/licenses/CC0-1.0.txt`。[Fantasy Town Kit 下载页](https://opengameart.org/content/fantasy-town-kit) · [Pirate Kit 下载页](https://opengameart.org/content/pirate-kit) · [Sandstone Blocks 08](https://polyhaven.com/a/sandstone_blocks_08) · [Poly Haven 许可](https://polyhaven.com/license)

## 小样取舍

A 与 B 共用几何、色板、固定日光与机位。A 给石缝较弱的连续明暗，B 加强同一高度图的凹缝，并从屏幕深度及法线折角描单像素边。木、铁、玻璃的原有分色均参与比较。两者都看了门、右墙、近景。

A 的整段石墙在门头后面几乎连成同一块，桶箍主要靠蓝色区分。B 的大块石材有错缝和断续的凿口，筐口、车辕与车轮也能分开，适合继续制作。B 左墙仍能看出同一个缺角重复；局部将用有实际功能的挂布、墙脚护条和棚影打断重复。瓶筐和双轮车照其原有收纳与搬运功能使用。[A 全墙](captures/sample-a/props.png) · [B 全墙](captures/sample-b/props.png) · [A 近景](captures/sample-a/close.png) · [B 近景](captures/sample-b/close.png)

## 进入场景的文件

- Fantasy Town Kit 另取 `pillar-stone.glb` 作门柱拼件，`planks.glb` 作可落脚的箱盖，`stall-stool.glb` 作记账凳。使用 `cart-high.glb` 的整车及其车轮子节点。所有 GLB 引用同包 `Textures/colormap.png`；两个包各保留自己的寻址布局。
- Pirate Kit 另取 `crate.glb`、`bottle-large.glb`、`tool-shovel.glb` 与 `rocks-sand-b.glb`。空筐既作回收筐，也配内衬和盖板组成三档周转箱，铁锹、散石沿墙落地。已检查底部锚点、网格范围和包内预览。模型使用色板 UV 和原网格法线，为不透明材质；两个模型包都没有单独用于这些模型的粗糙度或法线贴图。
- 本组补制门额、染布、秤盘、砝码、盐晶和登记簿。网格在 `art/forms/`，终轮新增网格在其 `final/` 子目录，均为可导入的 OBJ。天空远岩、布纹、秤面刻度、货号、墙绘、沙地与轮辙为本组绘制的贴图。天空采用静态全景，印记与车辙按世界坐标贴合原有墙地。冻结参考图仅供观察。
- `masonry.gdshader` 的 `meters_per_tile` 是每次重复覆盖的米数。`contours.gdshader` 的 `weight` 控制线条不透明度。货场地面与转角墙绘分别在 `freight_yard.gdshader`、`basin_mural.gdshader` 中合成。门、货箱和秤共用同一日光，描边随实际深度与法线变化。[Godot 空间着色器](https://docs.godotengine.org/en/stable/tutorials/shaders/shader_reference/spatial_shader.html) · [深度后处理](https://docs.godotengine.org/en/stable/tutorials/shaders/advanced_postprocessing.html)

下载使用作者公开包与 Poly Haven 单图。初查的另一模型库 API 路径返回 404 后，改用以上作者发布页。原始下载地址为 [Fantasy Town 2.0 ZIP](https://opengameart.org/sites/default/files/kenney_fantasy-town-kit_2.0.zip)、[Pirate 2.1 ZIP](https://opengameart.org/sites/default/files/kenney_pirate-kit_2.1.zip)、[砂岩漫反射](https://dl.polyhaven.org/file/ph-assets/Textures/jpg/1k/sandstone_blocks_08/sandstone_blocks_08_diff_1k.jpg) 和 [高度图](https://dl.polyhaven.org/file/ph-assets/Textures/jpg/1k/sandstone_blocks_08/sandstone_blocks_08_disp_1k.jpg)。
