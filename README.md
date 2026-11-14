# Godot EnvArt Agent Pipeline

面向关卡设计师的环境美术 Agent 管线：输入白盒、设计约束与美术参考，优先复用可商用素材，必要时通过 Blender 适配或制作，再在 Godot 中装配和验证场景。

当前入口为 **三方向真实素材对比样板**：晴日货运庭院、灰烬庭院、Facility 07。三者沿用同一测试场与观察机位，分别装配门洞、坡道、墙边道具、完整地面和外围远景。原始玩法碰撞不变，新增道具使用简化碰撞。跳台和台阶仍是测试几何，尚未完成全场正式关卡美术。

![真实素材墙边道具样板](docs/images/local-sample/props.png)

晴日版使用 Quaternius 的村庄、幻想道具与自然包；灰烬版加入 KayKit Dungeon Remastered 1.0 的石砌构件与道具；设施版使用 Quaternius Modular Sci-Fi MegaKit 与 Sci-Fi Essentials Kit 的 Standard 免费素材。新素材的许可、来源及文件哈希保存在各自 `manifest.json`。本轮供方向审阅，通用自动检索和 Blender 适配管线尚未实现。

[三方向 HTML 同机位对比与教程](docs/direction-comparison.html) · [晴日局部样板说明](docs/local-asset-sample.html)。首轮三风格案例于 2026-11-12 未通过美术验收，仍保存在 `envart/envart_lab.tscn`，仅作历史技术试验。

另保留已停止方向的 **Poly Haven 写实素材替换实验**（历史记录，不再作为当前美术目标）：用石堡构件、PBR 木箱/酒桶/桌面道具和石铺地面观察近景差异，不改变三方向默认入口。打开 `envart/realism_trial/trial.tscn` 后按 **F6** 运行。只完成过局部尝试；用户已停止这一写实方向的探索。见 [写实素材实验 HTML 对比](docs/realism-trial.html)。

同一已停止方向还保留 **装配与氛围优化版**：打开 `envart/realism_refined/trial.tscn` 后按 **F6**。调整墙段比例、门楼高度、墙边道具、植被、坡道木栏与照明；三个跳台改为货箱堆外观，原有碰撞尺寸保持不变。最新一轮已换用 Poly Haven 植物与独立叶片遮罩，跳台货箱从 42 个减至 10 个，补入开箱、箱盖和破损桶板；建筑仍未达到写实预期。上一轮 `realism_trial` 场景保留。见 [优化前后 HTML 同机位对比](docs/realism-refined.html)。

环境美术流程已提炼为 [godot-envart skill](skills/godot-envart/SKILL.md)：以 `7119a84`、`b81f512` 为基线，优先素材统一性与实机画面，避免冗余功能验证。见 [精简流程说明](docs/envart-pipeline-skill.html)。独立 subagent 已在 [另一个空工程](experiments/envart-skill-trial/project.godot) 完成灰烬方向试跑，只保留四个观察机位；[实机结果与不足](docs/envart-skill-trial.html)。

新增 **游戏截图参考试跑**：旷野之息、Control、Dishonored、Firewatch 四个独立项目，围绕找素材、细节填充和风格统一做逐图反馈修订，另补光影回顾评价。直接查看 [原作参考 / 实机前后 / 四项能力评价 HTML](docs/game-reference-studies.html)，工程与来源见 [试验目录](experiments/game-reference-studies/README.md)。四组均未达到参考游戏完成度；它们是自由布局评估，不是原测试场的默认替换版本，也未验证白盒约束下的表现。

补充 **固定白盒与照明对照**：回到原测试场的门洞、坡道、台阶与跳台，使用同一套 Control 方向装配比较基础照明和专门修订的照明。查看 [原白盒 / 装配 / 灯光修订 HTML](docs/whitebox-lighting-study.html)，或导入 [独立试验工程](experiments/whitebox-lighting-study/project.godot)。白盒约束保持作为前提，光影作为第四项美术评价；结果保留明显的装配与参考贴合不足，不代表美术验收。

## 快速开始

提交新白盒给 agent 前，按 [白盒输入说明](skills/godot-envart/references/whitebox-input.md) 明确室内、室外或半开放区域，以及顶棚、围护、采光开口与允许补建的范围；缺少屋顶不等于室外。主要墙面须按参考检查整面墙的重复图案与分格尺度，不能仅因素材叫“混凝土”就判定合适。

1. 使用 **Godot 4.7.2 标准版**导入 `GodotProject/envart-pipline/project.godot`。项目使用 GDScript，无需 .NET 或第三方插件。
2. 等待首次资源导入完成，按 **F5** 运行对比入口 `envart/direction_studies/comparison.tscn`。
3. 点击画面捕获鼠标，按 **Esc** 释放。也可以直接按 **4** 进入轨迹视角，再按 **P** 播放。

