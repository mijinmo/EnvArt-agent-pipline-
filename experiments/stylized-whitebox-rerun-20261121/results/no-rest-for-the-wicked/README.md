# 林间修轮驿站

在 Godot 4.7.2 打开 project.godot，按 **F5** 运行默认场景 draft.tscn。启动时是总览，按 **5** 回总览，**6** 看门洞，**7** 看左坡道。原控制器的 **1 / 2** 切换第一、第三人称，WASD 移动，空格跳跃，**3** 进入自由观察。

当前交付为完成三视角自查的代表性局部，状态为 `awaiting_user_calibration`。右侧红布篷下是修轮工作位，门柱的青绿驿旗与日轮徽记标出入口。最终的 1280 × 800 实机图为[总览](captures/final/overall.png)、[门洞](captures/final/close.png)、[坡道过渡](captures/final/transition.png)。

## 场景编辑

在场景树中，Waygate 管门槛、券石、门柱与灯，Wheelwright 管篷架、桌上工具与车轮，Boardwalk 管坡面、平台、台阶和跳台覆面。Rampart 收纳下载的墙段，Woodland 管现场树木和林下石草。构件可单独移动或改材质。地表混合在 art/materials/trail.gdshader 中，使用原地板顶面的世界坐标。

BaseWhitebox 在单位变换下直接实例化 source/whitebox.tscn。32 米地面、后墙、两段折墙、门洞三件、坡道与平台、四级台阶、三个跳台及 SpawnPad 均保留原碰撞。编辑局部外观时应保持门宽 1.2 米、门楣净高 2.3 米与所有落脚面。前场出生区和地板外围只铺了基础材质，边缘在总览中可见；远林为天空背景。

## 版本与复查

白盒、小样、初稿、修正和最终三图依次位于 captures/whitebox、audition、draft、reviewed、final。要复现小样的当时外观，可在 Git 提交 `140df66` 查看 audition.tscn 及其同版本材质。初稿为 `60f917f`，首轮修正为 `74807c4`。当前版本直接打开 draft.tscn。导入用 `python3 render.py import`，复拍用 `python3 render.py capture draft.tscn captures/新的目录名`。

[参考研究](RESEARCH.md) · [素材与许可](ASSETS.md) · [实机自查](REVIEW.md)
