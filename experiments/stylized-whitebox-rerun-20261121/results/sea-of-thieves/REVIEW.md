# 三机位自查

交付场景为 draft.tscn，最终证据位于 captures/final。各组三图均由 python3 render.py 重新加载保存的场景，使用 Godot 4.7.2 Metal Forward+ 和冻结的 1280 × 800 机位输出。下表各行按整体、门洞近景、坡道过渡排列。

| 阶段 | 整体 | 近景 | 过渡 |
| --- | --- | --- | --- |
| 原白盒 | [原图](captures/whitebox/overall.png) | [原图](captures/whitebox/close.png) | [原图](captures/whitebox/transition.png) |
| 素材小样 | [小样](captures/audition/overall.png) | [小样](captures/audition/close.png) | [小样](captures/audition/transition.png) |
| 可编辑初稿 | [初稿](captures/draft/overall.png) | [初稿](captures/draft/close.png) | [初稿](captures/draft/transition.png) |
| 主要缺陷修复 | [复拍](captures/reviewed/overall.png) | [复拍](captures/reviewed/close.png) | [复拍](captures/reviewed/transition.png) |
| 交付稿 | [整体](captures/final/overall.png) | [近景](captures/final/close.png) | [过渡](captures/final/transition.png) |

**整体。** 初稿的白亮箱框和近白地面把目光引到三个跳台。复拍中压暗了箱框，石地恢复可辨的铺砌方向；右折墙上的红色货区旗标出工作侧。门廊连到后方短棚，灯从木梁下悬挂。外围网格与后墙端部仍很醒目，高机位可以辨认制作边界。

**门洞。** 初稿的招牌文字被拱石遮挡，门柱表面有宽黑缝，灯芯高光吞掉了灯罩结构。修复稿把牌匾固定在拱顶上，五层柱石与拱券接合，灯的金属棱、上下罩与吊耳可辨。两侧仓储箱留有完整上表面，右侧桶端区分封存与取样位置。最终近景还能看到门槛的木石交接，以及右柱钥匙的金属挂点。

**坡道过渡。** 从冻结机位能看见坡脚、连续铺板、平台和门槛之间的地面。吊具在平台西侧，斜撑位于坡面以下。初稿缺少清晰铺缝，修复后石板尺度给出从坡脚到门洞的距离感。门与工作区的短棚仍留出了可视通路。

**结构与物理。** 原包 verify_whitebox.gd 对交付场景返回 17 个白盒体、passed=true、errors=[]。另以原玩家胶囊（半径 0.3 m，高 1.8 m）沿中心线从门两侧分别扫过。坡面的两个采样点、平台、四级台阶和三个跳台共十个落点的射线支撑高度与原尺寸一致。上述检查验证静态净空与承托高度。原白盒 SHA-256 与清单一致，冻结的控制器、相机书签和截图脚本沿用原文件。

**保留不足。** 与原作地窖相比，门柱和木面仍较规整，桶架上的木桶轮廓重复；参考里的深色顶棚包围感更强。当前以切开的门廊、后棚和灯下分装区表达室内关系。手绘鲸标、BRINE CELLAR 店牌与船灯均为本次方向假设。用户审美校准状态为 **awaiting_user_calibration**，制作停在代表性局部。
