# 素材与许可

|来源 / 作者|核对过的免费内容|本项目的取用|
|---|---|---|
|Quaternius，Modular Sci-Fi MegaKit|Standard ZIP 中有 191 个 OBJ 条目及 FBX、glTF、贴图。包内 License_Standard 明确这是免费子集，CC0 1.0。|从 glTF 和共用 trim sheets 取墙、线槽、地板、门套、终端与运输件。|
|Kenney，Factory Kit 3.0|下载包内有 143 个 OBJ 及相应的 GLB、FBX，另附调色板、独立预览与 License。CC0。|从 GLB 取带关节机械臂、管件、滚筒、开关与装卸道具。|

作者目录与本次实际取包页分别为 [Quaternius](https://quaternius.com/packs/modularscifimegakit.html)、[其 OpenGameArt 免费包](https://opengameart.org/content/modular-sci-fi-megakit)、[Kenney](https://kenney.nl/assets/factory-kit) 和 [其 OpenGameArt 包](https://opengameart.org/content/conveyor-kit)。两包允许商业使用、修改与再分发。原包许可保存在 [art/licenses](art/licenses)。

## 引擎小样

`sample_a.tscn` 和 `sample_b.tscn` 共用东墙整段、回墙、地板、梁灯、灯位与曝光。每个墙跨约 2.5 m，门后远墙还可观察较长距离的重复。A 使用重配色的 PBR 材质。B 在相同材质上用 Forward+ 深度和法线检测遮挡轮廓、折角，并给暗面叠少量印刷点。可调参数为 ink_density、bend_threshold、screen_tint。[A 实图](captures/sample-a) · [B 实图](captures/sample-b) · [空间 shader 接口](https://docs.godotengine.org/en/latest/tutorials/shaders/shader_reference/spatial_shader.html)

实际看图后选 B。close 里，B 的机械臂外缘和前后夹爪有了墨线，仍能看清橙色漆面转折；A 的夹爪和邻近亮墙分离较弱。右墙采用平板的中央留白作设备背景，把带凸肋的 Astra 墙留到两侧。带横带的 WallBand 适合回墙收边，整面重复会同时重复小厂标。地面模块接缝近看清楚，但整体只有蓝灰一种值，生产轮需要标清滚筒操作边与门前通道。

小样发现，源箱盖带骨架，按普通单根网格重设根节点后，运输箱没有显示。小样保留这一诊断现场。在生产场景另做静态箱体。两组 A/B 中可见的比较道具是终端和机械臂。

## 文件与适配

- `art/modules/` 的 GLB 采用与原件相同的文件主名。重设单件底面中央安装点，保留几何、UV 与法线。源墙宽 4 m、主体高约 3 m，沿切线缩放跨距。源门框宽约 4.85 m，已移去近地门槛的面。墙、顶边、两种地板、电脑、货箱、护栏、灯、通风口均可在资源面板中独立打开。
- `art/surfaces/T_Trim_0{1,2,3}_Enamel.png` 从对应 BaseColor 分别重映射为冷喷漆、亮边与深结构缝，把部分源法线方向和遮蔽烘到颜色中。Normal 和 ORM 缩至 1024，保留 UV、减弱运行时法线与金属度。Decals 保留源 alpha。厂标和终端原生屏保来自源图集。
- `art/factory/` 保留原件的网格和本地枢轴，替换共用色表。robot-arm-b 原高约 3 m，有七段父子层级，将其摆成待取货姿势。直管轴沿 X，阀门和弯头按管径配套放置。`Factory_enamel/pipe/robot.png` 由包内 colormap 按主体、管身、机械臂分别着色。

## 首轮新增资产

TransportCase 由 Prop_Chest 的闭合底盘和箱盖恢复，作为无骨架静态件使用。TransferArm 在 robot-arm-b 的各段上单独分配轴承、夹爪和涂漆。两件均继承各自来源的 CC0 许可。FoldedShell、Plinth 为本站补制的折板外壳轮廓，供门柱、工位底座和显示器安装件共用。步行钢板与防滑纹以本包 Trim 03 改色底面为基础，加入印刷磨损和花纹。

`art/marks/` 的面板图、电芯示意、HOT SWAP! 安全海报、喷字和警示贴为本站绘制。使用 Barlow Condensed 家族的 Bold、Black Italic、SemiBold 字形烘成图像。字体作者为 The Barlow Project Authors，OFL 1.1 随附于 art/licenses。字体文件没有作为运行依赖。[字体作者目录](https://github.com/google/fonts/tree/main/ofl/barlowcondensed)

## 最终版的资源归属

`art/final/` 单独保存最终版改动。各机位使用同一组实体摆放。

|文件或资源组|来源与处理|
|---|---|
|WallAstra_Straight、WallBand_Straight|Quaternius 原部件的最终副本，移去重复的厂标贴面，其余表面继续使用样片选定的原 UV 和改色图集。|
|FloorPlating.obj、deck.gdshader|Quaternius 的 Platform_Squares.obj 保留几何、UV 与作者法线，替换原电脑上的 MTL 路径。基于 Trim 02 取色和起伏，按实际米数铺设另绘的磨损图，轻度分段直接光。步行道与防滑边按原跳台位置折弯。|
|ReleaseTerminal.glb|Quaternius Prop_Computer 的独立副本。取原屏幕斜面外沿补成连续三角面，保留机壳及底座，映射本站绘制的 RELEASE 界面。|
|MainLoom、SignalLoom、FormedElbow|按 Kenney 机械臂已摆好的关节位置和墙角接管位置专门制作的连续管线网格。轴销、压圈、跨接支撑件和实际灯具由 Godot 场景中的实体节点组成。|
|印刷图、铭牌与表盘|本站原绘的图案与 Barlow Condensed 字形。最终贴图单独启用 mipmap，屏幕、喷字和不透明搪瓷牌分别配置材质。|
|press_ink.gdshader|从小样 B 选中的深度与法线描边调整而来，额外在中暗明度加细排线。深度断面、法线折角和暗部网点可在 ShaderMaterial 中调节。|
