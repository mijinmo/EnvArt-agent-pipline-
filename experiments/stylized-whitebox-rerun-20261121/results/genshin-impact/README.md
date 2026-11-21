# 汐見陶房 · 稻妻街巷局部

用 Godot 4.7.2 打开 project.godot，按 **F5** 进入 [draft.tscn](draft.tscn)。默认是整体视角。按 **5** 查看原布局，**6** 查看门洞和店柜，**7** 查看左坡道接入街巷的位置。三张书签来自原 views.json。

点击画面捕获鼠标。原控制器的 **1 / 2** 切换第一、第三人称，**3 / F** 切换自由视角，**WASD** 移动，角色模式下 **空格** 跳跃，**Esc** 释放鼠标。

| 打开位置 | 可编辑内容 |
|---|---|
| BaseWhitebox | 单位父变换实例化原 source/whitebox.tscn。保留 17 个 StaticBody3D、盒形碰撞、世界变换与 layer/mask。美术覆盖只在包装场景作用于 Mesh。 |
| PassageJoinery、Lane、Shop、Awning | 原门上方的瓦檐、柱脚、店匾、帘片、柜架和收货器物。屋面和陶器是导入模型，设施与摆位可在场景树内单独编辑。 |
| UpperLane、LoadingStones、Boundary、MapleCourt | 坡边构件、跳台的视觉覆面、原折墙的收边、树及花桶。地面石铺和门槛直接绘在原地面材质上。 |
| art/models、art/surfaces | glTF/GLB、贴图和地面材质源码。模型内网格可在 Blender 打开编辑。 |

**当前阶段为 awaiting_user_calibration。** 代表性局部覆盖侧巷门、右侧檐下陶器铺与收货角、左坡道和平台。外围地坪、SpawnPad 周边、上层街道延伸和铺内深处仍属未完成区域。复核采用 [整体](captures/delivery/overall.png)、[门洞近景](captures/delivery/close.png) 和 [坡道过渡](captures/delivery/transition.png)。

素材和许可见 [ASSETS.md](ASSETS.md)，白盒与原作依据见 [RESEARCH.md](RESEARCH.md)，逐图自查和版本选择见 [REVIEW.md](REVIEW.md)。小样与首稿的图、场景和可变资源分别冻结于提交 `7442756`、`2fd802d`，可用对应提交复现。复核配色与材质提交为 `12dd76c`。

本组导入和实机出图均使用下列命令，输出目录须为新目录。

```sh
python3 render.py import
python3 render.py capture draft.tscn captures/new-pass
```
