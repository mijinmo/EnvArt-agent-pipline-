# 素材和适配

Kenney 的旧版 OBJ 免费包提供了本项目用到的几何与原始材质分区。直接下载页在本机返回 HTTP 403，改从公开的 Kenney 素材镜像逐文件取得 OBJ、同名 MTL 和包内 License.txt。以下范围按镜像里实际列出的 OBJ 计算。模型使用 CC0，可商用、修改并随工程再分发。各包原许可保存在 [licenses](licenses/)。

| 免费包 | 实际范围与选择 | 落地文件 |
| --- | --- | --- |
| [Fantasy Town Kit](https://kenney.nl/assets/fantasy-town-kit)，[取得的 1.0 包](https://github.com/ETdoFresh/kenney.nl/tree/master/fantasy-town-kit-1.0) | 包含灰泥/木质墙、窗板、木柱、坡屋顶、栈板、摊桌和凳。使用 wall、wallDetailHorizontal、wallWindowShutters、wallWindowSmall、wallWood、wallWoodWindowShutters、roof、roofGable、pillarWood、planks、stall、stallStool、lantern、rockWide、rockLarge。 | [art/models](art/models/) 中同名墙体与屋顶；planks 分成 deck 和 teal_lining，stall 改为 gutting_table，stallStool 改为 low_stool，lantern 改为 beacon。 |
| [Food Kit](https://kenney.nl/assets/food-kit)，[取得的 1.2 包](https://github.com/ETdoFresh/kenney.nl/tree/master/foodKit_v1.2) | 独立模型中有整鱼、鱼骨、木桶、切板、刀及碗。选 fish、fishBones、barrel、cuttingBoardJapanese、cookingKnifeChopping、bowl。 | herring、fish_frame、herring_barrel、fillet_board、chopper、enamel_bowl。 |
| [Pirate Kit](https://kenney.nl/assets/pirate-kit)，[取得的 1.1 包](https://github.com/ETdoFresh/kenney.nl/tree/master/kenney_piratekit_1.1) | 该版包含小艇、桨及瓶。选 paddle 和 bottle。 | oar、oil_bottle。 |

### 模型检查

原始墙片高 1 单位，沿 Z 延伸，原点偏至 X=0.4..0.5。摊桌约 0.65 × 0.366 × 1，鱼约 0.20 × 0.32 × 0.62。木桶自带向外的端面和龙头，适合靠墙当盐水桶。逐模型读实际顶点计算底部中心，保留法线与分材质面，转换成可单独替换的 GLB。鱼侧放后重算支承面。墙、地板与台面根据面向和板长重新投影 UV。原 MTL 给的是色块，无 PBR 贴图。新增两张可重复的低对比木纹、灰泥笔触，木板和桶板用顶点色略作明度区分。金属环、刀面、漆木与鱼身分别设定粗糙度；灯玻璃另有自发光。

### 实际小样选择

两个小样使用相同固定机位、日光、桌高、鱼、刀、碗和木桶。A 的五跨灰泥墙把深木柱和浅鱼身分开，靠墙桌清楚；檐口尚未加上时灰泥受光面偏亮。[小样 A](captures/sample-a-lime/props.png)

B 的墙板、地板和台面在中景连成同一片褐色，近看窗框旁重复出现相似的木结。采用 A 作主墙，将木板集中用于地面、护墙和操作家具。回墙局部被白盒墙面盖住，正式制作时把回墙饰面移动到碰撞面外侧并收好顶沿。[小样 B](captures/sample-b/props.png)

### 本组制作

秤壳、悬臂、秤盘吊索、照明支架与门柱五金按白盒尺度搭建。渔网、绳盘和木浮子是本组构造的网格。原绘海鸟徽记、鲱鱼图谱、秤面、登岸记录牌、码头水尺和箱印在 [art/marks](art/marks/) 内。招牌使用 Jeremy Tribby 的 Barlow Condensed Bold 制字，工程交付栅格化标识，保留 [SIL OFL](licenses/BarlowCondensed-OFL.txt)。[字体来源](https://github.com/google/fonts/tree/main/ofl/barlowcondensed)

天际线与云层为本组绘制的经纬天空纹理。外海水面位于原地面之外。冻结的游戏图只用于观察。

### Final 专属适配

免费包快照中 Fantasy Town 有 153 个 OBJ，Food 有 200 个，Pirate 有 30 个。交付的是表中选定模型的 GLB 适配件。下载时按需取单个文件，未使用的候选仅在本地筛选。

[终轮资源](art/final/) 单独保存了重新定向木纹的 deck、重配色的摊桌与屋顶、沿身体投影鱼皮纹样的 herring，以及改用显式材质分区的绳盘、渔网、木浮子。lifebuoy 和 bench_cloth 为本组制作。鱼皮、天空为本组绘制。招牌与表面图另存一份开启 mipmap，首轮仍引用原导入设置。地漏、装筐、挂架、仓库饰面和灯具参数可在 final.tscn 中直接编辑。
