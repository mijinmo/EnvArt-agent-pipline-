# 意航员 2：原白盒约束下重新制作

用户指出上一批没有使用原白盒并要求重跑。本次从输入中的完整白盒重新选材与制作，不继承任何旧成品。按本包 godot-envart skill 执行，不需再等逐步批准。

## 必须保留的真实输入

`source/whitebox.tscn` 是用户原始 `demo/controller_lab.tscn` 的物理几何精确提取，含17个StaticBody3D；`source/whitebox_manifest.json` 记录源哈希与尺寸。只剥离旧UI/标签/相机/光照，没有重建地板或重新布局。最终 `draft.tscn` 必须实例化它并命名为 `BaseWhitebox`，保持父变换为单位。`whitebox.tscn` 是可以直接复制为新场景的完整包装。

所有原碰撞、变换、尺寸、layer/mask必须保留：32×32米地面；后墙；右侧折墙；门左右柱/门楣（中心z=-4，净宽1.2m、净高2.3m）；x=-6的3m宽18.43495度坡道及平台；x=5的四级台阶；三个跳台；SpawnPad。不得删除、移动、缩放、关闭碰撞或用无关地板替代。视觉覆面也不能改变可行走高度/净空或遮断动线。可对局部占位Mesh作材质覆盖/隐藏，并以真实资产替换外观；源文件本身不改。原跳台、台阶上表面与通路保持开放，门双向及坡道可通行。

制作重点：门洞、右侧工作/道具区及连接左坡道的一段过渡，约 x=-8..10、z=-10..2。把此范围的地面、门槛、主要建筑和道具做完整；其他白盒区域保留并明确未完成，不擅自扩成完整关卡。三个相机已冻结，1280×800：overall检验原布局，close检验门洞与相邻细节，transition检验坡道/平台/门洞的空间关系。不能为了构图移动白盒或相机。

空间意图：室内复古发明工坊。原门洞是后场入口，右墙边为工作/展示区，原坡道连高位工作平台；参考原作非对称轮廓、青绿屏幕、暖色展盒与机械道具。不要用巨大中央机器堵门或封死纵深。

## 美术要求与参考

实际查看 `.work/references/` 的本游戏参考，`reference-brief.json`保留来源与限制。原图用来确定风格、形体和材质，不覆盖上述关卡布局。可补查本游戏真实环境图，标明主依据/补充；原神活动街景位置未核实，仅作色彩补充。不要接触其他案例或旧成果。

主要可见建筑/地面/props先检索、下载、检查可交付素材及许可，再装配；大面积自制程序方块不能代替检索。素材族的形体、贴图细节尺度、植物与props应一致，避免规整箱堆和重复装饰。按功能/叙事活动分组、落实支撑/接触和受控疏密。早期建立合理光源与明暗主次，不用黑暗掩盖缺口。可用Blender适配与专用shader，但不能仅加描边就认作风格达标。记录实际免费文件与AI生成来源标注；受限不可再分发模型只作参考。

## 交付流程

1. 先看已提供的原白盒三图和原作参考，记录简短 RESEARCH.md：局部与白盒构件的对应关系、参考可见依据和实现假设。
2. 下载并检查代表性建筑+道具素材，做Godot小样，实际查看整体/近景/过渡三图再决定。最多比较两个有意义的组合，不能只下载后不看样。
3. 完成 `draft.tscn`，重开保存场景拍 `captures/draft/` 三图并逐张查看。修复明确缺陷后用新目录如 `captures/reviewed/` 出图，禁止覆盖旧证据。旧版本资源通过阶段Git提交保存；不要做无限细化。
4. 写 README.md（F5、5/6/7书签、沿用控制器、当前阶段、白盒保留和未完成区域），ASSETS.md（来源作者许可免费范围适配），REVIEW.md（实际三图自查、主要不足与 awaiting_user_calibration）。每阶段本组Git提交，保留.uid/.import，排除.godot/.work/ZIP。完成代表性局部和必要修复后停止。

输入冻结：`source/`、`whitebox.tscn`、views.json、capture.gd、verify_whitebox.gd、inspection.gd/tscn、controllers/、characters/不得改。`project.godot`仅改默认场景/必要渲染设置，不改输入、app名或分辨率。中性捕获和正式稿白盒结构检查由协调端执行，缺少任何原构件或碰撞变形会拒绝正式稿出图。不要另造控制器、交互UI或通用测试框架。

## 工具与隔离

所有Godot导入与图形捕获用 `python3 render.py import`、`python3 render.py capture 场景.tscn captures/新目录`；Godot4.7.2 Metal Forward+，GPU串行。Blender可用 `/Applications/Blender.app/Contents/MacOS/Blender`；Python为 `/Library/Developer/CommandLineTools/usr/bin/python3`。headless必要适配可使用自己的 `.work/runtime/Godot.app`。只读写本组及.work、安装工具、公开来源；禁止父目录、宿主仓库、其他组、全局聊天/日志、其他Git或缓存。不得联系/派生agent，不通过网络本地服务或图像工具绕过边界。共享MCP不提供给独立制作组；协调者仅对自己的目标工程使用。图像工具只能查看本组图片。公开网络失败可有限尝试 HTTP代理 `http://127.0.0.1:8118`，不访问管理接口。
