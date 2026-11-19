# Hi-Fi Rush · 四档 effort 同输入试跑

查看 [HTML 三机位实机对照与用量](../../docs/hifi-effort-study.html)。四组都从上一轮 Hi-Fi Rush 第三轮继续，使用同一白盒、参考和素材池，各制作两轮；收到共同用户批评后自主改进，制作中没有得到分组美术反馈。原项目与旧版保留。

| effort | 工程 | 最终场景 | 墙钟耗时 | 输出 token，含推理 | 阶段提交 |
| --- | --- | --- | ---: | ---: | --- |
| low | [run-b](run-b/project.godot) | [final](run-b/scenes/final.tscn) | 9.77 分钟 | 14,556 | f473998 / 0a8d8dc |
| medium | [run-d](run-d/project.godot) | [final](run-d/scenes/final.tscn) | 16.07 分钟 | 26,016 | 6e47931 / 5aa9537 |
| high | [run-a](run-a/project.godot) | [final](run-a/scenes/final.tscn) | 17.95 分钟 | 30,142 | b0e3944 / 25d46f1 |
| xhigh | [run-c](run-c/project.godot) | [final](run-c/scenes/final.tscn) | 24.15 分钟 | 41,573 | 5b1776b / 8c298d2 |

用 Godot 4.7.2 打开各工程，F5 为最终场景；`scenes/start.tscn`、`scenes/pass01.tscn` 可用 F6 查看冻结起点与首轮。各工程 README 说明具体制作及参数。`evidence/{start,pass01,final}_{overall,detail,transition}.png` 是实际引擎图，1600×1000，Metal Forward+。

本局部暂选 **high** 作为完整局部制作的默认档位。独立视觉评审在未获知 effort 和用量的情况下给出 C > A > D > B，即 xhigh > high > medium > low；C 与 A 接近。high 比 medium 多约 1.9 分钟、15.9% 输出 token，改善主要在主机、家具、标识和光影的协调；xhigh 比 high 多约 6.2 分钟、37.9% 输出 token，整体更统一但提升幅度较小。输入 token 也不同，完整原始数据见 [usage.json](usage.json)，不能把输出比例当成费用比例。

low 最省，适合快速视觉提案，但仍有明显的材质混杂。medium 的风机特写最好，周边却不够统一；这次耗时已接近 high。xhigh 可用于特别重视最终近景的局部，尚无证据支持全程默认使用。四组都有实际造型改变，low 也比旧起点进步，因此旧版到本轮的全部改善不能归因于 effort。

这是单次、固定局部下的暂定取舍；没有精确订阅扣费，亦未假设 API 单价。缓存输入、非缓存输入、输出及其中推理分别记录；耗时包含工具、审批、导入与返工。首批共同依赖遗漏已统一修正；medium 后启动，缓存条件也不同。评审及父 agent 组织工作不计入表内生产组。未跑控制器或玩法回归。

原 17 个白盒实体和相机由各制作 agent 直接核对。父 agent 另外确认四组冻结起始场景及其已有源素材未被修改，并看过全部十二张终图。只将默认入口统一切到 final，未改已评审的美术或截图。

[共同任务](BRIEF.md) · [评审依据和独立图像评价](REVIEW.md) · [模型映射](run-manifest.json) · [参考标识](reference-manifest.json)
