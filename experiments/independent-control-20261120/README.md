# Control 从白盒局部制作验证 · 2026-11-20

当前阶段：首轮与一次自主修订已完成并收集。范围为室内门洞与右侧档案交接角，单组验证，不进行 effort 排名。

制作运行的本机 `turn_context` 已确认 `model=gpt-6.2-astra`、`effort=low`，本轮未显式覆盖 effort。输入准备提交为 `2c53530`；独立制作仓库的起点提交为 `c895eb1`。制作使用全新上下文，临时目录及缓存位于自己的 `.work/`。这些记录只说明实际配置，不预判美术质量。

- [任务与输入边界](input/ENVIRONMENT.md)
- [输入清单与 SHA-256](input-manifest.json)
- [白盒工程](input/project.godot)：Godot 4.7.2 标准版，Metal Forward+；复用原试玩控制器。
- 固定机位：[门洞](input/captures/whitebox/door.png)、[道具区](input/captures/whitebox/props.png)、[近看](input/captures/whitebox/close.png)。白盒真实出图已检查，尚不代表任何美术完成度。

制作在仓库外的独立目录、新建 Git 和新上下文进行，独立发现参考与素材，最多首轮加一次看图修订。只将冻结白盒、规则与中性拍摄工具交给制作上下文；不提供旧成品、截图、评语或 Git 历史。协调端已按本组提交收集，未复制临时目录/引擎缓存/私有参考图。系统未强制限制本机可读路径，因此这是逻辑隔离。

## 打开与拍图

导入 `input/project.godot`，F5 为白盒。5/6/7 固定机位，1/2 玩家，3 自由观察，WASD/鼠标、Space 跳跃、Esc 释放鼠标。输入仅保留原来的试玩设施。

```sh
godot --headless --path experiments/independent-control-20261120/input --editor --import --quit
godot --path experiments/independent-control-20261120/input --rendering-driver metal --script res://capture.gd -- whitebox.tscn /absolute/path/to/new-evidence
```

拍摄工具拒绝覆盖已有输出目录。Windows/Linux 请换用实际平台支持的渲染后端；本轮尚未验证跨平台画面。结果见 [对比页面](../../docs/independent-control-20261120.html)、[可编辑工程](result/project.godot) 和 [收集清单](result-manifest.json)。F5 在结果工程打开 final.tscn。

本组为预检，不纳入后续固定参考的 24 组排名。实际图显示第二轮的文件标签、办理表单、木材与收纳变化更可读；主要家具轮廓仍简化，深色书架遮住细节，门洞前景仍被跳台占据，建筑与道具精细度没有达到 Control 参考。没有用户美术验收。
