# Godot AI MCP：接入与环境美术使用约定

更新：2026-11-21。接入的是第三方开源项目 [hi-godot/godot-ai](https://github.com/hi-godot/godot-ai)，不是 Godot 官方自带的 AI，也不替代本仓库的环境美术 skill。

## 结论与选型

值得作为**编辑器操作与反馈通道**加入。预计收益在于：少猜节点和资源状态，改完材质/灯光能直接看图，更容易发现“文件写了，但实机场景没有生效”。它不会自动改善素材眼光，也不能把成功调用工具变成美术验收通过。质量、时间及 Codex 额度收益仍需在制作机验证。

| 候选 | 对本项目的适用性 | 决定 |
| --- | --- | --- |
| [Godot AI](https://github.com/hi-godot/godot-ai/tree/423954f4314e250fa2602525d461debc91b1a173) | 实时场景树、资源/材质/Shader/相机操作，编辑器及游戏截图，编辑器会话选择。v4 要求 Godot 4.7+，与项目 4.7.2 的版本要求吻合。 | 接入固定发布版 **4.4.2**；实际 4.7.2 编辑器兼容性尚未在本任务运行验证。 |
| [Coding-Solo/godot-mcp](https://github.com/Coding-Solo/godot-mcp) | 主要提供启动、运行、日志与基本场景文件操作；与现有 CLI 脚本重叠较多。 | 本轮不安装。 |
| [Godot Forge](https://github.com/Tann2019/godot-mcp-server) | 宣称覆盖编辑、截图、Shader 与试玩；同时包含较广的游戏开发能力。 | 本轮不并装，先验证一种编辑器桥是否有用。 |

Godot AI 为 MIT 许可；安装包保留原 LICENSE。插件与 Python 服务版本必须一致。固定版来源、ZIP SHA-256、依赖发布时间上限、Python 范围及工具名单在 [godot_ai.lock.json](../tools/godot_ai.lock.json)。这里的 pin 固定主包和插件，并使用上游依赖截止策略，**不是所有传递依赖的逐包 hash lock**。

## 已配置与尚未验证

- 本 MacBook：已安装插件文件，写入仓库根下本机的 `.codex/config.toml`，服务名 `godot_ai_envart`，预热固定版 Python 依赖。未修改全局 Codex 配置。
- 当前会话没有自动出现新增 Godot 工具；重新加载 MCP 或重新打开项目会话后检查工具是否可用，不能仅凭配置文件就声称 agent 已获得工具。
- 已做最小通信检查：`initialize`、`tools/list` 和只读 `session_manage(list)` 成功；上游返回 47 项工具，选用的 22 项全部存在，编辑器会话数为 0。325 个插件文件与发布 manifest 的 hash 相符，Codex 能读到项目级配置。实际包与 `attach --version` 均为 4.4.2；握手里的 `serverInfo.version=4.1.6` 来自 FastMCP 框架，不能用它判断插件版本。
- 插件文件安装不等于编辑器已经连接：**本机没有启动 Godot、没有启用编辑器插件、没有改动 project.godot 或制作场景**。实际联动、游戏截图和编辑器保存待 Mac mini 验证。
- 机器路径、配置和下载的第三方插件不入 Git；安装器与版本清单入 Git。其他工程自己生成的 `.uid` / `.import` 仍照常提交。
- 后续安装/启用 MCP 不构成恢复 MacBook 制作、启动独立矩阵或新增制作 agent 的授权。

## Mac mini 配置

先按 [跨机器接续说明](new-machine-handoff.md) 保存现有修改并拉取最新代码。不要把制作机任务换回本机旧场景。

1. 确认 `uv --version` 至少为 **0.9.25**，`codex` 可用。未安装时按 [uv 官方安装说明](https://docs.astral.sh/uv/getting-started/installation/) 安装。配置脚本自身只需要 Python 3.9+；uv 为 MCP 选择 Python `>=3.11,<3.15`。
2. 在仓库根运行：

   ```sh
   python3 tools/setup_godot_ai.py --prewarm
   codex mcp get godot_ai_envart --json
   ```

   默认将插件装入 `GodotProject/envart-pipline/addons/godot_ai/`。如果当前制作的是其他 Godot 工程，使用其真实目录：

   ```sh
   python3 tools/setup_godot_ai.py --project experiments/当前任务/工程目录 --prewarm
   ```

   `--project` 控制**插件装在哪里**，不将 MCP 永久绑定到这个工程。连接后仍须核对编辑器会话的完整路径。

   对另一个独立 Codex 工作区，可用 `--workspace /绝对路径/候选目录 --project .`。它会将配置写入该工作区，而非用户全局目录。没有 `uvx`、版本不符、下载/hash 错误或已有不同插件时直接停止；不覆盖旧插件。已核验的 ZIP 可用 `--archive /路径/plugin.zip` 离线安装插件；Python 依赖仍需缓存或网络。
3. 在已授权运行 Godot 的制作机打开目标工程。首次启用时建议从终端带遥测关闭变量启动，例如 macOS：

   ```sh
   GODOT_AI_DISABLE_TELEMETRY=1 /Applications/Godot.app/Contents/MacOS/Godot --editor --path GodotProject/envart-pipline
   ```

   将 `--path` 换成第 2 步的同一工程。在 **Project → Project Settings → Plugins** 启用 **Godot AI**。再在 **Editor Settings** 搜索 `godot_ai/telemetry_enabled`，设为 `false`，使以后从 Dock 打开也保留编辑器端的关闭状态。安装器已在 MCP 桥和其启动的 Python 服务端关闭遥测；编辑器设置独立于这个开关。
4. 本配置使用认证的 **stdio attach**，本地 HTTP/WS 默认端口 **8000 / 9500**。不要再添加裸 `http://127.0.0.1:8000/mcp`，v4 需要认证桥处理 capability。若插件 Dock 显示其他端口，以实际值重跑安装器的 `--http-port N --ws-port M`；这两个参数只改客户端，不修改 Godot Editor Settings。已有 `godot_ai/v4_endpoint_ports` 会覆盖旧端口字段，须核对实际显示值。
5. 重新加载 MCP 或重开 Codex 项目会话；用 `codex mcp get` 检查配置、在会话工具中检查 `godot_ai_envart`。项目配置需要处于 Codex 信任的工作区；不要通过关闭沙箱/审批解决连接问题。普通 subagent 是否拿到工具也须检查其实际工具列表，不能假定换模型就会获得 MCP。

本安装器维护一个带 BEGIN/END 注释的配置段，保留其他配置；若已有同名的非本工具维护段则停止。已有配置首次修改前留本机备份。重跑会重写自己的段，包括 enabled 和工具名单。上游 Dock 的 **Configure all** 不是本流程需要的步骤，它可能额外创建全局 `godot_ai` 条目；不要同时配置两份指向同一服务。

Godot AI 启用后可能写入 editor_plugins、运行截图所需 helper autoload 等工程设置。首次启用后检查 `git diff`：它们是工具依赖，不能把指向被忽略插件的引用提交给尚未安装插件的工程。需要停用时，先在编辑器禁用插件、保存并检查 helper 引用，再移除插件目录；不要直接删目录留下损坏引用。

## Agent 怎样使用

沿用 `素材筛选 → 局部初稿 → 必要的用户审美校准 → 定向细化 → 同机位复核`。MCP 插入现有的检查、编辑和出图步骤，不另建一个管线阶段。

| 当前问题 | 适合用 MCP 做什么 | 美术判断仍要做什么 |
| --- | --- | --- |
| 素材候选导入 | 查材质/资源、尺寸和节点；在已授权的试装场景看图。 | 核实实际可下载内容、许可、轮廓和材质语言，不能只选导入顺利的包。 |
| 局部道具搭配 | 检查层级和摆放，批量完成一个明确的小组合。 | 按活动关系、支撑、疏密和尺度组织，避免大量随机散布。 |
| 风格化材质 | 调材质参数、创建或修改 Shader，读取相关错误。 | 对照参考中的明暗分层、色块、轮廓；不把一个 outline 当作漫画风格完成。 |
| 光影与反馈 | 查 Light3D / WorldEnvironment 属性，改一组明确参数并截图。 | 对比光源动机、明暗层次、材质响应、近景与整体；不能只加雾或压暗。 |

每次接手或编辑器重新连接：

1. `session_manage(op="list")`：核对 **project_path、current_scene、Godot/plugin 版本**。
2. 用返回的**精确 session_id** 调 `session_activate`；后续支持 session_id 的调用也显式传入。不要用多个候选可能重名的目录简称选择工程。
3. `editor_state`、有限深度的 `scene_get_hierarchy`、必要的 `node_get_properties`：确认当前是待编辑版本。
4. 在保留旧版的前提下改一个明确问题。选择 MCP 或文件编辑作为这一段的写入者；文件在外部变更后先扫描/重载，避免编辑器内存的旧版本覆盖磁盘。
5. `scene_save`，保存需要持久化的资源，并从磁盘重开确认。调用成功和 UndoRedo 都不能替代 Git 或旧版场景。
6. 在制作机运行保存版本并取固定机位图，真正查看图像，再决定保留/修正。A/B 与主 agent 不同时写同一个工程。

截图要区分来源：

- `viewport` / `cinematic`：用于快速判断材质、摆放与构图。cinematic 可以指定 Camera3D；它不证明运行时脚本、相机和环境状态一致。
- `game`：运行中的真实游戏 framebuffer；固定场景、Camera3D、变换/FOV、分辨率、渲染后端及需要固定的时间条件，才作为同机位实机前后证据。
- `include_image=true` 才返回可直接看见的图像；只返回路径/metadata 不代表已经看过。不要开启将图像转成另一模型文字描述的 Vision Routing 来替代当前模型看原图。
- 内联图可能缩小；比较细部时保存并查看原尺寸 PNG。`save_to` 能力按当前工具 schema 和具体截图模式使用，不假定所有模式都支持同样的保存选项。图片写入新一轮目录，保留旧图。

本配置只向 Codex 暴露 **22 项相关工具**：会话、场景/节点、材质/资源/相机、有限日志、保存/运行和批量操作。没有暴露测试套件、输入模拟、UI、音频、客户端自动配置等独立工具。`*_manage` 内仍有多种操作；这是减少无关工具的配置，**不是按操作隔离的安全沙箱**。需要其他工具时按实际任务增补，不自动打开全量。

## 独立试跑与停用

独立试跑继续遵守 [independent-trials.md](../skills/godot-envart/references/independent-trials.md)。项目级 Codex 配置及 `session_activate` 只解决操作目标，**不提供候选间文件、资源或会话隔离**。一个共享 MCP 后端能列出其他编辑器，不可拿它作为严格独立实验的工具入口。

独立候选需要隔离的运行账户/容器或等效访问限制、独立编辑器配置与端口，并只接到自己的服务；做不到就不向该候选提供共享 MCP，沿用已隔离的文件与出图工具。这里没有创建新的多 agent 调度器，也没有运行新矩阵。

停用 MCP：将本地 `.codex/config.toml` 中该服务 `enabled = false`，重新加载会话。安装器也支持 `--disabled`。这不会禁用已打开的 Godot 插件；后者在 Project Settings → Plugins 单独关闭。不要结束不属于当前任务的 Godot/服务进程。

第一次收益检查只需一个既有局部、一个已明确的材质或光影问题，保留同机位 before/after，并记录是否减少无效往返、有无视觉进步。不为接入 MCP 新造功能测试或完整 effort 矩阵。

## 来源

- [固定发布版与发布说明](https://github.com/hi-godot/godot-ai/releases/tag/v4.4.2)
- [固定版本工具与截图语义](https://github.com/hi-godot/godot-ai/blob/423954f4314e250fa2602525d461debc91b1a173/docs/TOOLS.md)
- [固定版本客户端连接说明](https://github.com/hi-godot/godot-ai/blob/423954f4314e250fa2602525d461debc91b1a173/docs/client-configuration.md)
- [Codex MCP 配置说明](https://developers.openai.com/codex/mcp)：项目级 config.toml、工具 allow list、启停与超时。
