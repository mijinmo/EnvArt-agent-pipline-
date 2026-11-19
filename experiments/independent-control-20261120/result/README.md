# B4 档案交接区

Godot 4.7.2，Forward+ / Metal。打开本目录的 project.godot，等待素材导入后按 F5 进入 final.tscn。5 / 6 / 7 切换门洞、墙边工作面和近看机位。1 / 2 切换玩家相机，3 为自由相机，WASD 与鼠标移动观察，Space 跳跃，Esc 释放鼠标。

可在场景树 Art 下编辑墙体、灯、家具实例、表单和各安装件。final_lab.tscn 继承原控制器白盒，覆盖可见材质和环境光；原门洞两侧内沿保持在 ±0.6 m，顶部门条下沿为 2.3025 m。路线、坡面和跳台沿用原始碰撞。文件办理桌位于右墙，面向内侧通道；交接区之外保留测试场几何。

| 场景 | 固定机位证据 |
|---|---|
| whitebox.tscn | captures/whitebox/ |
| sampleA.tscn、sampleB.tscn | captures/sampleA/、captures/sampleB/ |
| first.tscn | captures/first/ |
| final.tscn | captures/final/ |

对照各目录中的 door.png、props.png 与 close.png，均为 1280 × 800。图像来自重开对应场景的 Godot Metal 真实渲染。RESEARCH.md 记录私有参考的公开出处和页内位置，ASSETS.md 记录实际免费文件及许可。新取证目录可运行下列命令：

```sh
godot --headless --path . --editor --import --quit
godot --path . --rendering-driver metal --script res://capture.gd -- final.tscn captures/my-review
```

## 看图记录

首轮门洞旁的纯色跳台突兀，书架每格书组重复，底层摆放穿板。顶灯在整面墙形成集中白斑，工作台没有可辨识的办理单据。第二轮保留原书架网格和通行位置，按实际层高分配立卷与寄存箱，补木纹、分区标签、收件章、工作台垫和分流告示。门后的内衬和远处 B4 标记建立纵深。降低灯光镜面分量后，固定近景中牌匾和表面更清楚。

最终图仍可见椅子、衣帽架及收音机的低面数轮廓。部分桌单小字在固定近景下难以辨读，深木色遮住了部分柜面细节。门洞机位里原始跳台占据前景，整体空间尺度与参考中的多层 Archives 有明显差距。右侧出口以外是低细节过渡区。未获用户美术验收。

本组为从白盒启动的预跑，独立搜索与选择参考。父级从本机 turn_context 核实实际模型为 gpt-6.2-astra、effort 为 low。正式组采用冻结参考，本预跑不纳入跨 effort 排名。
