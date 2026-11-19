# 盐路风机修理棚

同输入 Sable 独立续作。共同限制见上级 BRIEF.md，原始资产范围与参考标识见 ../INPUT.md，基线素材许可及来源见 provenance/README.md。Godot 4.7.2、Metal Forward+，使用 2026-11-19 工作树的 godot-envart 技能。

## 参考与起点

09 号主图的红白轮环、绿黑色斜撑、黄色帆布与单侧吊杆构成开放的车棚，远处浅紫岩柱和高亮薄云退到天际。00 号提供水平层理与远近色差，15 号可见分段上漆的弧面、绳网和三角旗。此处为地面吊修站。三个起始视角显示门洞与工位已成立，前景却由无构件的方台和坡道主导，三个位置复用相同的路牌，磨轮附近缺少正在维修的对象。

## 第一轮

在 pass01.tscn 中，以 Quaternius 门框、平台板、带筋零件箱、置物架、夹钳、管座、风机和转子搭出入站门、装卸坡道及拆修工位。按源件 UV 重映青绿、赭红、骨白色板漆，降低高频表面反光。保留 Kenney 磨石、敞箱与个人用品。门边补制吊杆、绞车、吊钩和载重表；磨石对面是落在双脚滑架上的主机及台面替换转子。棚下另有行李网、编织工作垫。三块保护踏面各有与其同尺寸的装载箱，坡面和台阶使用独立薄面板。土墙、沙地与固定云带使用本轮独立 shader，远岩从基线轮廓按层倾斜切分。曲线、沙纹和云片均使用固定坐标。

初轮三个机位已在保存重开后实际审看。全景中吊臂和货箱把作业路径连在一起，但三只箱子过于相似，两侧云块偏大，屋顶黄布大部分藏在圆环后。过渡图中手摇绞车清晰可接近，门内可见一只空架，门内框青漆缺少近看细节。近景中机座与备件的位置能读懂，机罩和磨轮支架仍是大片净色，顶棚未显示修补痕迹。

第一轮实机证据为 evidence/pass01_overall.png、evidence/pass01_transition.png、evidence/pass01_detail.png。GPU 排队 0.00 秒，一次输出三图，技术重拍 0 次。17 个保护体及三个 Camera3D 的实机采样与起点一致。

## 第二轮与交付

最终场景为 [final.tscn](final.tscn)。用 Godot 4.7.2 打开同目录的 project.godot 并按 F5，可从全景进入样板。选择 overall、transition、detail 三个 Camera3D 可分别预览。门框、吊臂、风机及支架、货箱、路线桌等在场景树中可独立选取。场景共享第一轮的定稿资源，第二轮的变体另存于 art/final。

第二轮沿原篷布面片抬出偏心屋脊，补上支撑杆、压缝、补片和可系起的侧帘。主机增加压圈、螺栓及标记，墙图重画为与台上转子和机壳对应的装配分解图。门环补分段接缝，卷筒增加挡盘与导绳架。原图中透过门洞只能看到指路牌，本轮在后墙路线图下新增出货台、卷图及套筒库存。新薄篷有墙挂斜撑。高货箱覆盖束绳帆布，中低箱保留硬质盖板。天际缩窄横云，在原有背景层内补一组更细的盐柱；背景沙丘接上右侧可视边缘。

重开最终场景并实际看过三张图。全景里，黄布尖顶从红环上方露出，包布高箱与低、中两只硬壳箱可区分。过渡图穿门可见图桌、卷轴和库存，近景中能从分解图对应到台上转子与落地主机。全景中左侧坡道和前排两只硬壳箱仍显规整，图桌上方的吊绳与路线图有视线重叠。近景的左侧红弧占幅仍大，侧帘和背墙的交界相对生硬。远岩的轮廓与分层较原画简化。此次审查限于固定静态机位。

| 轮次 | 全景 | 过渡 | 工位近景 |
| --- | --- | --- | --- |
| 第一轮 | [图](evidence/pass01_overall.png) | [图](evidence/pass01_transition.png) | [图](evidence/pass01_detail.png) |
| 最终轮 | [图](evidence/final_overall.png) | [图](evidence/final_transition.png) | [图](evidence/final_detail.png) |

## 素材、着色与检查

- 真实素材沿用本项目已经取得的 CC0 免费子集。新增适配来自 Quaternius Modular Sci-Fi Megakit 的 Door_Frame_Square、Platform_CenterPlate、Prop_Fan_Small、Prop_Fan_Small_Propeller、Prop_PipeHolder、Prop_Clamp，来自 Sci-Fi Essentials Standard 的 Prop_Crate、Prop_Crate_Tarp 和 Prop_Shelves_ThinShort。保留源网格和 UV，按原图集明度调整底漆或按表面槽分色，工作台上的独立转子和检修机内的转子都固定在静止状态。磨轮沿用 Kenney Survival Kit 的网格，单独改制轮石和脚架调色板。许可原文在 baseline/assets/quaternius 与 baseline/assets/kenney 内，源包链接及继承素材清单见 [来源记录](provenance/README.md)。没有新增下载。
- 吊装构件、编织小垫、帆布罩、图桌、金属接合件、地貌分层和所有新增标牌均为本样板制作。原有可见拱环和篷布供几何适配，真实组件承担入口、箱体、踏面、机器及主要家具的造型。
- SaltPan 以世界坐标生成固定风纹，sand、drift、ochre 分别设置底沙、亮纹与细砾。CutBank 的 limestone、earth、seam 调整墙面沉积色、下部土色与断续层缝。HighDesert 的 horizon、zenith、cloud_color 设置天际、天顶和云片。墨线沿用起点 Forward+ 深度/法线 shader。推断的绘制方法仅用于本工程。[Godot 空间着色器](https://docs.godotengine.org/en/stable/tutorials/shaders/shader_reference/spatial_shader.html) · [天空着色器](https://docs.godotengine.org/en/stable/tutorials/shaders/shader_reference/sky_shader.html)
- 两次艺术轮次均按三个 1600 × 1000 固定机位重开取图。两轮 GPU 队列等待分别为 0.00 和 0.00 秒，图形启动各一次，技术重拍分别为 0 和 0。最终轮在首次导入时发现文本场景的小数缺少前导零，修正后重新加载通过，再进行图形捕获，共一次导入阶段修复。headless 导入日志中的编辑器设置写入和系统证书提示来自沙箱，新增资源导入完成。两轮 constraints.json 与起点逐项一致，含 17 个保护体的位姿、碰撞与网格简表以及三个相机。input-freeze.json 的 140 个登记文件均通过 SHA-256 检查。

第一轮本地提交为 218e076。最终提交可通过当前 README 所在版本及本目录 Git 历史定位。