启动后停在晴日庭院的门洞观察机位。按 **Z / X / C** 切换晴日 / 灰烬 / 科幻；切换保留玩家位置、观察朝向和轨迹时间，轨迹会暂停以便同帧比较。按 **5 / 6 / 7** 查看门洞、坡道、墙边道具，**8** 查看远景，**B** 开关远景，**0** 切换白盒对照，**H** 隐藏操作提示。按 **1 / 2** 回到玩家视角试玩。原始 `demo/controller_lab.tscn` 与历史 `envart/envart_lab.tscn` 保留，可单独 F6 运行。

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
| 晴日 / 灰烬 / 科幻方向 | Z / X / C |
| 门洞 / 坡道 / 墙边道具观察机位 | 5 / 6 / 7 |
| 远景观察机位 / 开关远景 | 8 / B |
| 切换白盒对照 / 隐藏提示 | 0 / H |

玩家和自由观察操作需要鼠标捕获；轨迹快捷键在鼠标释放时也有效。切出轨迹视角会暂停并保留进度。样例巡检长 24 秒，在 8–10 秒停留，路径和关键帧可在编辑器调整。

## 功能与模块边界

- **角色移动**：独立配置身体尺寸、行走、冲刺、跳跃和坡面参数；移动模块不读取键鼠输入。
- **玩家相机**：第一人称眼高机位、第三人称弹簧臂避障、可脱离角色的自由观察。
- **轨迹相机**：原生 Path3D、PathFollow3D 与 AnimationPlayer；支持路径方向或注视目标、FOV 动画、播放暂停、时间定位和循环。
- **试玩环境**：测试坡道、门洞、跳台与相机遮挡，提供出生复位和运行时巡检面板。

当前没有自动跨台阶、蹲伏、攀爬或手柄映射。视角采用直接切换；自由观察和轨迹相机没有自动避障。开放轨迹开启循环时会从终点切回起点。

玩家已接入 Mixamo Mannequin 人形骨架和 idle / walking / running / jump。动画只读取实际速度与落地状态，不驱动物理位移；第一人称自动隐藏模型。默认行走速度为 4.5 m/s，视觉上已进入跑步步态；低于 2.6 m/s 使用行走步态。

**本机角色素材已安装。** Mixamo 允许在游戏中使用，但不能因此视为 CC0 素材；本项目不把原始 FBX 或派生角色资源提交为可公开再分发的素材。重新克隆后会使用胶囊占位，需要按 HTML 案例中的步骤下载并安装自己的 Mixamo 文件：

```sh
python3 tools/install_mixamo.py \
  --character ~/Downloads/Ch36_nonPBR.fbx \
  --locomotion "$HOME/Downloads/Basic Locomotion Pack.zip" \
  --running ~/Downloads/Running.fbx
```

安装器只读取这三个指定文件，核对二进制 FBX 格式，复制所需五个文件到已忽略的 `characters/mixamo_local/`，写入 SHA-256 清单，再调用 Godot 导入与构建。可用 `--godot` 指定其他 Godot 安装位置。

## 目录结构

```text
GodotProject/envart-pipline/
├── project.godot       # 引擎项目与输入动作
├── controllers/        # 角色配置、运动、输入和相机组件
├── demo/               # 测试场、网格材质、巡检面板
├── envart/             # 局部真实素材样板、历史三风格场景、CC0 素材
├── characters/         # 人形动画适配器与本地 Mixamo 构建工具
└── tests/              # 物理、轨迹与图形输入验证
docs/
├── pipeline-foundation.md
├── player-controller.md
├── camera-path-research.md
├── rail-camera-guide.html
└── images/             # 文档截图，随文档一起提交
```

Godot 中的 `res://` 指向 `project.godot` 所在目录，不是仓库根目录。

## 新方向场景与重建

`envart/direction_studies/ashen.tscn` 和 `facility.tscn` 可以单独 F6 试玩；`comparison.tscn` 提供三方向切换，晴日原场景仍可独立运行。比较时建议使用 5 / 6 / 7 机位，或暂停轨迹后再切方向。新增道具布局各不相同，若站在某个道具将出现的位置切换，可能被碰撞挤开。

两个新方向分别拆为 `*_art.tscn`（近景）、`*_backdrop.tscn`（无玩法碰撞的远景）。原生网格只用于填充、测试块和地形；可见构件、地板、护栏与大部分道具保留下载模型实例。灰烬远景取用晴日版烘焙地形的网格并重新着色，附加石砌堡垒与贴地岩石；科幻远景使用模块设备楼、天线与货柜。

