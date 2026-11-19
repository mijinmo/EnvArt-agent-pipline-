# Sounding House · DREDGE 港边浮标修理棚

在 Godot 4.7.2 导入本目录的 project.godot，打开 harbor.tscn，按 F6 或 F5。默认是斜俯总览。展开 Harbor 可选独立屋顶、柱、工台、网、浮标、吊索与招牌；相机 Overall、Detail、Transition 同为原生可编辑节点。Whitebox 是原场景实例，surface_treatment.gd 在编辑器和运行时给可见表面加载材质。

| 版本 | 总览 | 工位细节 | 门洞过渡 |
|---|---|---|---|
| 白盒 | [总览](captures/whitebox/overall.png) | [工位](captures/whitebox/detail.png) | [门洞](captures/whitebox/transition.png) |
| 独立首轮 | [总览](captures/first/overall.png) | [工位](captures/first/detail.png) | [门洞](captures/first/transition.png) |
| 修订 | [总览](captures/final/overall.png) | [工位](captures/final/detail.png) | [门洞](captures/final/transition.png) |
| 同场基础材质 | [总览](captures/control/overall.png) | [工位](captures/control/detail.png) | [门洞](captures/control/transition.png) |

## 从白盒到码头工位

主参考是 DREDGE 官方实机图 12，取暖墙、暗屋顶、绳结、木桩和疏密变化。海峡灯塔图 1 提供冷水与暖色航灯的远近关系。镜头从斜俯总览降至门洞和工位，把浮标、卷绳、网坠、潮汐图和工具布置在可接近的位置。参考出处、真实下载包、适配和选材见 [REFERENCE.md](REFERENCE.md)。

首轮场景固定在 passes/first/harbor.tscn，保留当时的渲染脚本、木板与天空资源。首轮的檐口和橙色连成一片。修订拆分屋脊，增加浮标检修和吊装线索，重画风化青灰木色。最终建筑保持门洞、东墙与后墙局部的半开放检修棚；原 32 m 地板上没有海水。可见的海面高度为 -1.35 m。

## 材质控制与复拍

- materials/saltwood.gdshader 在源 UV 上读洗色底图。grain_relief（默认 0.42）将亮度向离散印色值拉近。band_strength（0.78）控制受光面的三段柔化分阶。用大面区分朝向，保留桶箍、绳和木板的独立底色。
- materials/tide.gdshader 用断开的波脊、定向条纹和距离衰减绘制外海。phase 固定为 0.36，可手调观察波形。所有提交图为同相位静态场景。
- materials/sky.gdshader 通过三角插值噪声产生平面化云带。天空与灯光在最终和基础材质组完全共享。control 为相同 UV、洗色底图、模型、机位、投影和灯位的 StandardMaterial3D；海面恢复相同基础蓝绿底色。屋顶、投影边缘与海面最容易看到变化。工位的主要可读性来自实际模型、配色和装配，对照近景相对接近。

在此工程目录运行下例，替换 Godot 安装路径。为保留冻结图，将新结果写入其它目录。白盒、独立首轮与控制版本分别在最后追加 --whitebox、--first、--control。

```sh
/Applications/Godot.app/Contents/MacOS/Godot --path . --resolution 1600x1000 --script capture.gd -- /tmp/sounding-house-review
```

所有交付图由保存后重开的 Godot 4.7.2、Metal 4 Forward+ 实际输出，1600×1000。源文件与共同白盒逐字节一致；核对场景内 17 个原 StaticBody3D 的变换、网格尺寸、碰撞形状尺寸与局部变换、层/掩码；首轮与最终三个机位的变换与 FOV 均相同。

## 剩余美术局限

总览里长围墙与几何跳台仍暴露原测试场形态。近景磨轮的简模棱角与刻画更细的木制品并置，顶缘裁到鱼招牌。远岸只在抬高视角可见，样板聚焦修理活动；没有复刻原作完整港村。当前为制作侧观察，等待用户美术复核。
