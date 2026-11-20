# 跨机器接续说明

更新：2026-11-20。本文件是新主 agent 的当前接续入口；历史报告保留当时状态，不作为下一步启动指令。

## 当前状态与本次范围

- 原 MacBook 已保存四游戏 × 四档的 16 组续作结果及历史 HTML。Mac mini 随后完成四游戏 × 六档的 24 组独立制作、144 张两轮三机位实图与四份独立盲评；[报告](gpt62-independent-matrix.html) 和 [正式工程/审计](../experiments/gpt62-independent-matrix-20261120/README.md) 均已在当前仓库。本轮与旧轮次的起点、参考和素材访问条件不同，小样及自查仍有已披露的遵循缺口；完成制作不代表用户美术验收。
- 用户反馈的是 **Codex 实际额度下降明显**，并认为整体效果不如旧轮。已讨论起点、预算分散、视觉决策与主 agent 前置知识的影响；没有完整主会话证据，不能确认“主 agent 缺少上下文”就是唯一原因。
- 用户已同意新增审美校准及明确的 A/B/主 agent 分工。本次授权落实到规则、项目审美交接、教程与 Git；**新流程的质量和额度收益仍未验证**。
- 原 MacBook 不启动 Godot。后续制作在 Mac mini 按接续任务的范围进行；拉取文档本身不启动新试验、不自动重跑六档矩阵、不扩展全场。

2026-11-20 在 Mac mini 拉取 `2c4f004`、`fe1e217` 后，与本地截至 `12659f1` 的 45 次制作/报告提交合并；保留全部场景、截图和独立历史。此次仅整合文档与规则，没有启动 Godot 或新一轮试跑。

### 合并后的新参考方向

用户随后同意首批采用 **《盗贼之海》《意航员 2》《恶意不息》**，并要求“追加一个纯二次元的吧，比如原神”；第四项采用 **《原神》**。当前范围、具体图像来源及筛选限制集中记录在 [本轮局部 brief](../experiments/stylized-local-pilots-20261120/brief.json)。原神先以稻妻·离岛店铺街角为局部提案，检查木构/屋檐、货架与器皿、布料、石板路和植物的二次元环境表达；区域细化是 agent 提案，不是用户指定。

按已讨论顺序先做盗贼之海地窖；每个方向一个代表性局部，出整体/近景/过渡实机图后校准，再集中修改。当前完成的是选择与初步图像检查，尚无新场景或冻结的完整参考输入；不把参考认可当作成品验收，不自动扩展六档矩阵。独立候选继续隔离输入、目录与 Git 历史。

## Mac mini 拉取后先做什么

先保留 Mac mini 上已有场景、未提交修改与试验记录，检查所在分支。对于跟踪 `origin/main`、工作区已妥善保存的 checkout，可执行：

```sh
git status --short --branch
git pull --ff-only origin main
git log -2 --oneline
```

若不能快进，先检查本地提交与远端差异再整合；不要用 reset/clean 丢弃制作机上的成果。远端新提交与未提交成果的整合属于 Git 工作，不需要重跑 Godot。

主 agent 的阅读顺序：

1. [AGENTS.md](../AGENTS.md)：项目约束和机器运行边界。
2. [项目审美要求与验收依据](art-direction-memory.md)：用户已明确的要求、范围和未确认事项。
3. 仓库内 [godot-envart skill](../skills/godot-envart/SKILL.md)，本次新增重点为 [审美校准与接手修改](../skills/godot-envart/references/aesthetic-calibration.md)。
4. **制作机上当前任务**的 ENVIRONMENT、brief/review 和实际场景版本。先恢复其当前状态，不能按本机旧报告把它重置为早期 Control 或空白项目。

在任务入口注明采用的 Git 提交、当前场景/证据、已知用户要求与待校准项。主 agent 读历史是为了恢复目标；交给制作组的输入只保留任务所需部分，独立比较的候选之间仍隔离。

## 下一轮实际工作顺序

