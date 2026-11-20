# 盗贼之海 — 代表性局部初稿

用户已授权直接开始四个新游戏局部制作，不需再等逐阶段批准。你只负责当前案例，不得获取其他案例信息。以本目录 skills/godot-envart/SKILL.md 为工作方法。

## 目标与已知审美要求

Port Merrick 酒馆地窖：石拱门、储藏架、桶箱与绳索/灯具。空间类型：室内。重点：厚实夸张形体、绘制感表面、素材族统一与冷暖层次。
主要可见建筑与 props 必须先检索、下载并查看真实许可素材，再装配。程序方块只能作为白盒/必要缺口，不能作为成品主建筑。需要有功能叙事的道具组合、可近看表面、完成的地面/门槛/接触和疏密层次。灯光从小样开始，不靠黑暗/浓雾掩盖问题。不要把风格偏差改名成新方向。模型比例、贴图与光照共同匹配参考；允许 Blender 适配及专用 shader。首轮三风格因白盒感/缺 props 失败，不继承任何历史成果。

## 起点与边界

本轮是不同艺术方向的独立局部生产，不是 effort 排名。没有继承成品。提供只有地板碰撞的 whitebox.tscn 与中性巡检基础设施。完成局部在 x=-5..5, z=-4..5 左右，室外可延伸必要远景，主要局部不超过约 12×12m。建筑/柜台主要在 z≈-3 一带，留 x≈0、z=0..4 至少 1.2m 访问通路。恶意不息例外：石桥跨 z=-4..4，可把地面碰撞改成桥面/岸边，保留贯通的可走路线；俯视视点不要擅自变成第一人称艺术目标。

参考状态及原始来源在 reference-brief.json；图像在 .work/references/。你必须实际查看它们。可以独立补查同游戏/同区域的公开实机截图，修复可读性缺口；先记明主参考/补充/拒绝、可见依据与限制，再选素材。不是冻结参考的 effort 实验，参考发现属于本次工作。原神两张活动街景只作补充，地点/活动未经核实，不作为离岛完整建筑证据。确定主参考后不要越做越换方向。

提供整体 overall、近景 close、过渡 transition 三机位，1280×800，Godot 4.7.2 Metal Forward+。可在灰模/素材小样阶段根据空间合理性一次调整 views.json 并记录原因，在正式 draft 前冻结；禁止后续为了掩盖缺陷改机位。inspection.tscn 复用现有控制器（5/6/7书签；1/2人称、3自由巡检、WASD/鼠标、Q/E、Esc）。实例到新场景；不要另造控制器、UI、功能回归。

## 必须完成的实际工作

1. 查看参考并补足当前局部所需环境依据，写简短 RESEARCH.md 与原始来源。
2. 独立搜索合适建筑/表面与叙事 props 素材族，核对实际免费范围和许可；下载检查代表物，不用付费完整版图冒充免费内容。先做至少一个包含主墙/地面及相邻代表 props 的真实 Godot 小样，查看图片再选材。最多对两种合理组合做有用比较，不为形式拼无关小样。
3. 组装一个可判断方向的完整局部，主要建筑、地面/门槛、主要道具、材质和基本光照必须都有。保存 draft.tscn，重开捕获 captures/draft/overall.png、close.png、transition.png。实际查看三图，修复缺贴图、暴露灰模、错误遮挡、完全黑画面等明确缺陷；修复证据另存目录，不能覆盖旧图。暂不投入全场扩展或无止境小装饰。
4. 写 REVIEW.md：按参考一致性、素材统一、功能道具/密度、光影指出至多三项主要剩余不足，标注 awaiting_user_calibration。不宣称用户验收。用户让自主执行不等于美术认可。
5. 交付可编辑场景、素材及许可证、README.md（F5、操作、当前阶段）、ASSETS.md（源/作者/许可/免费实际文件/适配/小样结论）、参考记录及截图。主要可见3D资产要允许当前仓库再分发；受限素材只用于参考不能作为交付。每个可检查阶段在本独立 Git 提交；保留 .uid/.import，排除 .godot、.work、ZIP、日志。
6. 完成初稿及自查后停止，把最终使用的场景、capture目录和未解决项说清。不要只做计划，不等批准，不启动额外 agent。

## 工具和渲染

Python /Library/Developer/CommandLineTools/usr/bin/python3；Blender /Applications/Blender.app/Contents/MacOS/Blender；Godot .work/runtime/Godot.app/Contents/MacOS/Godot。所有导入/图形出图用 python3 render.py import 或 python3 render.py capture draft.tscn captures/draft。素材小样也用同命令换场景/输出目录。协调端串行 GPU，等待不算制作速度。不修改 capture.gd/render.py/inspection.gd 或现有 controllers/characters。
直接 headless builder 可在本目录运行，需 Metal 才能保留资源的 builder 可将其设为场景 tool/init 脚本通过正常运行生成，或说明技术阻塞。网络可查公开素材；直连失败可使用 http://127.0.0.1:8118 代理，但禁止查询本地管理服务。不要长时间纠缠同一失败下载。

## 严格隔离

仅可读写本项目与 .work，必要安装工具、公开来源；不得读取/列出父目录、宿主仓库、其他工程/会话/日志、其他候选产物或全局缓存。禁止用浏览器、插件、MCP、网络本地服务绕过边界；view_image 仅本组图片。不得派生或联系其他 agent。已有许可失败先记录，不能绕过限制。

## 本包交付状态

当前阶段为 awaiting_user_calibration。F5 打开修正后的 [draft.tscn](draft.tscn)。[修正后三机位](captures/reviewed/) 与 [首版三机位](captures/draft/) 均已存档；参考与素材决策见 [RESEARCH.md](RESEARCH.md) 和 [ASSETS.md](ASSETS.md)，未解决项见 [REVIEW.md](REVIEW.md)。
