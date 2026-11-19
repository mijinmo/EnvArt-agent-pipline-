# 盐路第七站

用 Godot 4.7.2 打开 project.godot，等待资源导入后按 F5，入口为 final.tscn。启动时从门外望向盐路驿站；按 6 进入墙边全景，按 7 查看秤台，按 5 回门口。1 / 2 切第一、第三人称，3 切自由相机，WASD 与鼠标移动观察，Space 跳跃，Esc 释放鼠标。

| 固定机位 | 首轮 | 最终 |
| --- | --- | --- |
| 门口 | [first / door](captures/first/door.png) | [final / door](captures/final/door.png) |
| 收货席 | [first / props](captures/first/props.png) | [final / props](captures/final/props.png) |
| 称量台 | [first / close](captures/first/close.png) | [final / close](captures/final/close.png) |

## 编辑与阶段

BaseLab 实例保留原白盒碰撞和控制器。场景内对原网格做显示或材质覆盖。Art 下可单独移动门套、货件、秤盘、管件和棚杆。织物曲面、站徽与印花源文件在 assets/textiles，资产来源见 [ASSETS.md](ASSETS.md)。

[参考方向](RESEARCH.md) → [赭石裂墙小样](captures/stone-a/props.png) / [浅石墙小样](captures/stone-b/props.png) → [首轮场景](first.tscn) → [最终场景](final.tscn)。两轮都用本组 render.py 在 Metal Forward+ 下重开场景、拍摄固定三视图，1280×800。[复看记录](REVIEW.md)

制作限于门口和右墙称货席。坡道、台阶和跳台沿用原形状，场地外侧保留测试场布局。终图在后墙上仍能看见相同凸砖的重复，近看盐晶与墙面的亮度接近。远山是天空着色器内的远景。
