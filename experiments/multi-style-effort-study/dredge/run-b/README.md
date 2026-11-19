# Grey Reach · 港边检修棚

用 Godot 4.7.2 导入本目录的 [project.godot](project.godot)，按 F5 打开最终场景。可在场景树的 Harbor、WorkshopAdditions 和 Renewal 中编辑。海图、材质、笼具和屋面位于 art 下。Final 复用已冻结的首轮资源。

| 阶段 | 可编辑场景 | 总览 | 工位细节 | 门洞过渡 |
|---|---|---|---|---|
| 共同起点 | [start](start.tscn) | [总览](evidence/start_overall.png) | [工位](evidence/start_detail.png) | [入口](evidence/start_transition.png) |
| 第一轮 | [pass01](pass01.tscn) | [总览](evidence/pass01_overall.png) | [工位](evidence/pass01_detail.png) | [入口](evidence/pass01_transition.png) |
| 自主修订 | [final](final.tscn) | [总览](evidence/final_overall.png) | [工位](evidence/final_detail.png) | [入口](evidence/final_transition.png) |

## 从参考到港棚

主参考右前港屋有深色、起伏的檐缘，灰橙墙面在木桩之间形成浅色面，后排房屋通过屋脊、桩脚和栈桥显出水上聚落的规模。辅图的海水转为蓝绿，暖光集中于低空和航灯。两图无法确认近景工具和木纹，近看区域沿用检修浮标、磨具与绘图的既有活动。参考来自 Black Salt Games 的两张实机图。[Exploring new places](https://static.wixstatic.com/media/e609d3_1398d6b764a346a69d945f263e8aec34~mv2.png) · [Lighthouse](https://static.wixstatic.com/media/e609d3_e0eb701824064407a49c0e9a0590b2cb~mv2.jpg)

主棚、外海网具棚和货箱取自已经下载的 Quaternius Medieval Village MegaKit 及 Fantasy Props MegaKit 的 Standard 免费部分。木窗、抹灰墙、屋面与山墙模块均以导入的实际尺寸组装。外海网棚以桩架支承，几座由栈板连接，外海标高保留在 −1.35 米。取用 Kenney Survival Kit 的磨轮、板料与锤具。三者均为 CC0，原许可留在 [licenses](baseline/assets/licenses)，原始来源及免费范围见 [REFERENCE](provenance/REFERENCE.md)。本轮没有下载新包。

## 第一轮

在原屋面上覆三种劈木瓦，按现存坡度设计搭接与破口。在吊机装卸处和工棚内放置有拱箍、纵向细木条和入口绳圈的渔笼。原装 Quaternius 货箱按导入包围盒适配两处跳台，原碰撞与顶高保留。为彩绘招牌统一设计了铸边、灯塔图章与字样，墙上领航图绘有岸线、浅滩等深线、测点和航路。把灯芯移回原壁灯笼罩，区分磨轮石与木架，并给浮标接上吊眼。

保存后重开并检查三图。总览能读出两组远屋和参差檐口，但受光屋面饱和，首排瓦遮了工棚招牌上沿。工位的木台、窗棂和桶身陷入相近的红褐阴影。入口救生圈丢失浅色图案，近天云层较重。首轮提交为 `043d0c9`。

## 第二轮

换用较宽的劈裂木瓦，平缓横向棱脊，单独缩短检修棚三段前檐。把远屋移到较远的两组桩架，让水线与近处墙头在总览中分开。门牌前移至柱面之外并加压边。临地墙面增加青灰色护板，空窗内侧嵌入窗扇，车旁桨架和待运笼具形成另一处作业点。工台新做的提灯有油箱、护笼、提梁和发光灯罩，台沿放游标量具。原磨轮加了轴承、摇臂和脚板。新材质区分砂岩磨面、开裂的浮标漆与干燥的舱板。受光方向转回朝向工作区，阴面由冷色环境光填充。

最终总览可以区分远屋桩脚、近处检修棚与前景箱件。近景提灯和浮标把量具夹在中间，磨轮的切面与木架有了不同明度。入口门牌完整，红白救生圈与远处挂网能分开读。相比主参考，最终画面仍较明亮，屋面带灰粉色，远屋墙面偏白，未达到傍晚港村深褐屋顶的对比。近景灯罩与浮标白漆靠近高光，鱼牌尾部仍在镜头之外。货箱标与门额字样在近景较清楚，也比原图承担了更多视觉重量。

## 材质与实机条件

- TarredBoards 的 `width_m` 及 `length_m` 采用 0.245 米板宽、3.4 米名义板长。世界坐标给板缝、钉位及颜色错缝。最终 BulkheadBoards 另以 0.134 米为护墙板宽。`dry`、`reed` 和 `wood` 三色分别控制冷色漆面、邻板色差与露木。
- SlackTide 根据固定世界坐标与 `phase = 0.36` 绘制断续鱼鳞波。浅水、深槽、天光倒影和亮线分开配色。最终 LowClouds 用两层不同尺度的薄云表现低空色带。未检查移动镜头的稳定性。
- GrindingStone 以磨轮本地轴线生成环磨痕，BuoyEnamel 的 `coat` 和 `chips` 控制浮标底色及磕碰露钢。图像、灯光和几何一起修订，两轮间没有单独测量某个 shader 的贡献。
- 实际制作两轮，使用仓库 godot-envart 技能与同版安装副本。两轮均从磁盘重开场景，以 Metal Forward+ 通过统一捕获工具写入三张 1600×1000 图，各轮 GPU 锁排队为 0.00 秒。图形捕获各执行一次，技术重拍共 0 次。预检时修正一次 TSCN 小数缺少前置零，重新执行一次模型包围盒探针以等待节点入树。沙箱下无头编辑器报告无法保存用户级编辑器设置和读取系统证书，工程资源已正常导入并经图形实机重开。
- 两轮各自的 [首轮约束](evidence/pass01_constraints.json) 与 [最终约束](evidence/final_constraints.json) 均和起点简表相同，含 17 个原白盒体与 3 个机位。冻结清单列出的 185 个输入文件逐项 SHA256 核对一致。原 32 米地面、门洞、坡道和跳台通路保留。此处记录静态画面与场景约束，未进行试玩或用户验收。
