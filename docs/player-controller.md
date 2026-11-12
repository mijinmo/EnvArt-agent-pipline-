# 基础玩家控制器

当前实现面向环境美术试玩与检查，使用 Godot 4.7.2、GDScript、CharacterBody3D 和 Jolt Physics。提供第一人称、第三人称、自由观察，以及可选原生轨迹相机，不依赖第三方插件或 Autoload。轨迹路径与动画编辑见 [面向 Unity 使用者的 HTML 图文教程](rail-camera-guide.html)。

## 启动与操作

打开 `GodotProject/envart-pipline/project.godot`，运行项目（F5）。主场景是 `demo/controller_lab.tscn`。默认第三人称；点击游戏画面捕获鼠标，按 Esc 释放。

| 操作 | 按键 |
| --- | --- |
| 移动 | W A S D |
| 观察 | 鼠标 |
| 奔跑或自由观察加速 | 按住 Shift |
| 跳跃 | Space |
| 第一人称 | 1 |
| 第三人称 | 2 |
| 第一与第三人称切换 | V |
| 进入自由观察或返回之前视角 | F 或 3 |
| 自由观察上升与下降 | E 与 Q |
| 进入轨迹或返回之前视角 | 4 |
| 轨迹播放或暂停 | P |
| 轨迹回到起点并暂停 | Home |
| 轨迹前后定位 1 秒 | [ 与 ] |
| 轨迹循环开关 | L |
| 第三人称距离或自由观察速度 | 滚轮 |
| 返回出生点 | R |
| 释放鼠标 | Esc |

鼠标释放或窗口失焦时停止接收移动输入，重力继续生效；再次点击捕获。自由观察不碰撞场景，WASD 沿相机方向飞行，E/Q 沿世界竖直方向移动。它不移动玩家，也不暂停世界；玩家原有水平速度会减速，空中角色继续下落。返回时恢复脱离前的玩家视角和朝向。R 和跌落复位会退出自由观察。

第三人称为镜头方向驱动的移动，角色代理模型朝移动方向转动；不是带锁定目标的战斗相机。滚轮调整第三人称距离时，弹簧臂仍优先避障。极窄位置收缩到身体内时临时隐藏角色代理。

## 模块结构

| 文件 | 职责 |
| --- | --- |
| `controllers/player_profile.gd` | 尺度与运动参数 Resource |
| `controllers/default_player_profile.tres` | 默认角色配置 |
| `controllers/player_motor.gd` 与 `player.tscn` | 身体、移动、跳跃、坡面和碰撞；不读取 Input |
| `controllers/camera_rig.gd` 与 `camera_rig.tscn` | 三种机位、相机朝向和第三人称避障 |
| `controllers/player_input.gd` | 键鼠输入适配与鼠标捕获；发出复位请求 |
| `demo/controller_lab.gd` 与 `.tscn` | 测试场、出生与跌落复位、操作提示 |
| `tests/controller_smoke.gd` | 实际物理世界中的集成检查 |
| `tests/controller_visual.gd` | 图形渲染及引擎输入事件检查 |

角色根节点位于脚底，眼高由独立 Marker3D 表达。测试场中的角色、相机、输入适配器为兄弟节点，通过 Inspector 中明确的节点引用连接。脚本只对各自场景内部使用固定节点路径。

## 默认参数

| 参数 | 默认值 |
| --- | --- |
| 身高与半径 | 1.8 m、0.3 m |
| 眼高 | 1.65 m |
| 行走与奔跑速度 | 4.5 m/s、7.5 m/s |
| 跳跃高度 | 1.2 m，离散物理计算会产生小幅偏差 |
| 重力 | 20 m/s²，独立于项目默认重力 |
| 最大可行走坡面 | 46° |
| 地面吸附 | 0.2 m；不等于自动跨台阶 |
| 离地宽容与跳跃缓冲 | 各 0.1 s |
| FOV | 75°，沿用 Camera3D 默认纵向 FOV 约定 |
| 第三人称距离 | 4 m，滚轮范围 1.2–8 m |
| 自由观察速度 | 6 m/s，滚轮范围 0.5–40 m/s，Shift 为 3 倍 |

