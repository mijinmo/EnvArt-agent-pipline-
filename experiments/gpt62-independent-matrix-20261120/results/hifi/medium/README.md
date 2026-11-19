# 07 号电池交接站

用 Godot 4.7.2 打开本目录的 project.godot，导入完成后按 F5 进入 final.tscn。使用 Metal Forward+。按 5 看门洞，6 看右墙工作角，7 近看读数器。1、2 切换玩家视角，3 进入自由相机；WASD、鼠标、Space 和 Esc 沿用原控制器。

## 场景与证据

| 阶段 | 可编辑场景 | 固定机位实图 |
| --- | --- | --- |
| 素材比较 | sample_a.tscn、sample_b.tscn | captures/sample-a、captures/sample-b |
| 首轮 | first.tscn | captures/first |
| 一次自主修订 | final.tscn | captures/final |

两版保留 BaseLab 实例，视觉构件在 Art 下按围护、钢板、门套、交接台和管线分组。原碰撞、门洞净空、台阶和跳台位置沿用白盒。参考依据见 RESEARCH.md，素材及许可见 ASSETS.md，两轮看图记录见 REVIEW.md。

范围止于门洞和右墙工作角。右墙尽头以外仍可看见白盒地坪；近景细字与远景钢板纹理的可读性有限。所有小样和阶段证据均由 python3 render.py 生成。复拍应指定新的输出目录。
