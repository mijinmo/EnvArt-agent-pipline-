# Godot 轨迹相机调研

调研日期：2026-11-12（Asia/Shanghai）。范围：方案调查与接入建议；本次没有安装相机插件，也没有实现轨迹相机。

后续实施更新：原生轨迹相机现已实现，使用说明见 [HTML 图文教程](rail-camera-guide.html)。下文保留调研时的方案比较与插件兼容性结论，Phantom Camera 未接入。

## 结论

可以实现类似 Unity Spline + Cinemachine 的工作方式。Godot 原生 `Path3D` / `Curve3D` 负责路径，`PathFollow3D` 负责路径采样与位置更新；`AnimationPlayer` 可以负责时间编排。Phantom Camera 是作者明确以 Cinemachine 为灵感制作的 Godot 插件，可补充虚拟镜头、跟随、注视和过渡管理。[Phantom Camera 仓库](https://github.com/ramokz/phantom-camera)

本项目以环境美术产出及验收为优先，建议先实现原生轨迹巡检：同一路径、同一时间点、相同 FOV 复查美术化前后的场景。需要大量镜头切换、构图跟随和复杂过场时，再评估 Phantom Camera。第一/第三人称及自由观察不需要等待这个插件才能完成。

## 两种不同的“沿路径移动”

1. **按时间或距离播放轨道**：相机沿指定路线前进，可以暂停、回放、跳转到指定进度。适合场景展示和固定路线巡检。
2. **沿轨道跟随目标**：玩家移动时，相机被约束在一条路径上，路径位置由目标决定。适合侧向关卡、固定机位区域和受限运镜。

Phantom Camera 的 `Path Follow` 属于第二种，使用靠近目标的路径烘焙点；作者文档明确提示急弯可能导致相机突然跳动。不能直接把这个模式当作按时间行进的 dolly 轨道。[Path Follow 文档](https://phantom-camera.dev/follow-modes/path)

## 能力比较

| 维度 | Godot 原生组合 | Phantom Camera |
| --- | --- | --- |
| 路径运动 | `Path3D` 持有 `Curve3D`；改变子节点 `PathFollow3D.progress` 或 `progress_ratio` | 内置 Path Follow 将跟随位置约束在路径上；定时轨道仍可由原生 PathFollow3D 驱动一个目标节点 |
| 时间控制 | AnimationPlayer 可编排进度、FOV 和停留；也可用脚本推进距离 | 可通过 AnimationPlayer 对镜头优先级打关键帧，驱动镜头切换 |
| 注视目标 | 独立枢轴调用 `look_at()`，或编排旋转；需要自行处理朝向平滑及退化情况 | 提供 Mimic、Simple、Group 等 Look At 模式 |
| 镜头混合 | Camera3D 切换本身不等于平滑过渡；需自行插值输出相机的位置、旋转及 FOV | Host 选择虚拟镜头；Tween 资源控制过渡时间和缓动 |
| 避障 | SpringArm3D 适合从玩家枢轴向外的第三人称防穿墙；任意轨道仍需额外检查 | Third Person Follow 使用 SpringArm3D；不能据此推断所有轨迹或过渡都自动避障 |
| 编辑流程 | 原生曲线编辑与动画轨道，依赖较少；需要自行提供巡检控制面板 | 专用 Viewfinder 预览、虚拟镜头参数面板、优先级和过渡资源 |
| 依赖范围 | Godot 原生节点和少量项目脚本 | addon、Host、虚拟镜头及插件 Manager；适合隔离在可选相机模块内 |

上述原生能力见 [PathFollow3D](https://docs.godotengine.org/en/stable/classes/class_pathfollow3d.html)、[Curve3D](https://docs.godotengine.org/en/stable/classes/class_curve3d.html)、[AnimationPlayer](https://docs.godotengine.org/en/stable/classes/class_animationplayer.html) 和 [SpringArm3D](https://docs.godotengine.org/en/stable/classes/class_springarm3d.html)。插件能力见 [Look At](https://phantom-camera.dev/look-at-modes/overview)、[PhantomCameraHost](https://phantom-camera.dev/core-nodes/phantom-camera-host)、[Tween](https://phantom-camera.dev/resource-types/phantom-camera-tween)、[Third Person Follow](https://phantom-camera.dev/follow-modes/third-person) 和 [Viewfinder](https://phantom-camera.dev/viewfinder)。

## 版本与许可证据

- 本机执行 `/Applications/Godot.app/Contents/MacOS/Godot --version`，返回 `4.7.2.stable.official.ed1daf0bf`；当前项目声明 Godot `4.7`。
- 调研时插件发布列表将 `v0.11.0.3` 标为最新发布；历史 `v0.9.4` 声明要求 Godot 4.4 或更高。最低版本要求不代表所有后续引擎版本已经验证。[发布列表](https://github.com/ramokz/phantom-camera/releases)
- `v0.11.0.3` 修复了旋转 Path3D 时的 Follow Path 3D 问题，也涉及 Godot 4.7.1 的 Autoload 问题。[该版本发布说明](https://github.com/ramokz/phantom-camera/releases/tag/v0.11.0.3)
- [issue #670](https://github.com/ramokz/phantom-camera/issues/670) 记录 Godot 4.7.1 与 v0.11.0.3 的 Manager 注册错误，作者说明相关引擎修复当时已合并、待发布。该 issue 已作为重复问题关闭，这不构成本机 4.7.2 已通过测试的证据。本次未安装运行插件，**不保证此版本组合兼容**；接入前应在隔离测试项目验证启用、重启编辑器、运行和切换场景。
- 插件的 [Timeline Animation 文档](https://phantom-camera.dev/timeline-animation) 仍提示，对 Priority 打关键帧可能产生错误日志。后续采用此工作流前应检查对应版本是否仍存在该问题。
- 插件采用 MIT 许可，作者许可页允许个人和商业用途；复制或分发插件时应随附版权与许可文本。[插件许可](https://phantom-camera.dev/overview/license)

## 建议的最小接入方案

以下是后续实现建议，不代表本次已完成。

### 原生轨迹组件

```text
RailCameraRig
├── Path3D                 # Curve3D 曲线资源
│   └── PathFollow3D       # 位置采样
│       └── AimPivot      # 独立管理相机朝向
│           └── Camera3D
└── AnimationPlayer       # 进度、停留、FOV 等编排
```

第一版只需要：开始、暂停、停止、跳转进度；循环开关；按路径前进或注视指定目标；FOV；完成信号。相机轨迹和观看目标应分别配置。

普通场景巡检可用 `progress += speed * delta` 按距离推进；按指定时长播放则用 AnimationPlayer 编排 `progress_ratio`。两者都依赖曲线烘焙精度，尖锐弯道需要检查速度和姿态变化。非循环路线应关闭 `loop`；路径需至少包含有效长度，不能在空曲线上设置归一化进度。

选择 Look At 时应关闭路径自动旋转，或明确分离路径姿态与注视枢轴，防止两套旋转互相覆盖。目标与相机重合、方向与 up 向量平行时需要回退姿态。不要把曲线沿途自动朝向和稳定水平线视为同一需求。

### 与当前三种视角的边界

由试玩环境管理当前相机模式，轨迹相机作为第四种可选模式接入：

- 第一/第三人称控制器负责角色移动及自己的视角。
- 自由观察负责脱离角色的人工巡检。
- 轨迹组件只负责路径、朝向和播放状态，不读取玩家输入或修改角色碰撞。
- 上层在切换时暂停非活动相机的输入处理，确保一个视口只有一个活动输出；退出轨迹模式后恢复先前模式与鼠标捕获状态。
- 是否冻结玩家由试玩环境决定，轨迹组件不暂停整棵场景树。

如果后续引入 Phantom Camera，可在独立的相机适配层内让 Host 管理虚拟镜头，避免 Host 与现有相机脚本同时写同一 Camera3D。定时轨道可让 PathFollow3D 携带一个 Marker3D，PCam 以 Glued 跟随该目标，再单独选择 Look At。不要让人物移动逻辑依赖 PCam 类型。

### 环境美术验收所需的补充

- 固定路径版本、时长、采样进度、FOV、画面尺寸及目标节点，以便重复截图比较。
- 运动场景还需固定或记录场景状态；仅固定相机不足以保证像素级可复现。
- 路径必须独立检查障碍物。自动避障会改变轨迹或构图，巡检模式更适合报告问题并保留预定视角；展示模式才考虑主动修正。
- 测试空路径、急弯、垂直段、循环接缝、移动/旋转后的 Path3D、暂停与跳转，以及轨迹模式到三种已有视角的往返切换。

此方案先满足可重复的美术观察，再按实际镜头数量和构图需求决定是否引入插件。