在 Player 的 `profile` 中调整运动配置；相机参数在 CameraRig 中调整。配置在运行时应用，修改身高后编辑器中的默认代理仍为 1.8 m，重新运行后按配置生成。运行期间修改 profile 后需调用 `apply_profile()` 才会更新几何及坡面设置。多个角色要使用不同配置时，分别创建 Resource 或将共享资源设为独立副本。

## 放入其他测试场景

1. 实例化 `player.tscn` 与 `camera_rig.tscn`，把相机的 `target` 指向玩家。
2. 新建 Node 挂载 `player_input.gd`，设置 `player` 与 `cameras` 引用；让试玩入口处理 `reset_requested`。
3. 为场景提供 Environment 层的静态碰撞。当前第 1 层为 Environment，第 2 层为 Player；玩家检测第 1 层，相机默认同样检测第 1 层，并排除目标玩家。
4. 同一项目可直接使用已有 `ea_` 前缀 Input Map。复制到其他项目时要迁移或重绑这些动作，并检查碰撞层；不要覆盖目标项目已有配置。

替换输入来源时可移除输入适配器，调用 `player.set_motion(world_direction, sprint, jump)`。模式切换使用 `cameras.set_mode(...)`，相机转向使用 `look(...)`。独立运动模块无需相机即可工作；当前相机绑定此玩家类型，未来支持其他主体时可增加目标适配器。

## 测试场内容与边界

测试场包含 1 m 地面网格、18.4° 坡道与平台、1.2 m 净宽和 2.3 m 净高的门洞、不同高度跳台、原始台阶，以及相机避障墙角。场景中的几何与碰撞可直接在编辑器调整。

当前没有蹲伏、自动跨台阶、攀爬、梯子、游泳或手柄映射。原始台阶需要跳跃；需要平滑楼梯通行时，可采用独立斜坡碰撞或后续增加跨阶机制。相机弹簧臂只处理由枢轴向后的阻挡，自由观察与轨迹相机没有自动避障。

## 人形表现层（首轮 EnvArt 案例）

`Player/Visual/Humanoid` 使用 `characters/humanoid_visual.gd`，本机已安装 Mixamo Mannequin 的骨架和 idle / walking / running / jump。适配器读取实际速度及落地状态，使用 AnimationPlayer 切换和短过渡，不修改运动或碰撞。角色朝向、身高与眼高仍服从控制器；第一人称隐藏整个 Visual。

默认 walk_speed 为 4.5 m/s，因此达到全速后使用跑步步态；实际速度低于 2.6 m/s 时使用行走。跳跃保留 Mixamo 骨骼姿态，去掉髋骨整身升降，由物理弹道驱动身体。当前没有脚部 IK 或复杂落地动画状态机。

Mixamo 素材保存在 Git 忽略的 `characters/mixamo_local/`。缺失时继续显示胶囊占位，独立运动模块和相机仍可用。另一台机器的安装步骤、下载参数和实机图见 [EnvArt HTML 案例](envart-case-study.html#character)；安装工具为仓库根目录下的 `tools/install_mixamo.py`。

## 验证方式

在仓库根运行物理集成测试：

```sh
/Applications/Godot.app/Contents/MacOS/Godot --headless \
  --path GodotProject/envart-pipline \
  --log-file /tmp/envart-smoke.log \
  --script res://tests/controller_smoke.gd
```

图形验证需要可访问桌面与 GPU 的运行环境：

```sh
/Applications/Godot.app/Contents/MacOS/Godot \
  --path GodotProject/envart-pipline \
  --log-file /tmp/envart-visual.log \
  --script res://tests/controller_visual.gd
```

图形验证生成三种模式的 PNG 到 `/tmp/envart-controller-preview`，并通过引擎输入事件检查点击捕获、视角快捷键和 Esc 释放。它不替代玩家对鼠标灵敏度和运动手感的主观评估。

2026 年 11 月 12 日在 Godot 4.7.2 上执行了物理集成与图形验证，两组测试均通过。已检查三种模式的实际渲染画面；测试场第三人称截图保存在 [预览图](images/controller-lab.png)。

## 官方参考

- [CharacterBody3D](https://docs.godotengine.org/en/stable/classes/class_characterbody3d.html)
- [第三人称弹簧臂相机](https://docs.godotengine.org/en/stable/tutorials/3d/spring_arm.html)
- [鼠标输入与坐标](https://docs.godotengine.org/en/stable/tutorials/inputs/mouse_and_input_coordinates.html)
