# Control 档案交接室内：当前交接入口

> 试验项目，不是美术验收成品。最后一次实机看图：2026-11-17；该轮尚未获得用户美术确认。
> 这里是当前范围、证据和未解决问题的入口。历史过程仍在 [README.md](README.md)。

## 当前范围

- **入口场景**：`interior_detailed.tscn`（F5），Godot 4.7.2 / Forward+ / Metal，1600×1000。
- **已完成局部**：东墙档案办公区、墙边交接用品和门洞内侧；原测试场其余部分仍是白盒。
- **空间类型**：封闭室内。净高 5.5 m，顶部 3×5 m 玻璃采光口，门洞净空 1.2×2.3 m。
- **保护前提**：原 17 个白盒 body 的变换、网格尺寸和碰撞不变；坡道、台阶、跳台和通路不变。
- **当前判断**：活动组和冷暖光比上一版更可读，但仍明显低于 Control 参考；墙面、地面、柜体和门后空间是主要短板。

## 不能改的保护项

- 门洞有效净宽和净高不得缩小；不得在门洞内新增门扇、门槛或道具。
- 坡道坡度与宽度、台阶、跳台表面、出生点和通行路线保持原状。
- 新增围护、灯具和道具均为视觉内容；不新增玩法碰撞，不堵住门洞、坡道和活动区。
- 手工修改优先。`refine_interior.gd` 会从 `interior.tscn` 重建并覆盖 `interior_detailed.tscn`，运行前先另存或提交。
- 本轮目标是环境美术，不新增控制器、交互面板或玩法回归套件。

详细约束见 [constraint_notes.md](constraint_notes.md)，原白盒来源与 17/17 核对见 [constraint_check.txt](constraint_check.txt)。

## 区域

| 区域 | 范围 | 当前状态 | 相关问题 |
| --- | --- | --- | --- |
| R1 档案办公区 | 东墙内侧，约 x=7.29–9.56、z=-10.63–-5.27 | 已装配桌椅、柜组、货架、交接车和纸品 | W-01、W-02、W-03、W-05、W-06 |
| R2 门洞与门外可见段 | 门洞内侧、门楣、门号及门外走廊可见部分 | 门洞和标识已完成；门外仍是暗而空的空间 | W-04、W-06 |
| R3 坡道与台阶 | 原测试坡道、台阶 | 原白盒，未进入本轮美术范围 | W-07 |
| R4 测试场其余区域 | 跳台、出生区、外围地面 | 原白盒，未进入本轮美术范围 | W-07 |

## 机位与各轮证据

当前室内只有三个验收机位：`room`、`props`、`door`。它们保存在场景 `Cameras` 下，可在编辑器中预览。

| 轮次 / 目录 | 证明什么 | 不能证明什么 |
| --- | --- | --- |
| `captures/whitebox/`（overall、ramp、door、props） | 原白盒与原始实验室光照 | 不是美术结果 |
| `captures/interior-before/`（room、props、door） | 封闭化之前、同三机位的开放场景 | 不是当前结果 |
| `captures/interior-glazed/`（room、props、door） | 封闭室内初稿和第一次材质修订 | 已被 `detail-01` 取代 |
| `captures/detail-01/`（room、props、door） | **当前场景**的实际渲染 | 不代表用户已接受，也不覆盖全场 |
| `captures/art-base/`、`art-lit-01/`、`art-lit-02/`（overall、ramp、door、props） | 早期开放设施的照明 A/B | 不同空间类型，不能用来验收当前封闭室内 |

当前图：[room](captures/detail-01/room.png) · [props](captures/detail-01/props.png) · [door](captures/detail-01/door.png)。

场景、关键 shader 和截图哈希见 [detail_freeze.json](detail_freeze.json)；素材来源、免费范围和适配说明见 [detail_manifest.json](detail_manifest.json) 与 [interior_manifest.json](interior_manifest.json)。文件哈希只覆盖列出的文件，不等于全部依赖可复现。

## 当前最重要的差距

完整证据、影响范围和复核条件见 [review.json](review.json)。按处理顺序：

1. **W-01 主墙面尺度与表面**：近景几乎读成平整灰色墙板，缺少参考中大体块混凝土的施工分格、边缘和低频表面变化。
2. **W-02 地面完成度**：大面积地面过于均匀、发暗，缺少材质尺度、接缝和家具接触处的必要信息。
3. **W-03 柜体精度断层**：档案柜侧面像平板盒子，与桌子、椅子的细节密度差异明显。
4. **W-04 门后空间**：门洞外是均匀暗区，缺少地面过渡和任何目的地线索。
5. **W-05 道具密度与组构**：货架和墙边仍偏“展示式摆放”，大片地面空置。
6. **W-06 光影层级与灯具连接**：墙面照度偏均匀，顶棚偏黑，货架阴影偏大，门楣有高光热点，吊灯连接构造偏薄。
7. **W-07 未完成区域**：坡道、台阶、跳台和其余测试场仍是白盒，不能作为成品展示。

**不要在 W-01、W-02 解决前继续加小道具。**用更多箱子或压暗画面掩盖主表面问题，正是前几轮的失败模式。

## 下一轮：一个受控的表面样板

只处理 R1 的主墙面和地面，不新增道具：

1. 在同一场景、同一 `room` / `props` 光照与机位下，准备 2–3 个墙面处理候选（施工分格尺度、低频色差、必要边缘磨损），避免重复的模板孔/板缝图案。
2. 同时准备 1–2 个地面处理候选，检查房间尺度、接地和家具底部接触。
3. 保存为独立试验场景或独立节点组，不覆盖 `detail-01`；新图写入新轮次目录。
4. 用近景判断“是否像大块混凝土”，用整体机位判断是否抢焦点、是否与家具精度相容。
5. 记录每个候选的淘汰理由。用户看图决定是否继续，不把内部分数当作美术通过。

建议验收条件：

- `props` 距离下，主墙能读出大尺度构件和受控的表面变化，不出现显著重复母题。
- `room` 距离下，墙面不压过桌椅和档案活动，地面不呈现为一块均匀暗板。
- 现有门洞净空、碰撞、机位和道具位置不变；旧轮次截图不被覆盖。

## 建议阅读顺序

1. 本文件。
2. [review.json](review.json)：问题、证据、影响机位和复核条件。
3. [constraint_notes.md](constraint_notes.md) 与 [constraint_check.txt](constraint_check.txt)：不能破坏什么。
4. [detail_manifest.json](detail_manifest.json)、[interior_manifest.json](interior_manifest.json)、[detail_freeze.json](detail_freeze.json)：素材、许可和冻结关系。
5. `captures/detail-01/` 三张图，再对照 [Control 参考 3](../../docs/images/game-studies/references/control-3.jpg) 和 [Control 参考 4](../../docs/images/game-studies/references/control-4.jpg)。
6. 需要完整历史时再看 [README.md](README.md)。

## 已知的范围说明冲突

[lighting_notes.md](lighting_notes.md) 开头描述的是早期**开放设施**照明试验（四机位、无室内围护）；当前 `interior_detailed.tscn` 是**封闭室内**（三机位）。该文件的照明结论只能用于那次试验，不能直接评价当前室内。已在原文件顶部加范围提示，历史内容未改写。
