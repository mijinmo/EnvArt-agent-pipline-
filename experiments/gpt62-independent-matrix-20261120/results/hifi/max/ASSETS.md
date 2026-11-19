# 交接区 07 · 素材清单

## 建筑与装配件

Kenney 的 **Space Station Kit 1.0** 和 **Factory Kit 3.0**。核对了 Kenney 发布在 OpenGameArt 上的免费 ZIP、包内 License.txt、OBJ、配色图和逐件预览。Space Station 压缩包有 97 件，Factory 压缩包有 143 件，各自提供 OBJ、FBX、GLB 三套格式。本场景采用 OBJ 原网格。Kenney 主站下载返回 403，实际取得的两份文件来自作者自己的 OpenGameArt 发布页。作者采用 CC0 1.0，可商用、改造和再分发。包内原文保存在 `art/licenses/Kenney-*.txt`。[Space Station Kit](https://opengameart.org/content/space-station-kit) · [Factory Kit](https://opengameart.org/content/conveyor-kit)

- 小样 A 取 Space Station 的 `wall`（原件 1 × 1 × 0.3 m）和 `container-flat-open`。小样 B 取 Factory 的单面 `structure-wall`（1 m 宽、3 m 高，脚边及顶边向外折），两者均配 `pipe-large-valve`。底边、轴心和进深依据 OBJ 顶点定位。B 的有面一侧朝局部内部。
- `art/modules/` 是项目实际读取的改造件。保留分面、法线及作者的配色边界，依原 UV 采样色图分区及明暗梯度，写入顶点颜色。重新分配 UV0，存储三角形重心坐标和折边掩码。平面内的三角剖分不产生墨线，阀体与外壳可共用 `art/materials/inked_metal.gdshader`。材质参数 `line_width` 控制像素线宽，`hatch_strength` 控制世界空间排线强度。
- 原包没有独立的金属度、法线或磨损贴图。小样保留少数相邻色区的渐变；全墙试铺采用每格 2 m 的横向间距。在工具台背后不使用贯穿整墙的饱和黄条。

## 工位道具

tevy 发布的逐件免费 GLB，每件均可公开下载多个 LOD，署名与许可见原始目录。工作台使用 v1 LOD0，手推车及按钮盒使用 v1 LOD1。授权为 CC0 1.0，法律文本见 `art/licenses/CC0-1.0.txt`。[模型目录及逐件散列](https://tevy.dev/models.json) · [CC0](https://creativecommons.org/publicdomain/zero/1.0/)

| 项目内源件 | 原件和已核对的内容 |
| --- | --- |
| `art/workshop/bench.glb` | 2.907 × 1.980 × 0.912 m。虎钳、挂板、工作面和六个抽屉保留独立造型。托架下自带一条灯罩。[Tool Chest and Bench](https://tevy.dev/models/tool-chest-bench) |
| `art/workshop/truck.glb` | 0.654 × 1.164 × 0.430 m。轮轴、踏板、把手和漆面磨痕。[Blue Hand Trolley](https://tevy.dev/models/blue-hand-trolley) |
| `art/workshop/button.glb` | 0.304 × 0.607 × 0.181 m。包括急停、钥匙开关、指示灯和底部过线口。[Control Button Panel](https://tevy.dev/models/button-panel) |

将 EXT_meshopt_compression 几何与 KHR_texture_basisu 图集离线解码，顶点转为浮点，图集改为外置 PNG。保留层级、各部件枢轴、原 UV、基础色、粗糙度/金属度、切线空间法线及有灯件的自发光。压低细碎色阶和法线强度，使小工具与相邻墨线外壳能同框辨认。解码工具仅在制作时使用。

## Godot 实长小样

三组使用同一盏工作主灯、相同支撑面和同一套邻近道具。右墙五跨，覆盖 10 m，`props` 看转角与重复距离，`close` 看漆面和握持件，门口机位用于保留统一的出图记录。初装发现原白盒墙面穿过覆板、Factory 件背面朝外，已修正后另存下列实图。

| 场景与截图 | 看图后的取舍 |
| --- | --- |
| [sample_a.tscn](sample_a.tscn) · [全墙](captures/audition-a/props.png) · [近景](captures/audition-a/close.png) | 两层折板的粗接缝交代了墙高，中部蓝灰色带能托住黄色阀轮和浅色工具面。选作主墙，在实际工位改变上下两层的高度并加入立柱。 |
| [sample_b.tscn](sample_b.tscn) · [全墙](captures/audition-b/props.png) · [近景](captures/audition-b/close.png) | 模块的连续黄色横条在灯下十分突出，贴着工具架顶边贯穿整个画面。保留折边与警示漆的关系，整面平铺止于小样。 |
| [sample_control.tscn](sample_control.tscn) · [连续着色](captures/audition-control/close.png) | 与 A 同几何、顶点配色、粗糙度、光照。普通材质下阀轮亮面和筒盖融成大块。A 的墨线把轮缘、卡箍与筒盖分开，暗处还能看到短斜线，因此把该处理用于涂装构件。工作台继续使用原图集。 |

## 首轮实际装入的补充件

- Space Station Kit 使用 `wall-pillar`、`wall-door-wide` 作墙柱与开放门框，`floor-panel` 作跳台覆板，`container-flat`、`container-tall` 作横放与立放的备件。Factory Kit 使用 `pipe-large`、`pipe-large-long`、`pipe-large-bend`、`pipe-large-side` 和小样的阀体拼成供回管，`cog-e` 用于拆下的转件。用实物轴向和底边组装，直管调整长度、法兰保留径向厚度。[Space Station 原始 ZIP](https://opengameart.org/sites/default/files/kenney_space-station-kit.zip) · [Factory 原始 ZIP](https://opengameart.org/sites/default/files/kenney_factory-kit_3.0.zip)
- 托盘为 tevy 的 Wooden Pallet v1 LOD1。源件 1.2 × 0.151 × 0.8 m，项目文件为 `art/workshop/pallet.glb`，采用与手推车相同的解码与漆面适配。法律文本与其余 tevy 资产共用。[模型与 CC0 许可](https://tevy.dev/models/wooden-pallet) · [托盘源件](https://tevy.dev/models/wooden-pallet/v1/lod1.glb) · [工作台源件](https://tevy.dev/models/tool-chest-bench/v1/lod0.glb) · [手推车源件](https://tevy.dev/models/blue-hand-trolley/v1/lod1.glb) · [按钮盒源件](https://tevy.dev/models/button-panel/v1/lod1.glb)
- Rob Tuytel 的 **Metal Plate**，Poly Haven 发布的免费 CC0 表面。实际采用 1K Diffuse、OpenGL Normal 与 Roughness 三张 JPG。将绿色锈面滤成有限灰阶，映为蓝钢印色 `tread_ink.png`；`tread_normal.jpg` 和 `tread_rough.jpg` 保留源通道。在门侧窄带与工具台脚边按米投射，关节处保留大板缝。其他地板上的钢片压边、螺钉和漆损另绘。[素材与作者](https://polyhaven.com/a/metal_plate) · [逐文件下载表](https://api.polyhaven.com/files/metal_plate) · [许可](https://polyhaven.com/license)
- 铭牌、读数、压力盘、工序海报及标线为这处交接区原创的印刷图形，未使用冻结参考的像素、标识或角色。字形使用 The Barlow Project Authors（Jeremy Tribby）的 Barlow Condensed Bold、Black Italic，随字体发布的 SIL OFL 1.1 原文保存在 `art/licenses/Barlow-OFL.txt`。交付的是已排版的纹理。[字体来源](https://github.com/google/fonts/tree/main/ofl/barlowcondensed)
- `art/fabrication/` 的压边安装板、折弯叶片、工字梁与按本地接口走向铺设的软管是补制件。灯具由独立支座、灯罩和扩散片组成。其余小网格用于法兰、表座、挡条和螺栓。截面、装配、附件和灯位均可在 Godot 场景树中编辑。

## Final 专用资源

- `art/modules/station/container-flat-open-inspected.obj` 单独取用开口筒体，沿用原来的壳、卡箍与凹口色区，把在检件改成青漆。在开口内组装独立轴圈、叶片和轴螺母。后墙观察口使用 Space Station Kit 的 `wall-window-frame`，内侧布置管线、压条与反光片。
- `art/workshop/bench_inspection.glb` 保留工作台几何，对第一格抽屉的枢轴平移 0.11 m。独立基础色图 `maps/bench_body_painted.png` 减少密集杂色并启用 mipmap，法线与粗糙度继续读取同一来源。
- `art/final/` 存放工单、管线识别牌、运输盖板与束带图、轮痕、玻璃反射片和修订材质。盖板与锁扣纹理按现有跳台平面铺设。车辙仅用于托盘旁的轮迹。表面着色保留模块的折边掩码，在暗面混入按米缩放的网点与斜排线；`ink_density` 调印色密度，`pipe_paint` 调供管的青色漆层。技术实现参考 Godot 的空间着色器、环境光与直接照明接口。[空间着色器](https://docs.godotengine.org/en/stable/tutorials/shaders/shader_reference/spatial_shader.html) · [环境设置](https://docs.godotengine.org/en/stable/tutorials/3d/environment_and_post_processing.html)
