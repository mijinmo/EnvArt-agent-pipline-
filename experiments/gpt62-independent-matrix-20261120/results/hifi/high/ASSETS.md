# 素材与适配

两包均从作者发布的 OpenGameArt 条目取得。商品页面的全套宣传图未用于场景，项目仅带实际选中的网格及改绘图形。原包许可保存在 licenses/。

| 来源 | 取得的免费内容 | 本局部用途 |
|---|---|---|
| [Kenney · Space Station Kit 1.0](https://opengameart.org/content/space-station-kit) · [ZIP](https://opengameart.org/sites/default/files/kenney_space-station-kit.zip) | OBJ/MTL、GLB、FBX、两种配色预览与单件预览，CC0，可商用、修改、再分发 | station- 前缀。墙柱、条带墙、地板和检修盖、控制台与可更换容器 |
| [Kenney · Factory Kit 3.0](https://opengameart.org/content/factory-kit) · [ZIP](https://opengameart.org/sites/default/files/kenney_factory-kit_3.0.zip) | OBJ/MTL、GLB、FBX、色板、逐件预览，CC0 | factory- 前缀。结构墙、带接口机壳、法兰管道与阀件 |
| [Barlow Condensed · Jeremy Tribby](https://github.com/google/fonts/tree/main/ofl/barlowcondensed) | Bold TTF，SIL OFL 1.1 | 烘入原创设备印刷图，许可随包 |

## 网格检查

以 OBJ 为源。原文件用 512² 色板 UV 给面分色，本次选件使用不透明底色；选件没有独立法线或粗糙度图。读取位置、顶点法线、面与原 UV 所落色区，将钢、警示漆、深嵌件和仪表玻璃映射到独立材色。把面色、三角形坐标及折角边标记写入新 UV，保留网格与原法线。printed_steel.gdshader 据此绘制有选择的棱线，用世界尺度补排线、短擦痕及地面拼板。文件可直接作为 MeshInstance3D 的网格替换和重定材质。

Space Station 的标准墙源尺寸为 1 × 1 × 0.3，原点在底边中央。宽控制台宽 0.80、高 0.497，前伸键盘朝 +Z。Factory 主机带上接口，高 1.75；长管沿 X，源长 2。按米设置各节点的底部或接头坐标；弯管与非对称容器沿用原枢轴。

## A/B 小样

两景使用固定三视图、相同台面、容器、地板和照明。A 用 Factory 结构墙，在后方试密柱节奏。B 用 Space Station 大板加间隔壁柱。A 的低层墙面局部落在白盒墙之后，不能据此比较其真实面漆；后墙密柱在 door 图中压缩成竖条。B 的中距仍有较大的留白，适合给接口与管路留出读数背景，选 B。close 图显示两个方案都还缺管道接续，控制台大亮面需要实际读数，地盖也有原地面露出。上述项目留入制作。

## 实际交付与改绘

下载归档内逐项统计到 Space Station 的 97 个 OBJ 和 Factory 的 143 个 OBJ。实际用到的文件保留原件名，加包名前缀，见 art/meshes。

| 包 | 本组场景实际引用的源文件名（省略 .obj） |
|---|---|
| Space Station | wall、wall-pillar、wall-banner、wall-window-shutters、floor、floor-panel、computer-wide、pipe-ring、table-large、container-flat、container-flat-open、container-tall |
| Factory | structure-wall（A 小样）、machine-connection-pipe、pipe-large-valve、pipe-large-long、lever-double、cog-b、cone |

主机与可换滤筒保留原几何的轮廓和接口，换用本组的冷却漆及套箍色。原宽控制台的倾斜屏面配合实际法线安装读数图。Factory 长管作为沿墙拼接的法兰段，小阀门朝向操作侧。滤芯、接头、托座、软管、灯具、门顶补件和板面印刷是为这些模型及白盒留空补作。压力表刻度、趋势图、门牌、规程图、仓门字样、地面箭头、踏板纹和使用痕均为本组绘制。图形与原作截图分别存放，冻结参考只用于观察。

最终钢材使用面法线与抗锯齿折角着色。单独的全屏空间材质读取 Forward+ 深度与法线，在交界处落墨，并按亮度加细网点。PNG 印刷资源在最终目录独立导入，开启 mipmaps 以改善斜视下的字边。
