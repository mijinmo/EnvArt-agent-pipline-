# 塘鹅湾鱼货交易所

用 Godot **4.7.2** 打开本目录的 [project.godot](project.godot)，按 **F5** 进入 [final.tscn](final.tscn)。启动视角面向交易所门架。向右穿过木板地，可看到檐下依次布置的盐水桶、剖洗台、吊秤和补网架。

| 按键 | 操作 |
| --- | --- |
| 5 / 6 / 7 | 门洞全景 / 工作角 / 台面近景 |
| 1 / 2 | 第一 / 第三人称 |
| 3 | 自由相机 |
| WASD、鼠标 | 移动、环视 |
| Space | 玩家跳跃 |
| Esc、单击 | 释放、重新捕获鼠标 |

## 两轮实图

| 机位 | First | Final |
| --- | --- | --- |
| 门洞 | [首轮门架](captures/first/door.png) | [终轮门架](captures/final/door.png) |
| 工作角 | [首轮收货棚](captures/first/props.png) | [终轮收货棚](captures/final/props.png) |
| 近看 | [首轮工作台](captures/first/close.png) | [终轮工作台](captures/final/close.png) |

两轮均从保存的场景重开，以 Godot Metal Forward+ 和同一组机位拍摄，尺寸为 1280 × 800。每轮的三个机位均已看图复核。

## 制作阶段与编辑

1. [参考与方向](RESEARCH.md) 记录三张冻结图中分别采用的建筑、灯具和操作台依据。
2. [灰泥小样](sample_a.tscn) 与 [木墙小样](sample_b.tscn) 使用相同的全墙尺度和桌上道具。素材来源、许可及选择理由见 [ASSETS.md](ASSETS.md)。
3. [first.tscn](first.tscn) 保存第一次完整装配，包含门架、货台、檐棚与称重工位。
4. [final.tscn](final.tscn) 保存一次自主修订后的局部。打开场景树的 Art，可按 FishExchangeGate、ShedJoinery、FilletingBench、SpringBalance、NetMending 和 CatchHandling 分区编辑。修改过的网格、贴图及其导入设置单独存放在 [art/final](art/final/)。

BaseLab 实例提供原始白盒与控制器。美术节点负责外观，原有门洞、坡道、台阶和跳台的物理形状继续承担通行。原地面是陆地，外海与天空构成远景。局部以外的出生区和训练场继续沿用白盒布局。

终图中，檐下的灯与秤已经能分开阅读。门前木板的间隙在斜视时偏宽，秤盘与登记牌的小字在中景偏软，右墙外仍可看出原平台的直边。逐机位判断和技术记录见 [REVIEW.md](REVIEW.md)。
