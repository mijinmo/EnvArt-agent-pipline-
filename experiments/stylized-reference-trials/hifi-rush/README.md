# D1 · Impeller Service

Hi-Fi Rush 室内工业设备检修局部。GPT‑6.2 astra，本轮使用仓库内 2026-11-19 版 godot-envart，含 stylized-shading 指引。reasoning_effort 未显式指定，沿用父任务；未独立核实运行时的具体推理档位。

## 参考取舍

主参考为 CGWORLD 对 Tango Gameworks 背景团队的访谈中 “スタティックライト有効” 的生产走廊实机图。墙下部青绿、洋红水平带与斜杠标记 D1，深蓝桁架、红任务灯与黄色警戒边压在近景。把这种色块分工转为可换滤芯的双风机检修站。辅助参考从生产线动作截图取红黄机壳、护栏，但舍去角色和战斗 UI。两张参考版权归原权利人，此工程仅提供来源。餐厅完成图、研发部门熔岩入口与当前活动和空间不合。

- [制作团队访谈](https://cgworld.jp/article/202306-hifirush02.html)
- [主要走廊实机图](https://cgworld.jp/article/818ee60f0aedfa6eaff670b2e3567f517a8b9ccc.jpg)
- [生产机械实机图](https://cgworld.jp/article/11358812b6f69a3ef7162b4a164d34fcc25e2486.jpg)

原白盒的路面、墙、台阶、跳台与碰撞保留。工作区夹在后墙与东侧围护内；顶棚与可见任务灯建立室内。前方门洞保留原净宽与净高。三个相机分别看完整检修区、换芯台和入口。

## 打开与比对

用 Godot 4.7.2 导入本目录的 `project.godot`，按 F6 运行 `scenes/final.tscn` 或按 F5。编辑器中可直接移动 Shell、MachineRoom、Bench、Print 内的独立对象，在 Views 下切换相机。采用 macOS Metal 4 Forward+，项目不含控制器。

| 同机位原图，1600 × 1000 | 整体 | 工作台 | 入口 |
| --- | --- | --- | --- |
| 白盒 | [整体](evidence/whitebox_overall.png) | [工作台](evidence/whitebox_detail.png) | [入口](evidence/whitebox_transition.png) |
| 素材小样 | [整体](evidence/audition_overall.png) | [工作台](evidence/audition_detail.png) | [入口](evidence/audition_transition.png) |
| 首轮 | [整体](evidence/first_overall.png) | [工作台](evidence/first_detail.png) | [入口](evidence/first_transition.png) |
| 最终 | [整体](evidence/final_overall.png) | [工作台](evidence/final_detail.png) | [入口](evidence/final_transition.png) |
| 最终连续着色对照 | [整体](evidence/control_overall.png) | [工作台](evidence/control_detail.png) | [入口](evidence/control_transition.png) |

每个图组有同名场景。若要重拍，在本工程目录执行下例，末尾可换成 whitebox、audition、first、control。脚本会覆盖对应图组。默认验收直接打开已保存图片。

```sh
/Applications/Godot.app/Contents/MacOS/Godot --path . --resolution 1600x1000 --script res://capture.gd -- final
```

## 素材与适配

取自项目已有合法缓存。两包均为 Quaternius **Standard 免费子集，CC0 1.0**；后缀 service 为本次局部适配。原版缓存位于主项目 `envart/assets/quaternius_scifi` 和 `quaternius_scifi_props`。本工程包含实际使用的 glTF、二进制几何、贴图和两份原许可，独立打开即可。包内不含付费整包、示例工程或其专用 shader。

| 来源 | 选用与取舍 |
| --- | --- |
| [Modular Sci-Fi MegaKit](https://opengameart.org/content/modular-sci-fi-megakit) | 比较带厚立柱的 WallAstra 与较薄的 WallBand；厚模块在风机和任务台后挤压设备进深，后墙采用 Flat 版，东墙采用 Band。采用 TopCables、Column_Pipes、Platform_3Plates、门框、风机、灯具、夹具、立式终端、箱桶和风口。较强的真实金属反光冲淡警戒色，最终版降低地板镜面反射和明度，重设无贴图风机的两种漆色。 |
| [Sci-Fi Essentials](https://opengameart.org/content/sci-fi-essentials-kit) | 采用工作台、椅、工具柜、矮架、杯、密封小盒和筒形零件。把备件、夹具、取出的叶轮与状态屏成组放置。保留桌椅实际支撑、贴图 UV 和主要原始凹凸/粗糙度信息。 |
| 本次制作 | 机盒安装板、顶棚和受力桁架、任务灯灯罩及安全标签补足专用设备。标牌为原创栅格图形，独立面片贴在表面，旋转/缩放可编辑。图形文件不包含原游戏截图或招牌贴图。 |

检查了 glTF 的层级、顶点包围盒、局部朝向与材质槽，先用固定工作距离观察真实墙片、地面和相邻设备的小样，再完成围护、印刷标识和工作区。门框保留作者轮廓，在最终版把进入原 1.20 m × 2.30 m 门洞净空的三角形裁去，消除原素材的凸起下槛。原 17 个静态物体的变换、网格尺寸、碰撞和子节点已逐段比对。新增美术对象无碰撞。

## 自主修订与父 agent 审图

首轮由三个冻结机位暴露出白色风机和亮地板争抢视线、门口标识被遮及装饰门槛侵占净空的问题。自主修订 round02 为风机分色并加装任务灯、提高入口可读性、裁切门框、补回风标识，还将同款叶轮作为桌上的拆卸件。保留该轮完整工程快照和连续着色对照。

主 agent 看过这三张图与 CGWORLD 主参考后，指出墙面污渍、地面细法线和暗部排线削弱了大色块。第三轮只改墙地的表面响应与印刷排线。背墙污渍颜色偏差保留 22%，其他板面细噪声用保边中值过滤降低，较强切口保留更多原图。墙板法线强度从 0.48 降至 0.12，地面到 0.18。粗糙度图保留四分之一左右的局部变化，削弱地面的集中反光。排线强度从 0.17 降至 0.065，同时拉大间距。设备、灯光、布置和相机沿用 round02。

| 冻结轮次 | 整体 | 工作台 | 入口 |
| --- | --- | --- | --- |
| round02 自主修订 | [图](evidence/round02_overall.png) | [图](evidence/round02_detail.png) | [图](evidence/round02_transition.png) |
| control02 同场对照 | [图](evidence/control02_overall.png) | [图](evidence/control02_detail.png) | [图](evidence/control02_transition.png) |
| round03 父 agent 反馈后 | [图](evidence/round03_overall.png) | [图](evidence/round03_detail.png) | [图](evidence/round03_transition.png) |
| control03 同场对照 | [图](evidence/control03_overall.png) | [图](evidence/control03_detail.png) | [图](evidence/control03_transition.png) |

实机对看后选用 round03 作为 final。左侧设备背后的墙漆更连贯，工作台右边的强反光收窄，入口地板上的高亮不再盖过门内的小箭头。近景仍可看见地板拼缝、外框、锁边和局部浅色擦痕。清洁后的地板漆面更均匀，长期使用痕迹较轻。round02/control02 和 round03/control03 均有可独立打开的同名场景，final/control 指向第三轮内容。

## 印刷着色

最终选用的 `shaders/print_quiet.gdshader` 在 Forward+ 读取场景颜色、深度与法线。它把相邻像素间的深度断层和强法线转折画成深蓝墨线，适度收拢明暗过渡，只在偏暗区域叠很淡的斜排线。漫反射色、烤漆、贴图 UV、法线、显示器和灯具都来自同一套装配。对照只移除 PrintPass，几何、灯、背景、曝光、镜头、基础漆色与贴图不变。该方法是当前固定观察距离下的近似。实现参考 [Godot spatial shader 文档](https://docs.godotengine.org/en/stable/tutorials/shaders/shader_reference/spatial_shader.html)。

| 参数 | 最终值 | 调整效果 |
| --- | --- | --- |
| line_pixels | 1.80 | 以屏幕像素为单位采样轮廓邻域 |
| crease_threshold | 0.25 | 较高值让弱折线退出轮廓 |
| ink_strength | 0.84 | 墨线混合量 |
| band_strength | 0.59 | 七级近似亮度阶梯向连续结果的混合比例，较高时分层更明显 |
| shadow_hatching | 0.065 | 限制在暗部的斜排线强度 |

实机近景中，叶轮的外缘、壳体、工作台底脚和椅子边缘得到更深的分界。整体最大的风格转变来自机壳主色、层次化图形、钢桁架和警戒标记；shader 主要帮助实体压住其后方细节。地板和高处节点仍显整齐重复，两台风机的状态差异主要由工作台解释，缺少参考中更大型生产设备的层叠剪影。视线在入口边缘仍能看到原测试场的未制作区域。本轮交付仅限该局部，用户美术验收待定。
