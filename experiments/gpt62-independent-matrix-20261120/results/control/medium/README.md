# 胶片档案交接室 · 04

用 Godot 4.7.2 打开本目录的 project.godot，等待首次资源导入，按 **F5** 进入 final.tscn。门牌朝向来访者；穿过门洞后，右墙沿线依次可见卷宗架、胶片检查台和缩微胶片索引柜。

**操作**　5 / 6 / 7 分别切换门洞、工作角、台面近景。1 / 2 进入第一或第三人称，3 为自由相机。WASD 与鼠标移动和观察，Space 跳跃，Esc 释放鼠标。

**编辑**　场景树中的 Art 包含建筑覆面、印刷面、灯具及可单独移动的道具实例。BaseLab 使用原控制器和原碰撞，局部材质覆盖保存在各版场景。地面沿用连续白盒网格，其饰面延续到局部之外；远处测试区保留原布局。

|阶段|可打开的场景或图像|
|---|---|
|参考方向|[冻结参考说明](REFERENCES.md) · [观察和假设](RESEARCH.md)|
|整墙材质小样|sample_a.tscn、sample_b.tscn · [纵缝墙](captures/sample-a/props.png) · [横层墙](captures/sample-b/props.png)|
|first|first.tscn · [门洞](captures/first/door.png) · [工作角](captures/first/props.png) · [近景](captures/first/close.png)|
|final|final.tscn · [门洞](captures/final/door.png) · [工作角](captures/final/props.png) · [近景](captures/final/close.png)|

渲染使用 Godot 4.7.2、Metal Forward+、1280×800。两轮均重开保存的场景，经 python3 render.py 取得原始视口画面。近景中纸件小字有锯齿，柜面标签重复；工作角机位右缘还能看见局部与测试空间的交界。详见 [看图记录](REVIEW.md) 和 [素材清单](ASSETS.md)。
