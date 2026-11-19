# 三游戏续作结果与使用边界

完整图像入口：[四游戏统一 HTML](../../docs/multi-style-effort-study.html)。每游戏四档各两轮，共 12 份最终场景；同游戏内相机、白盒和起点相同。制作中父 agent 只处理技术问题，未给不同组追加美术方案。

独立视觉评审先获得固定参考、共同起点与 A/B/C/D 图像，不提供 effort、用量或实现说明；三份评审均查看了全部终图，父 agent 也看过 36 张终图。评审完成后才将结果映射到档位：A=medium、B=xhigh、C=low、D=high。

| 游戏 | 本次整块局部的视觉排序 | 关键判断 |
| --- | --- | --- |
| Control | high > xhigh > medium > low；前两者接近 | high 的档案架、交接位、等候椅与入口更连贯；只看桌边近景，xhigh 更好。新纸盒与旧 PBR 箱的精度仍不一致。 |
| Sable | xhigh > high > medium > low；前两者接近 | xhigh 的叶轮、图解、支架与门侧吊装功能对应最好；high 的细杆索和全景剪影更接近主参考。软质感真实素材与平涂补制件仍有落差。 |
| DREDGE | high > xhigh≈medium > low | high 的船、测深线、卷轮、海图跨三个机位都能连起来；medium 门内灯光引导更好，xhigh 的明亮白墙和浮标削弱暮色。 |

逐图证据：[Control](review-control.md)、[Sable](review-sable.md)、[DREDGE](review-dredge.md)。它们是 agent 的视觉判断，不等于用户美术验收。

## effort 与用量

本批没有可据以确定“性价比最高”的统一费用和质量阈值。Control medium 可作为较省输出的候选；追求这次局部完整性可先看 high。Sable 优先看 xhigh 与 high 的取舍；DREDGE 优先看 high。此前 Hi-Fi Rush 暂选 high 的判断仍只适用于它自己的试跑。

Control high 比 medium 输出多约 113%；Sable xhigh 比 medium 输出多约 7.6%，但未缓存输入更多；DREDGE high 比 medium 输出多约 17.1%，未缓存输入多约 77.8%。这些比例**不是费用比例**，更不能用一个指标给不同任务推导总成本。

[usage.json](usage.json) 保留实际模型/effort、输入/缓存/输出及原始记录跨度。推理 token 是输出的子集，不重复相加。生产组不包含父 agent 的准备、协调、汇总及独立评审；可取得的独立评审用量另列，父 agent 未分摊。

本机记录中存在较长未解释时间间隙，并包含 GPU 排队、审批、技术修复、共享 Git 等待。没有全程单调时钟计时，所以表中时间只叫“原始记录跨度”，不用来评出模型速度或计算性价比。技术失败不算额外艺术轮次，具体记录见各组 README。

## 可比性与隔离

本批是相同成熟局部的续作，不是独立从白盒产出，也没有重新检索资产包。共享文件系统暴露了部分 Git 元数据和一个中性工具脚本；未发现直接读取其他组美术内容，但不能称为严格隔离。详见 [访问检查](ISOLATION-AUDIT.md)。图像趋同本身不能证明相互读取，也不能证明这套管线具有设计多样性。

[delivery-check.json](delivery-check.json) 记录既有交付检查：冻结资源未变、三机位与 17 个原白盒实体快照一致、72 张首轮/终图尺寸正确、F5 指向 final。它只支持文件/约束完整性，不代表艺术达标，也不证明任意视角都可通行。

用户要求迁移前不再启动 Godot。本次收尾仅整理规则、页面、数据与 Git；新隔离规则尚未实际试跑。
