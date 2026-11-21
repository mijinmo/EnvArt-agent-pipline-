# SIGNALIS 局部 · Godot AI MCP 试跑

此案例检验：参考筛选 → 素材试装 → 保留白盒的局部初稿 → 用户校准 → 定向编辑 → 同机位实图反馈。

当前任务、参考与选择依据见 [ENVIRONMENT.md](ENVIRONMENT.md)。这是风格研究，不包含 SIGNALIS 原作模型、贴图或角色。

在 Godot 4.7.2 标准版打开本目录。主场景为 `scenes/refined.tscn`，固定俯视相机；DetailCamera / DoorCamera 为近景和门洞观察机位。原始白盒位于 `source/whitebox.tscn`，保持原位置和碰撞。未新增玩法控制器。

[同机位 HTML 对比](../../docs/signalis-mcp-study.html) 包含整体、设备和门洞三个视角。`scenes/draft.tscn` / `captures/draft/` 为校准初稿，`scenes/refined.tscn` / `captures/refined/` 为用户反馈后的定向修订；最终美术验收仍待用户判断。

切换机位：在场景树选中对应 Camera3D，在 Inspector 的 Current 勾选所需相机，并取消另外两台的 Current，再保存运行（初稿请另存副本）。不要只改一台以致多台同时 Current；本轮实际游戏 PNG 为 958 × 598。

MCP 插件通过根仓库命令安装：

```sh
python3 tools/setup_godot_ai.py --project experiments/signalis-mcp-study --prewarm
```

在编辑器启用 Godot AI，核对本工程完整路径并选择精确 session_id。最终分发的 project.godot 不保留对未安装插件的硬依赖；普通打开场景无需 MCP。详见 [接入说明](../../docs/godot-ai-mcp.md)。

`tools/build_draft.gd` 是首版构建记录，不应重新运行覆盖后续 MCP 编辑。`scenes/audition.tscn` 为原始素材试装；实际采用/拒绝理由以任务记录为准。仅为本例保留必要的素材检查和出图，没有通用评测框架。

资产许可：Quaternius / Poly Haven 为 CC0；CRT Monitor（Jarlan Perez）及 Old computer（Poly by Google，实际用作键盘）为 CC BY 3.0。各目录保留许可证、来源和修改说明。
