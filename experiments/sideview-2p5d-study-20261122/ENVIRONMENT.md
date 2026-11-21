# 横向 2.5D · 山谷驿站

2026-11-22。分支 `explore/sideview-2p5d`，起点 `c737e6c`。用户要求先推送现有提交，再开分支探索新方向；随后明确选择“横向视角的2.5D场景”。本轮由主 agent 制作一个方向初稿，不是独立模型/effort 比较，也不自动开展接手修改。

## 范围与目标

- 采用横向为主、允许有限纵深的透视镜头；这是立体场景的侧视表达，不强加像素角色或八方旅人的斜俯视形式。
- Agent 提案为室外“山谷驿站”：石质门道、木构小屋、卸货/休息道具组、花草与远处村落山体。以冷绿/青灰远景衬托暖色建筑和灯火。题材、色调仍待用户看图校准。
- 参考重点是侧面活动面、前景遮挡与多层背景，不声称复刻某个原作关卡或达到其精细度。
- 沿用原 `demo/controller_lab.tscn` 提取出的17个物理构件，保留位置、碰撞、门洞、坡道、台阶、跳台与通路。输入 SHA256：`a309dc9fa677d83b490c0223b8cdb62bba718db7ef1b7b812c4a7ebe43373d26`。不能压成单块地板或为了横向镜头删除纵深。
- 工作区是原白盒；可补外围地形、建筑与植物，活动区装饰避开原通行带。背景需要连续地面过渡、树群、建筑和山体，不能仅靠纯色天空或雾遮住空洞。
- 继承用户对上一轮近景的认可：真实资产、道具组合与表面细节继续有效；技术通过不等于美术通过。现有两个室内稿的围护待修问题不在本分支修订范围。

## 参考与选材

