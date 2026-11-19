# Brinewick · 岸上交鱼所

一段可以从地面走进的半开放渔港工作角。红檐鱼标下是收货入口，右墙下依次布置盐桶、吊秤、切鱼台和待装箱的渔获。石路和工作地台都在陆地上。

## 打开与试玩

使用 Godot 4.7.2 打开本目录的 `project.godot`，按 **F5** 进入 `final.tscn`，起始画面为门洞。单击窗口捕捉鼠标，**1 / 2** 切换第一、第三人称，**3** 进入自由相机。**WASD** 移动，鼠标转向，**Space** 跳跃，**Esc** 释放鼠标。**5 / 6 / 7** 分别回到门洞、工作角和台边机位。

在最终场景的 `Art/LandingGate` 编辑门头，`Art/FishHouse` 编辑墙、棚顶、吊秤与台面。货箱覆面在 `Art/DockFreight`，后侧围护在 `Art/QuayBoundary`。两轮都继承 `whitebox.tscn`，由其中的 `BaseLab` 提供碰撞、玩家与相机。门洞原宽 1.2 m、高 2.3 m，原台阶、跳台和坡道继续可用。

## 同机位实图

| 场景 | 门洞 · 5 | 工作角 · 6 | 台边 · 7 |
| --- | --- | --- | --- |
| [首轮](first.tscn) | [door](captures/first/door.png) | [props](captures/first/props.png) | [close](captures/first/close.png) |
| [终稿](final.tscn) | [door](captures/final/door.png) | [props](captures/final/props.png) | [close](captures/final/close.png) |

两个可编辑小样分别是 [灰泥墙](sample_a.tscn) 和 [青漆横板墙](sample_b.tscn)。素材取舍、下载来源和许可见 [ASSETS.md](ASSETS.md)，冻结参考研究见 [RESEARCH.md](RESEARCH.md)，逐图诊断、修订和技术复拍见 [REVIEW.md](REVIEW.md)。

## 复拍与范围

在本包的渲染队列可用时运行以下命令。复拍需使用尚不存在的输出目录。

```sh
python3 render.py import
python3 render.py capture final.tscn captures/local-check
```

画面以门洞及右侧檐下为完成范围。挡墙左段仍较平直，灯旁墙牌局部偏亮。远海与树线为背景天幕，岸缘近看较硬。坡道外侧与出生区延续控制器实验场形态，捕鱼、称重和吊运均为静态陈设。
