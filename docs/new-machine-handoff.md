# 新电脑接续说明

截至 2026-11-19 收尾：四游戏 × 四档 effort 的场景和截图均已保存；统一 HTML、隔离规则和访问检查已整理。**新规则下的下一轮验证尚未运行，原 MacBook 不再启动 Godot。** 当时没有后台续跑或自动开始下一批的安排。

## 2026-11-20 新电脑接续状态

- 已从 HTTPS 远端克隆仓库，起点为 `c763613`，检查时与 `origin/main` 同步、工作区干净；归档提交已随此次克隆到达新电脑。
- 用户明确确认“已换电脑，继续局部制作验证”。旧电脑停跑约定不再阻止本机的必要导入、打开场景和真实出图。
- 用户随后要求先解决 Codex 找不到 GPT-6.2 的问题。桌面更新器报告已安装 `26.1023.51421`（build `22530`，prod），可更新到 `26.1111.71704`（build `29030`）；本次仅完成检查，未安装或重启。
- 独立 CLI 为 `0.165.0`；其当次刷新后的模型缓存未列出 GPT-6.2，默认配置为 `gpt-6-astra`。这些是本机诊断证据，不能据此判定账户无权限，也不能保证更新后模型一定出现。先更新桌面客户端并重启，再确认模型选择器中的 GPT-6.2 Astra / Sol；[官方发布说明](https://learn.chatgpt.com/docs/whats-new/gpt-62-astra-sol) 已宣布 Codex 支持这两个模型。
- 更新后确认：桌面版 `26.1111.71704`（build `29030`），新模型缓存客户端版本 `0.169.1`；`gpt-6.2-astra` 与 `gpt-6.2-sol` 均为可选，当前工具也列出两者。模型发现阻塞已解除。
- 已接续 [Control 从白盒局部验证](../experiments/independent-control-20261120/README.md)：门洞与右侧档案交接角，独立参考/素材发现，单组两轮；Godot 4.7.2 导入与三张固定机位白盒实图已检查，先行制作已完成两轮，作为不计排名的管线预检。用户随后明确扩大授权：按 [正式 16 组独立制作比较](../experiments/gpt62-independent-matrix-20261120/README.md) 重跑 Control / Sable / Hi-Fi RUSH / DREDGE 的 low、medium、high、xhigh；从白盒重新制作，统一参考，隔离目录和历史，完成后整理 HTML 对比。正式制作准备中。

## 用 Termius 接续本条聊天

Termius 通过 SSH 以 `paulchen` 登录存有此仓库的同一台 Mac。2026-11-20 检查时，PATH 中独立 `codex` 仍为 `0.165.0`，应用附带 CLI 已为 `0.169.1`；本条聊天记录已存在于本机。先用应用附带版本接续：

```sh
tmux new -As envart
cd /Users/paulchen/GodotProjects/EnvArtPipline
/Applications/ChatGPT.app/Contents/Resources/codex-cli/CodexCLI.app/Contents/MacOS/codex resume \
  --model gpt-6.2-astra 01a1f4cd-91a4-7201-8d3a-883032c94e1a
```

`tmux` 已安装；断线后重新连接，执行第一行重新附着。接续前等桌面端当前回合结束。`resume` 保留聊天历史并使用当前工作区文件；具体可用工具以 CLI 启动后的状态为准，桌面插件和图形界面不保证等同。以上已验证二进制版本、命令帮助与记录存在，未在活跃回合中再启动第二个 CLI 会话。[官方接续说明](https://learn.chatgpt.com/docs/projects?surface=app)。

## 先看结果，不需要引擎

用浏览器打开 [环境美术成果总览](multi-style-effort-study.html)。四游戏可切机位、看共同起点/首轮/终图，历史区域收录此前各方向和迭代版本。实机截图全部使用仓库内相对路径，可离线查看；原作参考图远程引用，需联网，版权归原权利方。

请迁移整个仓库的目录结构，不能只复制 HTML。`docs/` 与 `experiments/` 是页面图片和工程链接的相对位置。

## 转移 Git 和文件

2026-11-19 收尾时提交仅在本地、当时未执行 push；2026-11-20 已确认新电脑从远端克隆得到了 `c763613`。以下保留完整仓库与 bundle 的迁移方法，供后续搬迁使用；今后新增的本地提交仍须单独同步。

可直接复制完整仓库（包括隐藏的 `.git`），或在本机手动创建 Git bundle，再把 bundle 复制到新电脑。下面只是操作说明，本次没有执行导出或推送：

```sh
# 旧电脑：在仓库目录中运行，输出到仓库外。
git bundle create ../envart-handoff.bundle --all

# 新电脑：在打算存放项目的目录中运行。
git clone /path/to/envart-handoff.bundle EnvArt-agent-pipline
```

bundle 包含所有已提交分支/标签及历史，不包含被忽略的本地素材、缓存、未跟踪文件或远端登录凭证。从 bundle 克隆后 origin 指向 bundle 文件；以后需要联网推送时再配置自己的仓库地址。复制完整仓库则保留原有 Git 配置。

不需要迁移 `.godot/`、运行日志、临时截图和 `/tmp` 工具。源文件旁的 `.uid`、`.import` 已纳入版本管理；新电脑会按平台重新生成缓存。主工程 Mixamo 角色属于本地自用资源，不在 Git 内；若需要人形试玩，按根 README 通过自己的下载重新安装。环境美术试跑工程不依赖这套角色。

## 打开可编辑场景

使用当前验证版本 **Godot 4.7.2 标准版**，无需 .NET。只导入准备查看的那个 `project.godot`，不要一次批量打开所有项目。工程索引：

- [Control / Sable / DREDGE 四档](../experiments/multi-style-effort-study/README.md)：F5 打开 `final.tscn`；起点与首轮在工程根目录。
- [Hi-Fi Rush 四档](../experiments/hifi-effort-study/README.md)：F5 打开 `scenes/final.tscn`，其他版本也在 `scenes/`。
- [主测试场](../GodotProject/envart-pipline/project.godot)：玩家、白盒、轨迹相机及原三方向入口；操作见根 README。

现有实机证据来自 macOS Metal Forward+。Windows/Linux 使用平台对应驱动，不要复制历史命令里的 `--rendering-driver metal`。专用 shader 对其他后端的表现尚未检查；迁移后只做一次必要导入、打开目标场景和实机查看，发现画面差异再针对修复，不跑全套控制器回归。

已保存 `.tscn` 和资源可以直接编辑，不依赖当时 `/private/tmp` 下的 builder、GPU 排队脚本或 Python 环境。不要运行旧 builder 覆盖手工修订。要重拍时写入新的证据名，不能覆盖已评审图。三游戏的 `capture.gd` 接受场景名和可选输出标签（例如 `final migrated-final`）；Hi-Fi Rush 的旧 capture 不支持单独标签，先复制工程/调整输出目录，再运行。

## 新规则的下一轮

仓库中的 [godot-envart](../skills/godot-envart/SKILL.md) 是迁移的规则来源，重点新增 [独立试跑约定](../skills/godot-envart/references/independent-trials.md)。需要作为本机 skill 使用时，把整个 `skills/godot-envart/` 目录安装/复制到新电脑 Codex 的个人 skills 目录；不是只复制 SKILL.md。独立制作 agent 只收到该版本的输入包与 skill 副本，不应获得这个结果总仓库。

当前四档实验以既有美术续作，不能评价从白盒找素材的独立能力。下一次要验证完整管线，应由主 agent 从原白盒准备干净输入包：明确室内/室外/半开放与局部范围，保留同机位和空间约束，不带旧成品、评语、shader 和历史 Git。

每个制作组用独立的新 Git 仓库、临时目录和新上下文；主 agent 完成后再收集。若平台无法强制限制读取范围，必须如实标注逻辑隔离。参考搜索或素材搜索是否由各组独立进行，要在输入中说明；固定素材池的测试不能再声称是在测试找素材。两轮内先看实际出图再修订，允许按参考改造模型、材质和 shader。

旧输入清单中的 `/private/tmp/...` 是历史参考缓存位置，不是迁移要求。三游戏参考 URL 已在 `run-manifest.json`，Hi-Fi Rush 的 URL 也在统一 HTML 和原 BRIEF。新试跑如需下载，放入各组受控参考目录，记录实际下载/缩放后的哈希；旧哈希可能对应缩小图，不能直接拿远程原图哈希冒充一致。

可在新电脑用以下交接语恢复工作，具体游戏和规模再按当时意图确定：

> 阅读仓库 README、docs/new-machine-handoff.md 和新版 godot-envart skill。先确认这轮比较续作还是从白盒独立生产；若验证完整管线，用原白盒与明确空间意图准备干净输入，不把旧成品和评语交给制作组。每组独立 Git/临时目录，禁止横读。重点评素材筛选、细节、风格统一与光影，允许有依据的 shader。保留旧版和固定机位，只做局部；实际看图后修订，完成可审阅阶段就提交。只做必要导入/渲染检查。
