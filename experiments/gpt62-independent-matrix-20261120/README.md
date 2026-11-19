# GPT-6.2：从白盒独立制作比较

2026-11-20 用户授权重跑现有四游戏 × 六档 effort：**Control、Sable、Hi-Fi RUSH、DREDGE × low、medium、high、xhigh、max、ultra**，模型统一为 `gpt-6.2-astra`。24 组均已从同一游戏的冻结白盒独立完成两轮，四份图像盲评与实际调用审计已完成。不沿用旧成品，先行 Control 单组验证不计入排名。

## 固定与变量

- 每个游戏的六组使用相同的白盒、局部范围、三机位、1280×800 分辨率、Godot 4.7.2 Metal Forward+、skill 快照和冻结参考。每组独立找素材，不提供固定素材池。
- 每组完成素材小样、首轮场景和一次自主美术修订。首轮三张图必须实际查看；首轮资源和截图冻结。技术修复单列，不追加组间美术反馈。首轮/终图混合了素材、布置与灯光变化，不能单独证明 shader 效果；同构图且保留材质/灯光的额外开关对照另列。
- 唯一计划改变的模型参数是 effort。每档只有一次样本，结果用于本次局部的方案筛选，不能证明某档普遍最优。

## 隔离与审阅

每组使用随机临时目录、新 Git 历史、新 CLI 上下文、独立临时/下载/引擎缓存。制作进程禁止读取宿主成果、其他组目录和聊天历史；协调者收集后才进入本目录。CLI 的 shell 文件权限与 Godot 专用渲染进程分别施加文件边界；渲染排队只交换本组的场景路径和完成状态，不传播别组内容。图片工具的路径行为不能仅凭 shell 预检推断，最终另查实际调用记录。

先按随机标签审阅全部固定机位，分别评价参考贴合、内部统一、素材适配、功能/叙事细节、光影/空间层次，再揭示 effort 和用量。token 不等于金额，含排队/审批的总耗时不作为速度排名。用户美术验收与代理评审分开。

已交付：24 个可编辑工程、144 张正式首轮/最终原图、共同白盒、素材小样与技术修复前证据、素材来源和许可、四份匿名评审与隔离审计、按游戏和五类能力筛选的 HTML。制作与盲评进程均已结束，阶段提交保存在本地，未推送。

[HTML 分类与同机位对比](../../docs/gpt62-independent-matrix.html) · [输入与运行清单](run-manifest.json) · [隔离预检](ISOLATION.md)。四游戏参考共 11 张已实际查看并冻结，只归档来源与哈希，私有参考原图不再分发。实测每个游戏全部六组的归一化输入哈希一致，首轮依赖与已有资源均未被终版修改。唯一归一化字段是用于分离 Godot 用户缓存的 config/name。

## 本次筛选

| 游戏 | 综合质量优先 | 参考贴合优先 |
| --- | --- | --- |
| Control | **ultra** | ultra |
| Sable | **max** | xhigh |
| Hi-Fi RUSH | **max** | xhigh |
| DREDGE | **xhigh** | max |

表中是已实际完成的整套方案。Sable 若愿意接受盲评次选，可选输出与未缓存输入更少的 ultra；Control / DREDGE 的综合首选本身比各自次选 max 用量更少。Hi-Fi RUSH 的具体质量与用量取舍见 HTML。token 的缓存输入、未缓存输入与输出分别列出，不折算金额，不使用排队墙钟时间排名。

HTML 可先隐藏档位看图，再揭示 effort；支持四游戏、三个机位、首轮/最终并排、五类证据和管线步骤。每组卡片链接实际工程、素材许可与制作说明。跨组借鉴属于待验证组合，不冒充已完成的最佳管线。

[逐组制作审计](run-audit.json) · [盲评审计](review-audit.json) · [原始匿名评审](reviews/) · [标签映射](label-map.json) · [归档完整性检查](completion-check.json) · [浏览器检查](page-check-results.json)。原始判断逐字节保存；供浏览的 Markdown 只调整图片链接和归档说明。

实际记录未发现组间美术横读。仍需保留的过程差异包括：个别小样遮挡未排除就选材、部分组自查使用缩小预览或没有明确白盒看图记录、少数镜像素材的作者原包字节未验证，以及部分 Control 捕获退出时的 Texture RID 提示。每项均在对应审计中列明，不能将本轮描述为所有规则均无缺口通过。静态图不代替人工通行、美术验收或跨平台测试；ultra 的单制作 agent 限制同样适用。

## 打开与重新拍图

收集后的工程在 `results/<游戏>/<effort>/project.godot`，用 Godot 4.7.2 标准版导入，F5 打开 final.tscn。源场景与资产不依赖当时临时目录。first.tscn 和原白盒均保留；控制方式见各工程 README。

各工程内的 render.py 是当次隔离试跑的队列客户端，收集后不会自动启动协调服务。普通本机复看可直接调用已安装的 Godot：

```sh
# 在要复看的单个结果工程目录内执行，输出使用未存在的新目录。
godot --headless --path . --editor --import --quit
godot --path . --rendering-driver metal --audio-driver Dummy \
  --script res://capture.gd -- final.tscn /absolute/path/to/new-evidence
```

Windows/Linux 换用对应图形后端；跨平台画面尚未验证。不要重跑 builder 覆盖保存场景，不要覆盖现有首轮/终图。`.work/frozen-references` 是当时私有参考缓存，未归档；公开来源、准确图片 URL 与哈希保存在 REFERENCES.md / references.json。

## 独立阶段历史

已收集样本的独立提交历史同时保留在宿主 Git 的 `refs/envart-trials/20261120/<游戏>-<effort>` 下，具体引用见 run-audit.json。这些引用不切换主分支，也不与主分支合并；制作进程没有宿主 Git 的访问权限。可用 `git log <引用>` 查看原来的分阶段提交。`git bundle create ... --all` 会保存这些本地引用；普通主分支 push 不会自动推送它们。本次没有推送。若从 bundle 克隆，另执行 `git fetch /path/to/envart-handoff.bundle 'refs/envart-trials/*:refs/envart-trials/*'` 恢复这些自定义历史引用；不要假定普通 clone 会自动取回它们。

## 升级后六档范围修正

最初沿用旧比较的四档口径，启动了 16 组。随后核对升级后的本机模型缓存，GPT-6.2 Astra 实际列出 low、medium、high、xhigh、max、ultra 六档；依照用户“每档都重跑”的要求补齐 max / ultra，共 24 组。追加组复用完全相同的冻结输入，独立重新找素材，仍限两轮。所有组都关闭进一步自动委派；因此本轮的 ultra 是这个隔离/单制作 agent 条件下的结果，不能代表开启自动委派的完整 ultra 工作方式。追加组在首批 16 组调度结束后启动，不能根据先后顺序或墙钟时间推断性能。