离线生成器会覆盖对应产物，手工修改前先另存或提交：

```sh
/Applications/Godot.app/Contents/MacOS/Godot --headless --path GodotProject/envart-pipline --script res://envart/tools/build_ashen_sample.gd
/Applications/Godot.app/Contents/MacOS/Godot --headless --path GodotProject/envart-pipline --script res://envart/tools/build_facility_sample.gd
/Applications/Godot.app/Contents/MacOS/Godot --headless --path GodotProject/envart-pipline --script res://envart/tools/build_direction_scenes.gd
```

科幻版门框按净空缩放，货架补给按模型层板表面高度落位；两版覆盖地面时隐藏原地面外观，以避免重叠闪烁，原碰撞仍保留。切回 0 白盒会恢复原外观并关闭新增碰撞。

## 晴日远景与植物

庭院地面使用 Quaternius 石材的颜色、法线和粗糙度贴图，按世界坐标统一铺设，边缘与外围地形共用草地色和噪声变化。材质位于 `envart/local_sample/courtyard_ground.tres`，草地颜色跟随 `backdrop_config.tres` 的 `near_grass`；修改远景配置后按下方命令重新生成。原地面碰撞不变，按 0 可恢复白盒对照。

地面植物使用 Quaternius Stylized Nature MegaKit 的真实灌木、草、三叶草、蕨类和花朵模型，以固定种子分簇摆放并避开门洞、坡面与大件道具。远景由 11 栋模块房屋、460 棵实例化树木与连续程序化山地组成，独立保存在 `envart/local_sample/backdrop.tscn`，没有玩法碰撞。

在 Godot 检查器中编辑 `envart/local_sample/backdrop_config.tres` 可设置种子、树木数量、地形范围和山丘高度。修改后需运行 `res://envart/tools/build_backdrop.gd` 重新烘焙，**该命令不要加 `--headless`**：MultiMesh 实例缓冲需要真实图形后端才能正确序列化。生成器会拒绝无图形模式，避免覆盖有效场景。运行时只加载产物，不逐帧生成。

## 验证

在仓库根目录执行以下命令。macOS 默认引擎位置如下；其他安装位置请调整 `GODOT_BIN`。

```sh
GODOT_BIN=/Applications/Godot.app/Contents/MacOS/Godot

# 首次克隆后导入资源并注册脚本类型；也可以在编辑器打开项目完成。
"$GODOT_BIN" --headless --path GodotProject/envart-pipline --editor --import --quit

# 局部样板实机截图、门洞双向通行、坡道登顶与镜头书签连续性（需要图形环境）。
"$GODOT_BIN" --path GodotProject/envart-pipline \
  --script res://tests/local_sample_visual.gd
# PNG 输出在 /tmp/envart-local-sample/。

# 新方向实机截图与通行回归，分别输出 /tmp/envart-ashen 和 /tmp/envart-facility。
"$GODOT_BIN" --path GodotProject/envart-pipline --script res://tests/direction_sample_visual.gd -- ashen
"$GODOT_BIN" --path GodotProject/envart-pipline --script res://tests/direction_sample_visual.gd -- facility

# Z/X/C 输入、同机位切换、轨迹时间保持、白盒与碰撞隔离。
"$GODOT_BIN" --headless --path GodotProject/envart-pipline --script res://tests/direction_comparison_smoke.gd

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
| [三方向 HTML 对比](docs/direction-comparison.html) | 真实素材重做、同机位图片切换、试玩和编辑方法 |
| [EnvArt 首轮 HTML 案例](docs/envart-case-study.html) | 同机位对比、场景使用、素材来源和人形角色安装 |
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

## 重建与验证历史环境案例

`envart/styles/` 中的三个场景由离线脚本生成，可直接在编辑器修改。玩法继续使用原测试场的碰撞，美术层不包含碰撞对象。重建会覆盖这三个文件，手工改版前请先另存场景。

```sh
/Applications/Godot.app/Contents/MacOS/Godot --headless \
  --path GodotProject/envart-pipline --script res://envart/tools/build_studies.gd

/Applications/Godot.app/Contents/MacOS/Godot \
  --path GodotProject/envart-pipline --script res://tests/envart_visual.gd

/Applications/Godot.app/Contents/MacOS/Godot --headless \
  --path GodotProject/envart-pipline --script res://tests/humanoid_smoke.gd
```

比较截图输出到 `/tmp/envart-studies`。人形测试需要本地 Mixamo 素材，缺失时会明确失败。外围塔楼、树木和设备是背景，没有可攀爬碰撞；可玩范围仍为原测试场。
