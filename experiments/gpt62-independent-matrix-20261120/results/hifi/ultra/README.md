# FLUX · C07 冷却回路交接间

用 Godot **4.7.2 / Forward+** 打开本目录的 project.godot。F5 从 [final.tscn](final.tscn) 进入门口视角。点窗口捕获鼠标，按 1 或 2 进入原白盒玩家模式，WASD / 鼠标移动观察，Space 跳跃，Esc 释放鼠标。3 为自由相机，5 / 6 / 7 依次返回门洞、工作角、桌边三个固定机位。

| 机位 | 首轮 | 一次自主修订后 |
|---|---|---|
| 5 · 门洞与跳台 | [door](captures/first/door.png) | [door](captures/final/door.png) |
| 6 · 整面墙及作业范围 | [props](captures/first/props.png) | [props](captures/final/props.png) |
| 7 · 表组与交接桌 | [close](captures/first/close.png) | [close](captures/final/close.png) |

## 编辑与范围

场景中的 BaseLab 实例提供原地坪、门洞、坡道、四级台阶、三级跳台、玩家与相机。原 17 个静态体的碰撞均来自 demo/controller_lab.tscn；实例覆盖仅涉及 Mesh、环境和灯光。门柱内边缘位于 x = ±0.6 m，原门楣下沿 y = 2.3 m。顶板底面高 4.5 m。操作台、表组和周转物件均为静态环境美术陈设。

展开 Art 可直接选中 TransferGate 门区、LiftPlatforms 升降台覆面、CoolantLines 管线、ManifoldStation 仪表桌、ReturnStock 周转区及 Lighting 实体灯具。模块的 glTF、网格、表面图集和印刷图分别保存在 art/modules、art/fittings、art/surfaces、art/lettering。art/revision 保存仅终版使用的椅材、圆表、牌面及其独立导入参数。场景可在编辑器中直接修改、保存。

局部延伸至门后冷机墙和右侧回墙。远处只做门后与回墙端部所需的围护、地面收口。出生区、坡道以外的实验场仍保留白盒。终图里远处侧墙较空，长墙上沿的桁架重复可见。桌前交接单的细字在固定近景仍难读。

## 制作阶段

1. [冻结参考与制作方向](RESEARCH.md) 记录图像依据、空间边界及最初假设。
2. [素材与小样](ASSETS.md) 记录免费文件和许可、全墙 A/B 选择、同场景关闭描线的对照。三个可打开的小样为 sample_a.tscn、sample_b.tscn、sample_b_control.tscn。
3. [first.tscn](first.tscn) 与 captures/first 冻结首轮。阶段提交包含对应依赖。
4. [final.tscn](final.tscn) 与 captures/final 保存一次自主美术修订。[复看记录](REVIEW.md) 给出各机位的变化和局限。

本包的 GPU 导入与实拍均通过 `python3 render.py`。已交付图片均为重开场景后的 1280 × 800 Metal Forward+ 画面。需要复拍时使用新的输出目录，例如 `python3 render.py capture final.tscn captures/final-recapture`。私有参考、原始下载和运行缓存留在本组 .work 或 .godot 中。
