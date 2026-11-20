# Port Merrick 酒馆地窖

在 Godot 4.7.2 中打开 project.godot，按 **F5** 进入地窖。主场景是 [draft.tscn](draft.tscn)，当前保存的是看图修正后的代表性初稿，状态为 `awaiting_user_calibration`。

## 巡检与编辑

**5 / 6 / 7** 分别跳到整体、近景、过渡机位。**1 / 2 / 3** 分别切换第一人称、第三人称、自由巡检。WASD 移动，鼠标转向，自由巡检时 Q 下降、E 上升，Esc 释放鼠标。沿房间中线可从入口走到分装台前。

在场景树展开 Masonry 调整墙、门洞和地砖，Deckhead 调整顶梁，Stores 调整货架与存货，Handling 调整搬运和分装区。Lighting 含提灯及光源，Contact 含地面和主要阻挡体。移动整组家具时应一并移动对应碰撞。模型以 glTF、外部网格缓冲和 PNG 交付，可在建模软件中继续编辑。

## 实机证据

| 机位 | 首版 | 修正后，与当前场景对应 |
| --- | --- | --- |
| 整体 | [首版](captures/draft/overall.png) | [入口看货架与拱门](captures/reviewed/overall.png) |
| 近景 | [首版](captures/draft/close.png) | [酒桶、量壶与记账台](captures/reviewed/close.png) |
| 过渡 | [首版](captures/draft/transition.png) | [搬运区与取货通道](captures/reviewed/transition.png) |

三机位均为 1280×800，使用 Godot Metal Forward+ 从重开的场景直接捕获。首次组装对应提交 `d6d3bb4`。原包小样和表面适配小样的依据见 [ASSETS.md](ASSETS.md)，主参考见 [RESEARCH.md](RESEARCH.md)，修正记录及待校准项见 [REVIEW.md](REVIEW.md)。

在本制作包提供的渲染环境中，导入执行 `python3 render.py import`。复拍执行 `python3 render.py capture draft.tscn captures/new-review`，输出目录需为新目录。