| 阶段 | 负责人 | 本轮产出 |
| --- | --- | --- |
| 恢复任务与审美目标 | 主 agent | 将已知用户要求写入当前 brief；列出真正未决的视觉取舍。 |
| 代表性方向初稿 | A / 制作 agent | 一个有建筑、地面、主要道具、材质与基本光照的可编辑局部，以及整体/近景/过渡实机图。已有合适初稿时直接使用。 |
| 审美校准，方向有分歧时 | 主 agent + 用户 | 用户指出应保留的特点、最影响观感的问题及是否继续该方向；主 agent 转成可观察的修改目标。 |
| 定向改进 | A，或已授权接手的 B | B 先独立看图诊断，再读工程并修改；接收同一份用户要求。默认一次交接、一轮聚焦修改。 |
| 同机位复核 | 主 agent | 检查问题是否改善、其他视角是否退步，保留较好版本；最终美术验收仍由用户决定。 |

这不是每轮审批。已经清楚的方向自主推进；关键审美分歧未得到答复时保持未决，只推进不依赖该选择的工作。不要把未回复变成接受，也不要用标签、小道具数量替代主造型、材质语言和光影的改善。

同一候选 A→B 是声明过的接续输入，允许继承；其他候选的图像、方案和评论保持隔离。B 的结果标为接手修改，不称为从白盒独立生产。若以后专门比较 A 自改与 B 接手，两路应从同一冻结初稿和校准 brief 开始，使用相同额外工作额度；这个实验本次没有启动。

用户偏好、场景范围明确后再决定后续制作规模，不默认展开完整六档。新增 agent 的质量/额度收益是待验证假设；统计 token 时说明是否包含协调与评审，不能直接推算 Codex 额度。

## 文档各自负责什么

| 文档 | 维护内容 |
| --- | --- |
| `AGENTS.md` | 简短的项目执行约定与必要阅读入口。 |
| `docs/art-direction-memory.md` | 已明确、可跨轮复用的用户审美要求，含范围、依据与认可状态。 |
| `skills/godot-envart/` | 可复用的制作、校准、交接及独立试跑协议，不内置本项目的全部偏好。 |
| 当前任务的 ENVIRONMENT / brief / review | 当前场景、参考、校准反馈、修改目标、版本、负责人和下一步；实际任务状态的来源。 |
| 场景、素材清单与 captures | 可编辑产物、许可和真实图像证据。 |
| HTML 报告 | 给人看图与理解流程；从上述记录更新，历史排序不自动升格为用户要求。 |
| 本交接说明 | 当前跨机器状态、读取顺序与接续边界。 |

最新明确用户指令优先。新增用户反馈先写当前任务记录；只有适用于后续轮次的要求再更新审美文档。保留用户原话、agent 解释和实图验证的区别。用户只说“比上一版好”，不能记录为整套方案已验收。

## 先看结果，不需要引擎

优先打开 [本轮六档独立制作对比](gpt62-independent-matrix.html)：可切四游戏、三个机位、首轮/最终，揭示档位、用量及管线建议。[旧轮次总览](multi-style-effort-study.html) 另保留此前各方向和迭代版本。实机截图全部使用仓库内相对路径，可离线查看；原作参考图远程引用，需联网，版权归原权利方。

请迁移整个仓库的目录结构，不能只复制 HTML。`docs/` 与 `experiments/` 是页面图片和工程链接的相对位置。

## 打开可编辑场景

使用当前验证版本 **Godot 4.7.2 标准版**，无需 .NET。只导入准备查看的那个 `project.godot`，不要一次批量打开所有项目。工程索引：

- [本轮四游戏六档](../experiments/gpt62-independent-matrix-20261120/README.md)：24 个独立工程，F5 打开 `final.tscn`；重拍命令与下列旧工程不同，使用本轮 README。
- [Control / Sable / DREDGE 四档](../experiments/multi-style-effort-study/README.md)：F5 打开 `final.tscn`；起点与首轮在工程根目录。
- [Hi-Fi Rush 四档](../experiments/hifi-effort-study/README.md)：F5 打开 `scenes/final.tscn`，其他版本也在 `scenes/`。
- [主测试场](../GodotProject/envart-pipline/project.godot)：玩家、白盒、轨迹相机及原三方向入口；操作见根 README。

