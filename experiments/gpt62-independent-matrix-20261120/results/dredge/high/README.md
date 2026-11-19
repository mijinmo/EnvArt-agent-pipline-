# North Sound · 岸上鱼货称量所

用 Godot 4.7.2 打开 `project.godot`，F5 进入 [final.tscn](final.tscn)。门楼是交接院入口；穿过净宽 1.2 m、净高 2.3 m 的门洞，右侧檐下可以近看验鱼、称重和装箱工位。

| 按键 | 操作 |
| --- | --- |
| 5 / 6 / 7 | 门洞 / 工作角 / 台面固定机位 |
| 1 / 2 | 第一 / 第三人称玩家 |
| 3 | 自由相机 |
| WASD / 鼠标 | 移动 / 环视 |
| Space / Esc | 跳跃 / 释放鼠标 |

## 可复看的阶段

| 阶段 | 场景与实图 |
| --- | --- |
| 白盒 | [门洞原图](captures/whitebox/door.png) · [工作角原图](captures/whitebox/props.png) |
| 素材小样 | [灰泥墙 A](sample_a.tscn) · [A 实图](captures/sample-a/close.png) · [木板墙 B](sample_b.tscn) · [B 实图](captures/sample-b/close.png) |
| 首轮 | [first.tscn](first.tscn) · [door](captures/first/door.png) · [props](captures/first/props.png) · [close](captures/first/close.png) |
| 一次自主修订后 | [final.tscn](final.tscn) · [door](captures/final/door.png) · [props](captures/final/props.png) · [close](captures/final/close.png) |

## 编辑与复现

场景树的 `BaseLab` 保留原几何碰撞、玩家和相机。新增物件位于 `Art`，按门楼、棚墙、工作台、灯具、收货和称重等用途分组。导入模型来自 `art/town`、`art/pirate` 及 `art/food`。最终修改过的模型和材质在 `art/final` 有独立文件。可以直接在编辑器选中模型、灯或场景内网格调整。

本包的 GPU 导入和三机位拍摄均经 `python3 render.py`，日志标识为 Metal Forward+；PNG 为 1280 × 800。重拍时使用新的目录名，例如 `python3 render.py capture final.tscn captures/local-check`。

## 范围与不足

开敞一侧的水和远岸来自天空全景。局部以外的测试设施沿用原形状，后墙只处理了可见的连续围护。终图仍可见少数出头的椽端；鱼头暗部和记录牌小字在 close 中较弱。逐图诊断、素材来源及取舍见[复看记录](REVIEW.md)、[素材账](ASSETS.md)和[研究笔记](RESEARCH.md)。
