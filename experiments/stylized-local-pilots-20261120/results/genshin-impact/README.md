# 离岛街角 · 潮见屋

Godot 4.7.2 可编辑环境初稿。临街柜台陈列陶器与试茶用具，左侧木台处理装箱，右侧格门和花箱收住门面。主参考为离岛 Vahid 商铺实机图，「潮見屋」店名、器物铺经营内容与远岸为本包的设计。

## 打开与巡检

用 Godot 4.7.2 打开 project.godot，导入完成后按 **F5** 进入 draft.tscn。按 **5 / 6 / 7** 切换全景、近景、过渡书签，**1 / 2** 切换第一、第三人称，**3** 自由巡检。WASD 移动，鼠标转向，Q / E 控制自由巡检高度，Esc 释放鼠标。中央石路保留原地面碰撞和访问空间。

直接在场景树编辑 Shop（门面、石台、格门）、Merchandise（柜台、器物与背架）、ReceivingBay（装箱台与车桶）、EavesAndSigns（匾额与纸灯）或 StreetPlanting。模型在 art/models，绘制贴图在 art/surfaces。场景无需运行生成器。

## 画面与阶段

| 阶段 | 版本 | 实机记录 |
| --- | --- | --- |
| 确定参考 | 0cb23a9 | [参考依据](RESEARCH.md) |
| 日光素材小样 | 3762307 | [三机位](captures/audition/) |
| 首次完整初稿 | 40ee19a | [三机位](captures/draft/) |
| 遮挡、台布、巷口修复 | 188f2a4 | [三机位](captures/draft-fixed/) |
| 最终可编辑初稿 | 当前提交 | [全景](captures/final/overall.png) · [近景](captures/final/close.png) · [过渡](captures/final/transition.png) |

**awaiting_user_calibration**。剩余三项与修复前后证据见 [REVIEW.md](REVIEW.md)。实际下载文件、适配与许可见 [ASSETS.md](ASSETS.md)。

在本包配置的渲染环境中，使用以下命令重新导入并录下三个书签。输出目录须为新目录，已有截图保持冻结。

```sh
python3 render.py import
python3 render.py capture draft.tscn captures/local-review
```