现有实机证据来自 macOS Metal Forward+。Windows/Linux 使用平台对应驱动，不要复制历史命令里的 `--rendering-driver metal`。专用 shader 对其他后端的表现尚未检查；迁移后只做一次必要导入、打开目标场景和实机查看，发现画面差异再针对修复，不跑全套控制器回归。

已保存 `.tscn` 和资源可以直接编辑，不依赖当时 `/private/tmp` 下的 builder、GPU 排队脚本或 Python 环境。不要运行旧 builder 覆盖手工修订。要重拍时写入新的证据名，不能覆盖已评审图。三游戏的 `capture.gd` 接受场景名和可选输出标签（例如 `final migrated-final`）；Hi-Fi Rush 的旧 capture 不支持单独标签，先复制工程/调整输出目录，再运行。

## Skill 与工程的可移植性

仓库 skill 是这次交接的来源，直接按其路径使用。若 Mac mini 自动加载个人目录中的旧 `godot-envart`，需同步整个 `skills/godot-envart/` 包含 references 的目录，或在任务中明确指定仓库副本；不要只复制 SKILL.md，也不要假定 Git 拉取会同步个人 skills 目录。

后续若重新开展独立比较，仍须按 [独立试跑约定](../skills/godot-envart/references/independent-trials.md) 准备新的干净输入包：明确空间意图、局部范围、同机位和白盒约束，同时提供适用的用户审美要求与允许的原作参考。排除其他候选的成品、评语、shader 和历史 Git；同一候选声明过的 A→B 交接按前述规则处理。每个候选使用独立 Git、临时目录和新上下文；实际只能做到逻辑隔离时须如实记录。固定素材池的比较不能声称是在验证外部素材发现。

不用迁移 `.godot/`、运行日志或 `/tmp` 工具；源文件旁 `.uid`、`.import` 已受版本管理。历史参考清单的临时路径不是打开场景的依赖，重新获取参考时记录实际图像及必要缩放。主工程 Mixamo 角色未提交原始素材，若需要试玩则按根 README 使用自己的下载安装；环境美术试跑不依赖它。

## 转移 Git 和文件

2026-11-19 收尾时提交仅在本地、当时未执行 push；2026-11-20 已确认新电脑从远端克隆得到了 `c763613`。以下保留完整仓库与 bundle 的迁移方法，供后续搬迁使用；本轮阶段提交仍在本地，未推送；独立历史另保存在 `refs/envart-trials/20261120/*`，普通主分支 push 不会自动携带这些引用。

可直接复制完整仓库（包括隐藏的 `.git`），或在本机手动创建 Git bundle，再把 bundle 复制到新电脑。下面只是操作说明，本次没有执行导出或推送：

```sh
# 旧电脑：在仓库目录中运行，输出到仓库外。
git bundle create ../envart-handoff.bundle --all

# 新电脑：在打算存放项目的目录中运行。
git clone /path/to/envart-handoff.bundle EnvArt-agent-pipline
# 本轮自定义独立历史需要显式恢复。
git -C EnvArt-agent-pipline fetch /path/to/envart-handoff.bundle \
  'refs/envart-trials/*:refs/envart-trials/*'
```

bundle 包含所有已提交分支/标签及历史，不包含被忽略的本地素材、缓存、未跟踪文件或远端登录凭证。从 bundle 克隆后 origin 指向 bundle 文件；以后需要联网推送时再配置自己的仓库地址。复制完整仓库则保留原有 Git 配置。

不需要迁移 `.godot/`、运行日志、临时截图和 `/tmp` 工具。源文件旁的 `.uid`、`.import` 已纳入版本管理；新电脑会按平台重新生成缓存。主工程 Mixamo 角色属于本地自用资源，不在 Git 内；若需要人形试玩，按根 README 通过自己的下载重新安装。环境美术试跑工程不依赖这套角色。

## 2026-11-20 新电脑模型与试跑记录

