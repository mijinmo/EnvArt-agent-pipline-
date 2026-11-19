# Sable / DREDGE / Control effort 对照

从三个已保存的局部继续，保留原白盒与旧版。每个游戏四份独立 Godot 4.7.2 工程，low、medium、high、xhigh 各两轮；输入、素材候选、相机和轮数固定。任务见 [BRIEF](BRIEF.md)，参考和资源范围见各游戏 INPUT.md。

run-a=medium，run-b=xhigh，run-c=low，run-d=high。每份工程的 baseline 是冻结起点资源，start.tscn 可重开，evidence/source_* 是旧工程既有截图，start_* 是此次重开副本的实机核验。pass01/final 保存各轮新场景与三机位。不是从白盒重新做一次全场，也不以功能检查代替美术评价。

12 组均已完成。查看 [四游戏统一 HTML：本批 + Hi-Fi Rush + 历史案例](../../docs/multi-style-effort-study.html)，可切换三个机位、四档终图、共同起点和首轮；[逐图判断](REVIEW.md)、[用量](usage.json)、[隔离检查与局限](ISOLATION-AUDIT.md) 单独保留。

| 游戏 | medium / A | xhigh / B | low / C | high / D |
| --- | --- | --- | --- | --- |
| Control | [工程](control/run-a/project.godot) · `1a7c14f` | [工程](control/run-b/project.godot) · `baa48d6` | [工程](control/run-c/project.godot) · `347119e` | [工程](control/run-d/project.godot) · `ee90e0f` |
| Sable | [工程](sable/run-a/project.godot) · `d26da56` | [工程](sable/run-b/project.godot) · `ebaea34` | [工程](sable/run-c/project.godot) · `9fc9032` | [工程](sable/run-d/project.godot) · `ba0fffa` |
| DREDGE | [工程](dredge/run-a/project.godot) · `6242662` | [工程](dredge/run-b/project.godot) · `54ac9cb` | [工程](dredge/run-c/project.godot) · `3dafea1` | [工程](dredge/run-d/project.godot) · `c378dd2` |

上述工程各有自己的 `project.godot`，新电脑安装 Godot 4.7.2 后导入，F5 为 `final.tscn`。`start.tscn` 和 `pass01.tscn` 可单独 F6；每组 README 记录素材、shader 参数、两轮变化与不足。Hi-Fi Rush 的 run 字母映射不同，统一 HTML 已按真实 effort 重新对应。

**本批属于隔离不完整的续作比较，不是从白盒独立制作的验证。** 已更新 [独立试跑规则](../../skills/godot-envart/references/independent-trials.md)。旧 BRIEF 和 INPUT 保留原样记录当时输入，包括 Mac 临时工具路径；这些不是打开已保存场景的依赖。新电脑参考 [迁移说明](../../docs/new-machine-handoff.md)，不要照抄旧临时命令或覆盖现有 evidence。新规则试跑尚未执行，本机不再启动 Godot。
