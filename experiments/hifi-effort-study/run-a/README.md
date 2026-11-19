# Impeller service · run A

在 Godot 4.7.2 Forward+ 中打开本目录的 project.godot。首轮可编辑场景为 [pass01.tscn](scenes/pass01.tscn)，起点仍为 [start.tscn](scenes/start.tscn)。三个固定机位位于 Views。

## 首轮

- 实看参考 51 的上方桁架、局部排线、青墙上的洋红导向带及沿设备断开的踏板。参考 60 提供了红色厚壳机械、连贯的警告漆面和可读的转轴。对应到起始近景，重点是把平安装板和细三角形叶片改成有截面的部件，将凹凸细碎的写实材料改成可分辨功能的漆面。
- 采用工程内 Quaternius 免费版 Modular SciFi MegaKit、Sci-Fi Essentials Kit 的建筑与道具。只使用当前副本中的模型和贴图。两份 CC0 许可保存在 art/。风机保留原网格、骨骼、动画数据与安装尺度，在扫掠版 glTF 中重新展开六片叶尖并计算法线。外加向机口收窄的铸罩、分段护环、六角紧固件和 A/B 印刷纹理。隔离手柄和转换板是在原门框上补做的机械部件。
- kit/ 中可编辑的场景继承原始导入模型，按 surface 覆盖涂装。enamel.gdshader 提供色块漆层、局部漫射阈值、基于世界位置的阴面排线、原 UV 图保留度和叶尖/罐带/墙导线图案。tread.gdshader 在原平台网格上绘出钢板接缝、防滑槽与铆钉。箱体、柱管、墙、座椅和桌面采用各自的色组。降低既有屏幕描线与全屏色阶强度。门柱标签、风机铭牌和手套安全图案为新绘制的场内印刷品。
- 首轮实际制作 1 次，保存重开后图形捕获 1 次、3 张，1600 × 1000。GPU 排队 0.00 秒。先导入并以 headless 检查场景依赖，再由公用包装器启动原 capture.gd，以 Metal Forward+ 出图。环境探查时系统 Python 缺 Pillow，切换本机捆绑 Python。headless 日志首次指定 /dev/null 报日志不可写，改到 .godot/。沙箱系统证书与用户设置写入提示均未影响场景加载。共同起点最初缺少 painted_whitebox.tscn，由协调方补齐。
- 看图后待修：首轮总体的箱体过于平整。近景终端和检修桌缺少可辨的结构与表面使用痕迹。门右的拨杆连安装底板一起旋转。地板排槽和光照带在前景过于平均。两台风机暗芯和亮叶片的层次优于起点，但表面颜色挤到亮端，参考中的阴影分区仍需深化。此轮为几何、材质、印刷和照明共同结果。

## 最终场景

打开 [final.tscn](scenes/final.tscn) 后在编辑器按 F6。工程 F5 保留原起点。选择检修风机时，节点 MachineRoom/CastIntakeA 与 CastIntakeB 为两片机壳，独立的 Prop_Fan_Small_service 内部使用原资产改出的扫掠叶轮。吊臂位于 MachineRoom/BenchSwingHoist。

| 机位 | 首轮 | 修订 |
| --- | --- | --- |
| 总览 | [首轮图](evidence/pass01_overall.png) | [终图](evidence/final_overall.png) |
| 工位近景 | [首轮图](evidence/pass01_detail.png) | [终图](evidence/final_detail.png) |
| 入口过渡 | [首轮图](evidence/pass01_transition.png) | [终图](evidence/final_transition.png) |

- 按首轮看图修订一次。增加固定于立柱的镂空维修吊臂、卷筒、钢索和吊钩，吊点对准台上的拆卸叶轮。检修区桁架补上连接板和六角螺栓，工位下增加抽屉与拉手。入口开关的安装座与拨动部分分开造型，右侧拨动后底座仍竖直。
- 运输箱有跨面包带、角护和备品标签。终端屏明确显示 B 路停机，底座保留通风口和检修面板。A 路为绿灯、B 路为红灯。另从共同许可素材区比对了 Prop_PipeHolder 的实际网格，将带框的成束备件装到检修墙左侧。源模型为 Quaternius 免费版 Modular SciFi MegaKit，使用保留原拓扑的 kit/revision/pipe_cartridge.gltf，重新接到本场共用的贴图。
- 修订的 enamel_revised.gdshader 用 key_threshold（0.36）控制局部硬光切换，hatch_strength（默认 0.16）控制模型阴面排线，trim_strength（有原色图时 0.70）保留原 UV 纹理信息，relief_strength（有原法线图时 0.80）将凹槽边缘转译为印线。墙面网点光斑按灯具位置固定于世界坐标。地面 tread_revised.gdshader 用 slot_length（0.19 米）和板块编号改变防滑槽节奏。顶部钢板的压缝由独立 roof_sheet.gdshader 控制。
- 最终总览能同时读出运行/停机、备件与检修区。近景能看到吊具投影、终端显示以及涂装和铸造边缘。仍有弱项：右墙两幅三角光斑的轮廓较规整。前景两根导向线的收尾略生硬。近景的抽屉面板能看出厚度较浅。两台风机沿用同一铸件，视觉差别主要来自标记和状态灯。
- 实际美术制作共 2 轮。图形捕获共 2 次、6 张，GPU 队列等待分别为 0.00 秒与 0.00 秒。两轮均成功，无图形捕获失败或重拍。环境依赖探查 1 次失败，另有 1 次日志目标不可写和沙箱全局设置/证书提示。导入、打开及约束检查完成。Godot 对照起始与最终实例确认 17 个 body、17 个碰撞形状与三个机位一致。未新增用户美术反馈轮次。
- 共同图像来自 [CGWORLD 制作访谈](https://cgworld.jp/article/202306-hifirush02.html)。[主参考](https://cgworld.jp/article/818ee60f0aedfa6eaff670b2e3567f517a8b9ccc.jpg)。[辅参考](https://cgworld.jp/article/11358812b6f69a3ef7162b4a164d34fcc25e2486.jpg)。实现使用 Godot 的空间材质、vertex、fragment 和 light 阶段。[Godot spatial shader](https://docs.godotengine.org/en/stable/tutorials/shaders/shader_reference/spatial_shader.html)