- 已从 HTTPS 远端克隆仓库，起点为 `c763613`，检查时与 `origin/main` 同步、工作区干净；归档提交已随此次克隆到达新电脑。
- 用户明确确认“已换电脑，继续局部制作验证”。旧电脑停跑约定不再阻止本机的必要导入、打开场景和真实出图。
- 用户随后要求先解决 Codex 找不到 GPT-6.2 的问题。桌面更新器报告已安装 `26.1023.51421`（build `22530`，prod），可更新到 `26.1111.71704`（build `29030`）；首次仅完成检查，随后由用户更新。
- 独立 CLI 为 `0.165.0`；其当次刷新后的模型缓存未列出 GPT-6.2，默认配置为 `gpt-6-astra`。这些是本机诊断证据，不能据此判定账户无权限，也不能保证更新后模型一定出现。当时的处理步骤是先更新桌面客户端并重启，再确认模型选择器中的 GPT-6.2 Astra / Sol；[官方发布说明](https://learn.chatgpt.com/docs/whats-new/gpt-62-astra-sol) 已宣布 Codex 支持这两个模型。
- 更新后确认：桌面版 `26.1111.71704`（build `29030`），新模型缓存客户端版本 `0.169.1`；`gpt-6.2-astra` 与 `gpt-6.2-sol` 均为可选，当前工具也列出两者。模型发现阻塞已解除。
- 已接续 [Control 从白盒局部验证](../experiments/independent-control-20261120/README.md)：门洞与右侧档案交接角，独立参考/素材发现，单组两轮；Godot 4.7.2 导入与三张固定机位白盒实图已检查，先行制作已完成两轮，作为不计排名的管线预检。用户随后明确扩大授权：按 [正式 24 组独立制作比较](../experiments/gpt62-independent-matrix-20261120/README.md) 重跑 Control / Sable / Hi-Fi RUSH / DREDGE 的 low、medium、high、xhigh、max、ultra；从白盒重新制作，统一参考，隔离目录和历史，完成后整理 HTML 对比。本轮 24 组已全部完成两轮，四份独立图像盲评、隔离审计和 [HTML 分类对比](gpt62-independent-matrix.html) 已整理；制作与评审进程均已结束。六档实际运行记录均确认 GPT-6.2 Astra，首轮资源冻结完整。仍有小样、自查方式等遵循缺口，用户美术验收尚未完成。

## 用 Termius 接续本条聊天

Termius 通过 SSH 以 `paulchen` 登录存有此仓库的同一台 Mac。2026-11-20 检查时，PATH 中独立 `codex` 仍为 `0.165.0`，应用附带 CLI 已为 `0.169.1`；本条聊天记录已存在于本机。先用应用附带版本接续：

```sh
tmux new -As envart
cd /Users/paulchen/GodotProjects/EnvArtPipline
/Applications/ChatGPT.app/Contents/Resources/codex-cli/CodexCLI.app/Contents/MacOS/codex resume \
  --model gpt-6.2-astra 01a1f4cd-91a4-7201-8d3a-883032c94e1a
```

`tmux` 已安装；断线后重新连接，执行第一行重新附着。接续前等桌面端当前回合结束。`resume` 保留聊天历史并使用当前工作区文件；具体可用工具以 CLI 启动后的状态为准，桌面插件和图形界面不保证等同。以上已验证二进制版本、命令帮助与记录存在，未在活跃回合中再启动第二个 CLI 会话。[官方接续说明](https://learn.chatgpt.com/docs/projects?surface=app)。

## 可复制给 Mac mini 主 agent 的交接语

> 先读 AGENTS.md、docs/art-direction-memory.md、docs/new-machine-handoff.md 和仓库内新版 godot-envart skill，再恢复制作机上当前任务的 brief、场景与证据。保留已有成果，不按历史报告自动重跑。复用用户已明确的审美要求，先用一个代表性实机局部校准剩余方向分歧，再集中细化。A 制作，B 在授权接手时先独立看图再修改，主 agent 对比前后实图复核，用户最终验收。同一候选交接可继承，候选间禁止横读。默认一次交接、一轮定向修改，不自动批跑六档。新流程收益尚未验证；只有实际出图并查看后才更新验证状态。当前任务仅需必要导入、渲染和受影响约束检查，完成可审阅小阶段就提交。
