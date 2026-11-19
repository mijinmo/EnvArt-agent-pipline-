# 02 号动力模块交接站

用 Godot 4.7.2 打开 project.godot，按 F5 进入 final.tscn。5、6、7 分别查看门洞、工作角及近景。1、2 切玩家视角，3 切自由相机，WASD 和鼠标移动与观察，Space 跳跃，Esc 释放鼠标。

sample_a.tscn 与 sample_b.tscn 保存整墙选材对照。first.tscn 保存首轮，final.tscn 保存一次自主修订。各阶段同机位原图位于 captures。场景的 Art 节点包含独立可编辑的覆面、检测台、管线、灯和标识。BaseLab 保留原碰撞与控制器。复拍使用 `python3 render.py capture final.tscn captures/新的目录名`。

成品范围为门洞与右墙工作角。props 右边仍可看到局部之外的测试地面，近景墙板排线偏密。参考依据、素材和两轮观察分别见 RESEARCH.md、ASSETS.md、REVIEW.md。