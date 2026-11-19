# Herring Quay · 四号鱼货交接点

使用 Godot 4.7.2 打开 project.godot，等待 OBJ 与纹理导入后按 F5，入口为 **final.tscn**。默认从门外看向作业棚。按 **5 / 6 / 7** 切换门口、工作角、台面近景；**1 / 2** 为第一和第三人称，**3** 为自由相机。WASD 移动，鼠标环视，Space 跳跃，Esc 释放鼠标，单击重新捕获。

## 场景与实图

| 阶段 | 场景 | 固定机位 |
| --- | --- | --- |
| 白盒 | [whitebox.tscn](whitebox.tscn) | [原始三图](captures/whitebox/) |
| 材料小样 | [浅墙](sample_a.tscn) · [木墙](sample_b.tscn) | [A](captures/sample-a/) · [B](captures/sample-b/) |
| 首轮 | [first.tscn](first.tscn) | [门口](captures/first/door.png) · [工作角](captures/first/props.png) · [近景](captures/first/close.png) |
| 一次自主修订 | [final.tscn](final.tscn) | [门口](captures/final/door.png) · [工作角](captures/final/props.png) · [近景](captures/final/close.png) |

Art 下的 WeighHouseGate、SortingShed、LandingCounter、QuayYard 分别管理入口、棚屋、鱼货与地面。可直接移动模型、灯光、印字或替换网格材质。BaseLab 提供原碰撞、控制器和固定视角。追加构件属于视觉陈设；跳台覆面和坡道沿用原通路位置。干地延续到相邻白盒，制作集中在四号门和东墙工作角，局部外仍是测试场。后墙边界较直，鱼皮与台秤的细节在中景偏弱。

所有实图均由本组 `python3 render.py` 以 Metal Forward+ 从保存场景拍摄，分辨率 1280 × 800。参考选择、素材许可和两轮看图记录分别见 [RESEARCH.md](RESEARCH.md)、[ASSETS.md](ASSETS.md)、[REVIEW.md](REVIEW.md)。
