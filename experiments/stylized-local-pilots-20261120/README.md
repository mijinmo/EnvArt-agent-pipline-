# 四个新风格局部 · 2026-11-20

四个代表性局部已完成素材发现、Godot 小样、完整初稿与看图自查；均为 **GPT-6.2 Astra / high**，运行记录已确认。用户授权直接开始制作，当前仍是 `awaiting_user_calibration`，尚未获得用户美术验收。

[HTML 分类与阶段对比](../../docs/stylized-local-pilots.html) · [任务范围](brief.json) · [协调者图像检查](delivery.json) · [执行与隔离审计](audits/execution-summary.json)

私人远程入口：[Tailscale 预览](http://100.96.75.54:8081/docs/stylized-local-pilots.html)。设备须接入同一 tailnet，使用 `http`。服务只发布报告和图片；可编辑工程留在仓库。

## 可编辑结果

用 Godot **4.7.2** 导入对应 `project.godot`，等待资源导入后按 F5。按 **5 / 6 / 7** 看整体、近景、过渡，**1 / 2** 切第一/第三人称，**3** 自由巡检；WASD、鼠标、Q/E 与 Esc 沿用现有巡检基础设施。

| 游戏方向 | 独立工程 | 当前场景 | 当前图 | 主要剩余问题 |
| --- | --- | --- | --- | --- |
| 盗贼之海 · 地窖 | [工程](results/sea-of-thieves/project.godot) / [说明](results/sea-of-thieves/README.md) | `draft.tscn` | [三机位](results/sea-of-thieves/captures/reviewed/) | 桶架与石块偏规整，梁底硬影，纵深较短 |
| 意航员 2 · Otto 工坊 | [工程](results/psychonauts-2/project.godot) / [说明](results/psychonauts-2/README.md) | `draft.tscn` | [三机位](results/psychonauts-2/captures/final/) | 非对称造型不足，中央设备阻挡后场，展品重复 |
| 恶意不息 · 林桥 | [工程](results/no-rest-for-the-wicked/project.godot) / [说明](results/no-rest-for-the-wicked/README.md) | `revised.tscn` | [三机位](results/no-rest-for-the-wicked/captures/revised/) | 近石偏亮，植物叶影细碎，块面与原作仍有距离 |
| 原神 · 离岛门面 | [工程](results/genshin-impact/project.godot) / [说明](results/genshin-impact/README.md) | `draft.tscn` | [三机位](results/genshin-impact/captures/final/) | 檐下纵深浅，铺地重复，陶器/植物折面明显 |

原神店名「潮見屋」、经营内容、布纹及远岸为制作组设计，并非原作官方店铺复刻。其主要建筑/器具来自实际下载的 [3DAssets.dev Feudal Japan Castle Town](https://3dassets.dev/packs/feudal-japan-castle-town)。协调者另核实该页面声明 **CC0，179/179 文件使用 AI（Claude Fable 5.1）**；因此这条路线不能标为人工制作资产库。上游声明见[许可页](https://3dassets.dev/license)。每组实际免费文件、适配与许可见自身 `ASSETS.md`，游戏原作图片仅作参考，不放入游戏可见材质。

## 保存与再现

共归档 **833 个文件、54 张阶段截图**。各组的完整资源版本在独立 Git 历史中保存，入口如下；这些引用不会随普通主分支 push 自动传输。

| 方向 | 初稿交付提交 | 历史引用 |
| --- | --- | --- |
| 盗贼之海 | `cd21162` | `refs/envart-local-pilots/20261120/sea-of-thieves` |
| 意航员 2 | `67a1351` | `refs/envart-local-pilots/20261120/psychonauts-2` |
| 恶意不息 | `a87bde1` | `refs/envart-local-pilots/20261120/no-rest-for-the-wicked` |
| 恶意不息反馈修订 | `36bc65e` | `refs/envart-local-pilots/20261120/no-rest-for-the-wicked-revised` |
| 原神 | `f6a0740` | `refs/envart-local-pilots/20261120/genshin-impact` |

除恶意不息另存修订资源外，其他组的小样/初稿使用过共享素材的早期版本。**旧截图保持原样；只打开旧场景文件、却使用最终素材，不保证重现旧截图。** 要编辑和重新渲染旧阶段，应使用对应项目 README 所列阶段提交，解出该提交完整文件。不要覆盖当前交付目录或阶段截图。

各包 `render.py` 是本次隔离制作的队列客户端，需要原制作期协调服务；归档后无需它即可直接用 Godot 编辑和出图。在对应工程目录执行以下命令（图形出图需要可用的 macOS 图形会话）：

```sh
/Applications/Godot.app/Contents/MacOS/Godot --headless --editor --path . --import
/Applications/Godot.app/Contents/MacOS/Godot --path . --resolution 1280x800 --script res://capture.gd -- draft.tscn captures/local-review
```

恶意不息当前交付用 `revised.tscn`；`captures/local-review` 必须尚不存在。脚本重开已保存场景，按冻结的 `views.json` 拍摄三图，不生成或修改美术。无需另加控制器、UI 或全套功能测试。

## 已执行的检查与限制

- 四组最终三机位由制作组和协调者查看。当前图的渲染日志均为退出码 0，三个 CAPTURE 标记齐全，无加载/解析错误。
- 833 个归档文件与各自记录的 SHA-256 一致；347 处场景/材质外部资源引用存在。捕获器与巡检基础设施未改动，正式初稿后相机冻结。
- 在线报告的 59 项浏览检查通过，覆盖四游戏参考图、全部展示阶段与机位、分类、放大、用量表及手机宽度；桌面与手机截图已查看。新旧入口和实际图片从本机经 Tailscale IP 返回 200，工程/会话路径及目录列表返回 404；尚未另获用户 MacBook 对新报告的打开确认。见 [报告检查](audits/report-validation.json)。
- 恶意不息同一制作会话接受了一次明确图像反馈，改光色、水纹与岸边疏密，另存 `revised.tscn`；218 个旧文件字节未变，原场景及美术资源保留。它不是新独立样本，也不是 B 接手试验。
- 各组新上下文、独立目录与 Git，受限 shell 与引擎读取；在实际调用中未发现横读。图像工具的隔离仍依赖范围约束和调用审计，不能称为所有工具均不可越界的证明。
- 恶意不息小样阶段只找到直接查看近景的调用记录；整体/过渡已出图，但不能声称该阶段三张均已看。正式初稿及修订三张均有看图记录。
- 协调端早期盗贼之海白盒截图曾在导入前运行而出现类缓存错误；重新导入后的实际制作图正常。意航员首个小样有数字解析错误，修复后的材质小样和交付图正常。失败图不作为美术成果。
- 意航员归档 `ASSETS.md` 仅清理一处行尾空格，生产者原始哈希另存；原神小样场景末尾空行与上游许可原格式保持不动。

本轮没有固定同一游戏的参考输入、素材条件和多档 effort，四个不同方向也不是等工作量对照。输出已有完整局部与细节，但共同留下了规整重复和空间层次问题，不能由技术检查通过推导美术达标，也不能由单次结果证明“最优管线”。当前可验证的收益是：小样发现材质问题、三机位自查修掉显性缺陷、具体图像反馈改善部分光色；审美方向仍需用户校准。

实际制作 token 与时间见 HTML 及审计。输入含大量缓存上下文，输出包含推理；不含协调、审查和页面制作，不能用累计输入 token 换算 Codex 订阅额度。

## 报告维护

修改 `delivery.json` 的实图观察后运行：

```sh
python3 tools/build_stylized_pilots_report.py
```

该命令在仓库根目录执行，只重建 HTML，不启动 Godot、不重跑代理。页面提供四游戏、三机位、阶段切换、五类对比与放大查看；私人托管只同步可浏览文件，保留此前 24 组报告入口。
