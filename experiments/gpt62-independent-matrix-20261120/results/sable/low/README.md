# 盐路第七驿
用 Godot 4.7.2 打开 project.godot，按 F5 进入 final.tscn。点击画面捕获鼠标，5 / 6 / 7 切换门洞、工作角和近景，1 / 2 进入玩家视角，3 切换自由相机。WASD 移动，鼠标转向，Space 跳跃，Esc 释放鼠标。

Art 下可分别编辑门柱、遮棚、收发桌、货物和路线图。BaseLab 保留原始控制器与碰撞。工作范围集中在东墙转角，邻接跳台和边墙只延续表面；场地其余区域保留白盒形状。

## 阶段
参考观察见 RESEARCH.md；sample_a.tscn 与 sample_b.tscn 对照全墙模块。first.tscn 与 final.tscn 分别对应 captures/first 和 captures/final 的三个固定视角。所有实图由 render.py 重开场景拍摄。来源见 ASSETS.md，逐轮看图记录见 REVIEW.md。

终图中门外长墙的砖缝重复，近景木箱和桶仍以大块面为主。玩家操作沿用原工程，本次验证覆盖固定机位加载和实图。