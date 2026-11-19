# Control 从白盒局部制作验证 · 2026-11-20

当前阶段：干净输入已冻结；制作尚未完成。范围为室内门洞与右侧档案交接角，单组验证，不进行 effort 排名。

- [任务与输入边界](input/ENVIRONMENT.md)
- [输入清单与 SHA-256](input-manifest.json)
- [白盒工程](input/project.godot)：Godot 4.7.2 标准版，Metal Forward+；复用原试玩控制器。
- 固定机位：[门洞](input/captures/whitebox/door.png)、[道具区](input/captures/whitebox/props.png)、[近看](input/captures/whitebox/close.png)。白盒真实出图已检查，尚不代表任何美术完成度。

制作在仓库外的独立目录、新建 Git 和新上下文进行，独立发现参考与素材，最多首轮加一次看图修订。只将冻结白盒、规则与中性拍摄工具交给制作上下文；不提供旧成品、截图、评语或 Git 历史。主 agent 完成后再收集。系统未强制限制本机可读路径，因此这是逻辑隔离。

## 打开与拍图

导入 `input/project.godot`，F5 为白盒。5/6/7 固定机位，1/2 玩家，3 自由观察，WASD/鼠标、Space 跳跃、Esc 释放鼠标。输入仅保留原来的试玩设施。

```sh
godot --headless --path experiments/independent-control-20261120/input --editor --import --quit
godot --path experiments/independent-control-20261120/input --rendering-driver metal --script res://capture.gd -- whitebox.tscn /absolute/path/to/new-evidence
```

拍摄工具拒绝覆盖已有输出目录。Windows/Linux 请换用实际平台支持的渲染后端；本轮尚未验证跨平台画面。新阶段与实际美术结论将随制作结果追加。
