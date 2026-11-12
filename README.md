# Godot EnvArt Agent Pipeline

面向关卡设计师的环境美术 Agent 管线：输入白盒、设计约束与美术参考，优先复用可商用素材，必要时通过 Blender 适配或制作，再在 Godot 中装配和验证场景。

当前已完成**试玩与场景巡检基础**：玩家移动、第一人称、第三人称、自由观察，以及原生轨迹相机。资产检索、Blender 自动处理和环境美术生成尚未实现。

![控制器与巡检测试场](docs/images/controller-lab.png)

## 快速开始

1. 使用 **Godot 4.7.2 标准版**导入 `GodotProject/envart-pipline/project.godot`。项目使用 GDScript，无需 .NET 或第三方插件。
2. 等待首次资源导入完成，按 **F5** 运行主场景 `demo/controller_lab.tscn`。
3. 点击画面捕获鼠标，按 **Esc** 释放。也可以直接按 **4** 进入轨迹视角，再按 **P** 播放。

当前使用 Forward+ 渲染与 Jolt Physics。其他引擎版本、渲染后端和目标平台尚未完成兼容性验证。

> 有 Unity 经验但不熟悉 Godot？先阅读 [轨迹相机 HTML 图文教程](docs/rail-camera-guide.html)。将仓库克隆到本地后，用浏览器打开这个 HTML；无需启动服务器，保留旁边的 `images` 文件夹即可离线阅读。GitHub 文件页面显示的是 HTML 源码。

## 操作速查

| 操作 | 输入 |
| --- | --- |
| 移动、观察 | WASD、鼠标 |
| 奔跑 / 自由观察加速 | 按住 Shift |
| 玩家跳跃 | Space |
| 第一 / 第三人称 | 1 / 2；V 切换 |
| 自由观察 / 返回玩家视角 | F 或 3 |
| 自由观察升降 | E / Q |
| 第三人称距离 / 飞行速度 | 滚轮 |
| 玩家返回出生点 | R |
| 轨迹相机 / 返回进入前视角 | 4 |
| 轨迹播放 / 暂停 | P |
| 轨迹回到起点并暂停 | Home |
| 轨迹前后定位 1 秒 | [ / ] |
| 轨迹循环开关 | L |
| 释放鼠标，操作巡检面板 | Esc |

玩家和自由观察操作需要鼠标捕获；轨迹快捷键在鼠标释放时也有效。切出轨迹视角会暂停并保留进度。样例巡检长 24 秒，在 8–10 秒停留，路径和关键帧可在编辑器调整。

## 功能与模块边界

- **角色移动**：独立配置身体尺寸、行走、冲刺、跳跃和坡面参数；移动模块不读取键鼠输入。
- **玩家相机**：第一人称眼高机位、第三人称弹簧臂避障、可脱离角色的自由观察。
- **轨迹相机**：原生 Path3D、PathFollow3D 与 AnimationPlayer；支持路径方向或注视目标、FOV 动画、播放暂停、时间定位和循环。
- **试玩环境**：测试坡道、门洞、跳台与相机遮挡，提供出生复位和运行时巡检面板。

当前没有自动跨台阶、蹲伏、攀爬、角色动画或手柄映射。视角采用直接切换；自由观察和轨迹相机没有自动避障。开放轨迹开启循环时会从终点切回起点。

## 目录结构

```text
GodotProject/envart-pipline/
├── project.godot       # 引擎项目与输入动作
├── controllers/        # 角色配置、运动、输入和相机组件
├── demo/               # 测试场、网格材质、巡检面板
└── tests/              # 物理、轨迹与图形输入验证
docs/
├── pipeline-foundation.md
├── player-controller.md
├── camera-path-research.md
├── rail-camera-guide.html
└── images/             # 文档截图，随文档一起提交
```

Godot 中的 `res://` 指向 `project.godot` 所在目录，不是仓库根目录。

## 验证

在仓库根目录执行以下命令。macOS 默认引擎位置如下；其他安装位置请调整 `GODOT_BIN`。

```sh
GODOT_BIN=/Applications/Godot.app/Contents/MacOS/Godot

# 首次克隆后导入资源并注册脚本类型；也可以在编辑器打开项目完成。
"$GODOT_BIN" --headless --path GodotProject/envart-pipline --editor --import --quit

# 玩家运动、碰撞及原有三种视角。
"$GODOT_BIN" --headless --path GodotProject/envart-pipline \
  --script res://tests/controller_smoke.gd

# 轨迹播放、时间采样、朝向、循环和模式切换。
"$GODOT_BIN" --headless --path GodotProject/envart-pipline \
  --script res://tests/rail_camera_smoke.gd

# 需要桌面和 GPU；验证实际渲染及输入事件。
"$GODOT_BIN" --path GodotProject/envart-pipline \
  --script res://tests/controller_visual.gd
```

图形测试截图输出到 `/tmp/envart-controller-preview`，测试完成后自动退出。以测试末尾的 `RESULT: PASS` 和进程退出码 0 确认成功，同时检查是否有脚本错误。已在 Godot 4.7.2 上通过上述三组检查；图形测试不替代对操作手感的人工试玩。

## 文档

| 文档 | 内容 |
| --- | --- |
| [管线目标与基础约定](docs/pipeline-foundation.md) | 输入语义、设计保护、资产策略、模块边界和实施阶段 |
| [玩家控制器说明](docs/player-controller.md) | 操作、运动参数、组件接入与当前限制 |
| [轨迹相机 HTML 教程](docs/rail-camera-guide.html) | Unity 概念对照、图文操作、路径编辑、动画和巡检练习 |
| [轨迹相机方案调研](docs/camera-path-research.md) | 原生方案与 Phantom Camera 的能力比较及兼容性调查 |

## 版本管理约定

每完成一个可独立验证的小阶段，运行相关检查并提交；功能变化同步更新文档。协作规则记录在 [AGENTS.md](AGENTS.md)。

- 提交脚本、场景、配置资源、`.uid`、源文件旁的 `.import`、文档及文档图片。
- 忽略 `.godot/`、生成的 Android 目录、项目 `build/`、`builds/`、`exports/`、日志、系统临时文件和本地环境配置。
- 根目录 `.artifacts/` 与 `tmp/` 用于临时验证产物；正式文档图片存入 `docs/images/`。
- 原始 `.blend` 与正式美术素材应保留在版本管理中；仅忽略 Blender 自动备份。大型资产的存储方式将在资产管线阶段确定。