查看了 [Trine 5 官方网站](https://trine5.thqnordic.com/US/win) 六张环境截图。图02、03作为主要空间参考：

1. [screenshot-02](https://trine5.thqnordic.com/game-sites/trine5/content/screenshots/screenshot-02.jpg)：横向低位活动区、边缘树冠框景、树群至远山/建筑的渐次退远。学习层次和轮廓密度，不照搬橙色森林、蘑菇或原作模型。
2. [screenshot-03](https://trine5.thqnordic.com/game-sites/trine5/content/screenshots/screenshot-03.jpg)：石路衔接门道，建筑与植物相互嵌合，近处枝叶和远山分离。建筑民族风格不作为本稿约束。
3. 图01/04/05/06为室内或战斗/机关主导，不能规定本稿的外部照明与空间形态，未用于资产造型选择。

官方截图只在本机临时缓存用于观察，报告保留来源链接，不作为可再分发场景资产。

资产候选：Quaternius Medieval Village / Fantasy Props / Stylized Nature 的 CC0 Standard 免费子集（已有原文件和许可，再次检查当前作者页面并重新在侧面机位试装），对照 Kenney Castle 的低细节模块。免费文件范围以项目内实际清单为准，完整付费宣传图不作为交付能力证明。优先观察墙体、屋顶、相邻木桶/马车、树叶的尺度与质感；不继承旧场景的构图或把历史未通过作品当质量基线。

## 阶段与验收

阶段1完成：原白盒与控制器归档、素材导入、实机试装图 `captures/audition/audition.png` 已查看。Quaternius 的瓦片、木纹和桶箍可读，主建筑采用这组；Kenney Castle 的大片无纹理石墙与之细节密度不一致，淘汰出主场景。WoodGrid 实际是透空木格，不能单独当实体墙；需要与完整灰泥墙叠装。树叶为 alpha cutout，保留透明剪裁。接下来保存局部场景并拍整体/近景/右侧过渡及结构巡检图。首个能判断方向的稿件交用户校准，之后才集中细化。原控制器复用，侧视跟随仅作镜头/输入适配，不开发新玩法或控制器框架。

可编辑工程位于 `project/`。新增阶段图不覆盖已看过的图；具体操作、检查和最终限制在本文件随制作补齐。

## 当前交付与看图结论

方向初稿已完成并自查，当前场景为 `project/waystation.tscn`，四机位证据为 `captures/selected/`。首稿 `project/draft.tscn` 与专属 `ground-draft.gdshader` 保留；`captures/draft/` 显示当时的真实问题。中间修订图位于 `captures/revised/`，只作过程留档，不承诺对应一份独立可编辑场景。不要重新运行 builder 覆盖手工修改后的 scene。

首稿看图发现：地形三角形绕序错误导致反面缺口，远处建筑没有按同一高度函数落地，原右墙遮挡工作台，前景稀疏、环境光偏亮。已翻转/平滑地形、统一落地函数并补基础、调整工作台到可见区域、补植被和藤蔓、降低环境光；最后用同机位重新出图，四张当前图及横移两端关键帧均已逐张查看。所有画面为保存工程重新打开后的游戏渲染，未修图。

仍待审美校准：建筑轮廓和木格重复明显，植被疏密还偏均匀，原白盒跳台作为石台融入较生硬。背景连续，但山体造型和植被细节距离原作参考尚有差距。角色为灰色胶囊比例占位，未制作正式人物。本稿不等同于用户认可，题材“山谷驿站”也只是 agent 提案。后续先根据用户判断决定是否保留侧视镜头、题材与材质方向，再集中细化，不自动铺开全场或 effort 矩阵。

## 打开与操作

用 Godot 4.7.2 导入 `project/project.godot`，F5 运行 `waystation.tscn`，无需安装 MCP。

| 操作 | 按键 |
| --- | --- |
| 横向 / 纵深移动 | A、D / W、S |
| 跳跃 / 奔跑 / 复位 | Space / Shift / R |
| 回到侧视跟随镜头 | 4 |
| 整体 / 近景 / 右侧过渡 / 原结构巡检 | 5 / 6 / 7 / 8 |

镜头保持侧面朝向，只跟随 X；玩家仍使用原 EAPlayerMotor。`sideview.gd` 只适配现有输入和镜头，不改变控制器物理。原白盒允许纵深通行，因此本稿不是把人物强行锁在一根横向轨道上的关卡。

## 必要验证与复拍

`validation/whitebox.json`：17构件变换、尺寸及碰撞保持；`validation/routes.json`：复用之前10项必要通行检查并全部通过。`captures/motion/motion.json`：实际从 x=-7 横移到 x=8.36，镜头从 -7 跟随到7.34，地面高度保持；三张关键帧可检查真实视差。不是连续视频或完整关卡验证。

在工程目录下运行，输出标签必须换成不存在的新目录：

```sh
godot --headless --path . --editor --import
godot --path . --rendering-driver metal --script res://capture.gd -- waystation.tscn ../captures/new-review
godot --headless --path . --script res://verify_whitebox.gd -- waystation.tscn
godot --headless --path . --script res://check_routes.gd -- waystation.tscn
godot --path . --rendering-driver metal --script res://capture_motion.gd -- ../captures/new-motion
```

实机后端为 macOS Metal Forward+。其他平台选择自身驱动，尚未验证外观一致性。资产清单位于 `project/assets/*/manifest.json`，原作者许可证同目录；这些是已下载并检查的免费子集，不是作者完整付费包。本轮没有重新购买或下载付费内容。

Git：现有 main 已通过本机已认证的 SSH 身份推送至 `c737e6c`；未改全局凭据。当前新方向仅在独立分支。

报告：[同机位与横移关键帧](../../docs/sideview-2p5d-study.html)。私人入口：<http://100.96.75.54:8081/docs/sideview-2p5d-study.html>。已完成17项页面交互/图片/宽度检查、13项HTTP与白名单检查；桌面和手机截图已查看。本机通过 Tailscale 地址确认响应，尚未收到用户在 MacBook 的新页面打开确认。
