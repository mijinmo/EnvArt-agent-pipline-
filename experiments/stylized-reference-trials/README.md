# 风格化游戏环境参考试跑

先看 [三方向 HTML 同机位对照](../../docs/stylized-reference-trials.html)。每组可切换整体、工位近景和门洞，以及原白盒、独立首轮、自主第二轮、第三轮 shader 对照。第三轮收到主 agent 的看图反馈；前两轮由各 subagent 自主完成。

| 方向 | 打开工程 | 最新可编辑场景 | 来源与参数 |
| --- | --- | --- | --- |
| Sable，室外修理棚 | [project.godot](sable/project.godot) | [round03.tscn](sable/round03.tscn) | [说明](sable/README.md) |
| Hi-Fi Rush，室内检修区 | [project.godot](hifi-rush/project.godot) | [scenes/round03.tscn](hifi-rush/scenes/round03.tscn) | [说明](hifi-rush/README.md) |
| DREDGE，半开放港边工位 | [project.godot](dredge/project.godot) | [round03.tscn](dredge/round03.tscn) | [说明](dredge/README.md) |

Godot 4.7.2 / Metal Forward+，各工程 F5 打开最新版本。场景保留真实源素材、许可、可编辑对象与 shader。截图为引擎原生 1600 × 1000 输出，原游戏参考仅保留来源链接。复拍命令见各工程说明。

共同输入为原测试场的 17 个 StaticBody3D；主工程与旧 Control 保留。每组只做门洞和墙边的局部，远层仅辅助。各组镜头固定，但不同游戏的构图并不相同，不能跨组当成受控 A/B。详见 [BRIEF.md](BRIEF.md)。

三个 subagent 均指定 GPT-6.2 astra；reasoning_effort 未显式传入，工具约定继承父任务，具体档位未核实。这不是 effort 对比实验。素材主要复用既有 Quaternius/Kenney 授权库，不能据此认定新资产检索能力提升。可观察到的进展集中在道具活动组织、配色适配与有范围的实机反馈。原作主体造型、材质层次及局部外的完成度仍有差距，用户美术验收待定。

制作阶段分别提交；第三轮为 Sable `dccb436`、Hi-Fi Rush `70ca3df`、DREDGE `d2dfb9c`。Shader 指引和共同条件见 `5589d0f`。
