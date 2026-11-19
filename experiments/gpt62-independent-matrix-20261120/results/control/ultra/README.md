# Film Archive 04 · 胶片档案交接处

用 Godot **4.7.2** 打开本目录的 [project.godot](project.godot)，按 **F5** 进入 [final.tscn](final.tscn)。初始视点朝向档案门洞，沿门后的右墙可找到待检片罐推车、放映检查台、索引柜和交接窗。

| 查看入口 | 门洞 | 工作角 | 桌面近景 |
|---|---|---|---|
| [首次成品](first.tscn) | [door](captures/first/door.png) | [props](captures/first/props.png) | [close](captures/first/close.png) |
| [自主修订后](final.tscn) | [door](captures/final/door.png) | [props](captures/final/props.png) | [close](captures/final/close.png) |

## 试玩与编辑

**5 / 6 / 7** 进入表中三个固定机位，**1 / 2** 切换第一或第三人称，**3** 自由观察。WASD 移动，鼠标转向，Space 跳跃，Esc 释放鼠标，单击游戏画面重新捕获鼠标。

在场景树的 **Art** 下，ArchivePortal 是门框和高窗，FlatFileBank 是与跳台重合的平图柜，FilmIntakeCart、Workstation 和 InspectionInstructions 分别管理推车、桌柜和墙上文件，ServiceJoinery 管理半开窗口。Practicals 可调整实际灯具与照明。桌柜与推车有简化碰撞。原场景实例保留为 **BaseLab**，原有行走、跳台、台阶、门洞及坡面碰撞继续工作。改稿时另存 final 场景；首轮图对应 first 及其原资源。

## 制作阶段

1. [参考研究](RESEARCH.md) 记录三张冻结图提供的证据和本次空间假设。
2. [小样 A](sample_a.tscn) 与 [小样 B](sample_b.tscn) 使用同一套钢桌、双盘放映机、木柜、椅和照明，比较整墙与地面。A 的竖纹模板混凝土、水磨石被选入首轮。[来源、许可与小样实图](ASSETS.md)
3. 首轮以原门洞及局部高约 4.5 m 的梁格围合空间，给墙边工作台配上走片图、文件和灯具。
4. 终版连通门头高窗，处理表单与夹灯的安装，整理推车和收件窗，调整工作面与周边的明暗。[逐机位诊断](REVIEW.md)

## 范围与限制

制作集中在门洞和右墙交接角，相邻部分只延续必要围护和地坪。局部以外仍为控制器白盒。固定 door 视图中左上高窗有较亮反光；close 中收件窗内部及桌底较暗。终图为引擎自评实图。

本机 GPU 导入使用 `python3 render.py import`。如需重拍，使用新的目录名，例如 `python3 render.py capture final.tscn captures/final-recapture`。冻结输入、原始参考、下载临时文件与截图队列的用途见 [ENVIRONMENT.md](ENVIRONMENT.md)。

默认 Git 启动时尝试访问全局配置，系统拒绝了读取；默认 shell 临时写入也受到限制。后续 Git 使用本组配置，制作临时文件均放在本组 .work 内。
