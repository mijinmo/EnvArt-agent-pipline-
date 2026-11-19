# 素材、改造与小样

## 下载件

三套模型取自 Kenney 在 OpenGameArt 发布的免费完整 ZIP。按包内 GLB 文件清点变体，FBX、OBJ、调色图与预览是同一批模型的其他表示。以下 CC0 素材允许改作、随项目分发及商用，包内许可保存在 `art/licenses/`。

| 来源与免费范围 | 项目中的实际文件与改造 |
| --- | --- |
| Kenney，Fantasy Town Kit 2.0，167 个 GLB。[作者目录](https://kenney.nl/assets/fantasy-town-kit) · [实际下载](https://opengameart.org/sites/default/files/kenney_fantasy-town-kit_2.0.zip) | 从同名 OBJ 提取 `wall`、`wall-wood`、`wall-window-shutters` 和 `stall`。墙原件宽高各 1 m，厚约 0.10 m，原点偏在正 X 一侧。重新以底部中心为锚点，保留窗板、立框和台架几何。 |
| Kenney，Pirate Kit 2.1，72 个 GLB。[作者目录](https://kenney.nl/assets/pirate-kit) · [实际下载](https://opengameart.org/sites/default/files/kenney_pirate-kit_2.1.zip) | `barrel` 原直径约 1.34 m，高 1.23 m，成品用作直径 0.75 m 的盐桶，保留箍圈；`crate` 保留开口与四角板条，用作接货箱。 |
| Kenney，Food Kit 2.0，200 个 GLB。[作者目录](https://kenney.nl/assets/food-kit) · [实际下载](https://opengameart.org/sites/default/files/kenney_food-kit.zip) | `fish` 原长约 0.62 m，烘焙侧卧姿态后重设接触面；`cutting-board-japanese`、`cooking-knife-chopping` 与 `bowl` 按案面进深配比。金属刀身与木柄保留独立表面。 |
| Rob Tuytel，Cobblestone Floor 04，免费 CC0。[素材与作者](https://polyhaven.com/a/cobblestone_floor_04) · [下载的 1K Diffuse](https://dl.polyhaven.org/file/ph-assets/Textures/jpg/1k/cobblestone_floor_04/cobblestone_floor_04_diff_1k.jpg) · [许可](https://polyhaven.com/license) | 原扫描覆盖 1.5 m。将漫反射中值滤波、压缩明度层次，改为青灰与褐灰的 `art/surfaces/quay_stone.jpg`。世界尺度投影。放弃湿石的高光与法线，让石面保持干燥。 |

模型交付为 `art/models/*.glb`。读取包内 OBJ 的 UV、法线与 colormap，用源颜色区分灰泥、木饰、铁箍和鱼体，再把改色写入 GLB 的基础色材质。木纹、青漆横板和灰泥表面使用本次绘制的三张铺贴图。它们有独立的 UV；原包的调色板 UV 只用来识别色区。外海峡天幕是本次绘制的渐变、云片和远岸剪影。

## 右墙与相邻操作台小样

两场景使用整段 10 m 右墙、4 m 折墙，同一案台、鱼、刀、空箱、盐桶、铺石和侧光。A 用灰泥墙与带扇窗间，B 用青绿板墙。初次导入时桌子、鱼和部分木框呈白色；把分面色写入 glTF 材质基础色，在新目录重新截图。正式比较用下列修复后的实图。

| 机位 | A 灰泥 | B 横板 |
| --- | --- | --- |
| 全墙与工作面 | [props](captures/sample-cream/props.png) | [props](captures/sample-boards/props.png) |
| 台边 | [close](captures/sample-cream/close.png) | [close](captures/sample-boards/close.png) |

A 的浅墙衬得出鱼背，但整排都亮，木台和墙几乎连成一块。B 的转角、横缝和暖案面更易辨认，满墙横缝与划痕周期也明显。工作台后选 B，门柱和工作间其余开间选 A。用檐影压低墙体上部，青漆只延伸到紧邻收鱼的位置。木地台覆盖案台前的部分石面，保留石路作为入口。

## 首轮装配

- Fantasy Town Kit 另取 `roof-gable`、`roof`、`wall-detail-diagonal`、`pillar-wood`、`planks`。坡屋顶沿原屋脊方向装配，横板用于工作地台、通口及箱盖。保留原柱的底脚。Pirate Kit 的 `crate-bottles` 和 `tool-paddle` 用作腌制用瓶箱及收在折墙前的木桨。Food Kit 的 `mussel-open` 放进搪瓷盆。
- 针对本地缺口制作了 `cage_lamp`、`life_ring`、`cod_vane`、`cork_float`、`scale_pan`、`laid_line`、`hanging_seine`。秤的表壳、秤绳、挂钩与表盘在 Godot 内分件装配。秤盘有内壁；渔网的绳结、浮子与系绳是网格。
- `art/graphics/` 的鱼形标记、门匾、秤盘刻度、台账和货戳由本次绘制。文字用 The Barlow Project Authors 的 Barlow Condensed Bold 栅格化。字体采用 SIL Open Font License 1.1，随项目保留许可文本。[字体来源](https://github.com/google/fonts/tree/main/ofl/barlowcondensed)

## Final 专属资源

`art/final/` 内有另存的墙、屋面、铺板、台架、桶箱、案板与表面图。保留原构件的几何，单独调整旧木、青漆与红铁皮的色调，降低灰泥与木纹的笔触对比。石面仍来自同一张 Rob Tuytel 漫反射。远岸剪影、云带和外围海色绘在 final 天幕上。

`sound_trout.glb` 和 `dressed_trout.glb` 都沿用 Kenney Food Kit 的鱼体。按鱼身长轴与背腹高度展开侧纹，配用新绘的眼、鳃和侧线贴图。切段保留源鱼截面的轮廓，移除截面之外的鳍，并以脂纹和脊骨贴图封口。鱼箱内增加承托底板。吊秤另绘 0–6 kg 刻度，指针约在 1.8 kg；这是场景中的静态贸易秤。条纹晾布、壁端吊臂、收绳和推拉闸板由本次装配。
