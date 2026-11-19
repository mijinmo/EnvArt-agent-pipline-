# 素材与小样

三个包均为 Kenney 发布的免费完整下载，每包内的 License.txt 已保存在对应 assets 子目录。许可为 CC0，允许改造、随工程再分发和商业使用。仅取制作所需的一部分 OBJ 与共用色卡。模型基于各自包内的 OBJ format 版本，保留顶点法线、面与 UV；水平原点移到包围盒中央，底面归零，共用 palette.mtl。小样沿用包内色卡。

| 免费包与来源 | 实际用途 |
| --- | --- |
| [Fantasy Town Kit 2.0](https://opengameart.org/content/fantasy-town-kit) | 护墙、带窗的填充墙、柱、坡屋面、木板、灯及摊凳。 |
| [Pirate Kit 2.1](https://opengameart.org/content/pirate-kit) | 箍桶、敞口箱、瓶箱与船桨。 |
| [Food Kit](https://opengameart.org/content/food-kit) | 整鱼、砧板、切刀、贝与碗。 |

**尺寸核对**　墙的原始包围盒为 0.1 × 1 × 1，长凳为 0.26 × 0.2255 × 0.94。本地墙按 2 米一跨排列，长凳改为 0.9 米高的处理台。三个包均为色卡 UV，下载的 OBJ 没有独立法线或粗糙度图。

**小样选择**　sample_a 和 sample_b 采用相同机位、日照、台面与货物，覆盖完整东墙及折返。props 图里 A 的浅填充面把窗与桶从背墙分开，B 的红棕墙、立柱与台面靠色相难以区分。close 图中两者的刀板比例可读，木色都偏橙，A 的墙也偏紫。采用 A 的分色结构，生产时调整墙灰、木材和屋面色彩，并在台面周围保留空隙。

## 成品改造与文件

assets/town、assets/port、assets/food 的 OBJ 文件名沿用原包。小样和成品实际引用的墙件含 wall、wall-window-shutters、wall-wood、wall-wood-window-shutters。棚顶用 roof，门顶用 roof-gable-end，棚柱用 pillar-wood。stall-bench 与 stall-stool 分别作台与凳，planks 作箱盖。barrel、crate、crate-bottles 和 tool-paddle 构成收货与储放区；fish、mussel-open、cutting-board、cooking-knife-chopping 与 bowl 构成切台和秤盘。目录亦保留筛选时导入但未置入成品的备选件。

harbor.gdshader 在原始 UV 色卡上按木、填充、屋顶和货箱角色重映色值，再以世界坐标加入低对比的表面变化。yard.gdshader 用交错石缝和石色变化处理原有陆地。final 使用各自的 _final 版本，降低木色与路面亮度。门牌鱼印、秤盘刻度、landing_net.obj 和 rope_coil.obj 为本局部原创；箱体包边、秤座、门框、灯罩和安装件用场景内可编辑网格补齐。
