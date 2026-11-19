# Hi-Fi Rush 同输入 effort 试跑 · 2026-11-19

用户观察：现有案例仍像套了一次 outline，模型与材质没有表达漫画风格。要求同一批内容尝试更高及多个 effort 档位，以实际环境美术收益判断性价比。

四个独立副本从已提交的 Hi-Fi Rush 第三轮继续，起点完全相同。共同模型 GPT-6.2 astra，显式指定 low、medium、high、xhigh；具体运行参数与用量由父 agent 读本次对应会话记录核实。上一轮运行记录现已证实为 low，但它的输入/工作量不同，不作为本次 low 档样本。

## 制作任务

使用本仓库 skills/godot-envart/SKILL.md 及其风格化着色指引。实际看起始三机位和两张共同参考，从图像诊断为什么现有模型/材质表现不足，自主改善这一处室内双风机检修区的漫画环境语言。允许调整真实素材几何、材质、贴图、shader、灯光和本局部陈设；效果应体现在可编辑场景中，不能只有后期加粗轮廓。做什么技术方案由制作 agent 决定。

只编辑分配的 run 目录。保留 scenes/start.tscn 和 evidence/start_*。原 17 个白盒 body 的尺寸、变换、碰撞及通路和 Views/overall、detail、transition 三个相机的位置、朝向、FOV 不变。围护不拆，全场不扩展。其他三个试跑目录及其结果禁止读取，避免互相污染。原主工程与既有 Control/Sable/DREDGE 不动。

## 共同输入与允许资源

- 主参考原图本机 /tmp/hifirefs/51.jpg；来源 https://cgworld.jp/article/202306-hifirush02.html ，具体图 https://cgworld.jp/article/818ee60f0aedfa6eaff670b2e3567f517a8b9ccc.jpg 。实际查看，不只读文案。
- 辅助图 /tmp/hifirefs/60.jpg；具体图 https://cgworld.jp/article/11358812b6f69a3ef7162b4a164d34fcc25e2486.jpg 。环境材料与设备参考，角色/UI不制作。
- 自己工程内 art/graphics/shaders/source 是相同副本。可读原主工程 envart/assets/quaternius_scifi 与 quaternius_scifi_props 的原始授权模型作候选，不能照抄其他完成场景。这轮不再下载不同资产包/另找不同游戏参考；素材适配而非新资产检索是本次比较范围。
- 可查看共同来源文章和官方 Godot/Blender 技术资料；遵守相关实际适用 skill。允许编程处理模型及贴图，保持素材来源记录，不能用一组新程序方块替代主要资产。

## 相同工作额度与交付

每组相同的两轮制作：第一轮实现并保存 scenes/pass01.tscn，保存/重开并捕获三个固定机位；自己看图后进行一次修订，保存 scenes/final.tscn 和三张 final 原图。局部 shader 小样可以先做，技术故障修复不算新的美术轮次。以约 30 分钟为制作目标；时间是软目标，不是用户授权/等待的替代，也不是自动终止。超过时先报告实际剩余工作，避免无限打磨。父 agent 不在比较完成前给任何一组额外美术方案或反馈。

必要检查仅导入、加载、实际图形出图、修改直接涉及的白盒/相机约束；不跑玩法回归，不造控制器/交互工具/测试框架。截图 1600×1000，Godot 4.7.2 Metal Forward+，不能用 headless 截图充数。每组制作和出图次数必须记在 README 中；命令失败与环境等待也记录，便于判断耗时偏差。

按原 capture.gd 捕获 pass01/final。所有出图通过 /private/tmp/hifi-effort-render.py 启动 Godot，同一时刻只允许一个图形捕获进程使用共享 GPU；包装脚本不改项目。为规避沙箱下图形启动错误，首次图形捕获可直接按需要申请 require_escalated，说明只加载自己的工程和写 evidence。

每个独立阶段只提交自己 run 目录文件，提交前核对暂存区归属；如果其他 agent 正在提交，等待其完成。最终交付可编辑 final、两轮三机位、简短参考观察/素材和几何材质改动、shader 参数、看图不足与实际轮数。不要自行宣布“本档最划算”或猜其他档表现。原工程已有 51 个 .import 修改不碰。

## 比较边界

父 agent 最后统一比较漫画风格表达（尤其材质/体面/光影而非轮廓单项）、模型与道具统一、细节可读性和白盒保留；结合实际耗时、缓存输入、非缓存输入及输出 token。输入 token 含多轮重复上下文，不能直接当成账单；本次不假设订阅扣费或 API 单价。各档只有一次完整试跑，因此只给本工作量下的暂定取舍，不声称统计最优或普适模型能力。
