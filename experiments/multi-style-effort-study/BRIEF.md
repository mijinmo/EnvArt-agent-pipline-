# 三种美术方向 · 同输入 effort 续作试验

模型统一 GPT-6.2 astra，显式 low / medium / high / xhigh。每种风格四个相同起点，四组各两轮完整制作。此轮续作比较素材适配、造型、细节、风格统一及光影，不测新资产包检索能力。Hi-Fi Rush 的先前排名不能预设本轮结果。

## 共同任务

读本仓库 skills/godot-envart/SKILL.md，按需要读其 references。先实际看本游戏 INPUT.md 中所有参考图、evidence/start 三张实际起点图与真实资源；诊断参考与目前场景差距，改善这个完整局部。可改造真实资产的几何、纹理、材质、shader、陈设与灯光。针对有依据的风格机制可以自制 shader，但没有强制 shader 或 outline 指标。保留可近看的物件、材质身份、合理支撑和活动线索。观察和技术假设分开，不声称恢复了原作算法。

只写自己的 run 目录与个人临时文件。baseline/、start.tscn、evidence/start_*、source_* 与 input-freeze.json 冻结；新增版本引用副本资源，不能原地修改冻结 shader/贴图影响起点。素材可读范围见 INPUT.md，禁止读取其他 run 或 Hi-Fi effort 成果、比较结论、其他游戏完成场景。禁止下载新资产包或换参考，以免把资源差异误当 effort 效果。源工程与旧版不改。

## 空间与保护

游戏内已选局部范围不扩全场。17 个原白盒 StaticBody3D 的位置、旋转、网格尺寸、碰撞尺寸/变换、层/掩码及通行净空必须保持。相机路径见 INPUT.md；三个相机位置、朝向、FOV/投影不变。灯光可以改，时间性 shader 对比要固定相位。白盒形状保留不是把视觉表面留灰模的理由；视觉装饰也不能堵门/坡道。不开新控制器、巡检 UI 或玩法验证套件。

## 相同制作额度

两轮：第一轮保存 pass01.tscn，保存重开并输出三张 pass01 图；自己看这三张图后修订一次，保存 final.tscn 和 final 三张图，实际查看后交付。引用的可变资源也要分轮冻结，保证 pass01 可重新打开。允许小型材质试样；技术修复不算艺术轮次，记录次数和原因。制作软目标约30分钟，超时报告实际剩余工作；不为赶时间交未看过的截图，也不无限打磨。父 agent 在全部制作结束前只处理技术阻塞，不额外提供美术方案或差异化反馈。

图形出图统一临时工具（GPU 串行，制作并行）：

```sh
python3 /private/tmp/multistyle-effort-render.py --path /绝对路径/自己的run --rendering-driver metal --script res://capture.gd -- pass01
python3 /private/tmp/multistyle-effort-render.py --path /绝对路径/自己的run --rendering-driver metal --script res://capture.gd -- final
```

capture.gd 自带三个机位及1600×1000分辨率，写 evidence/<轮次>_<机位>.png 和白盒/相机简表。图形启动首次即可按需 require_escalated，说明只打开自己工程和写 evidence。不要用 headless 截图。导入和必要约束检查足够，不另造框架。固定截图可用于判断静态画面；未看移动镜头就不声称时间稳定性。

## 提交与交付

每轮完成后创建本地提交，只暂存自己目录；提交前检查整个暂存区归属。如有其他组提交，等待其完成。不得提交 .godot、临时脚本、日志或更改原工程既有51个.import。新资源 .uid / .import 要提交。第二轮完成把 project.godot F5 改到 final.tscn。

自己的 README 写清参考观察、素材选择/改造与许可、新几何和 shader 参数、两轮读图诊断、剩余美术差距、实际轮数/技术重拍/等待。给出 final 可编辑场景、两轮三机位及本地提交。不要猜测档位优劣或声称用户已验收。

## 统一比较

父 agent 完成后盲看图评价参考贴合、素材与造型统一、细节活动可读性、灯光和全局部一致性。运行元数据核实实际 model/effort，记录墙钟时间、非缓存/缓存输入、输出（含 reasoning）及其子集。缓存差异、共享机器排队和单次随机性需说明；tokens 不是订阅扣费，也不假定 API 单价。每游戏每档仅一次，结论是本工作量下的暂定选择。
