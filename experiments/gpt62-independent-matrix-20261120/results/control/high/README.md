# Sound Archive · 档案接收室 04

用 Godot 4.7.2 打开本目录的 `project.godot`，按 **F5** 进入 [final.tscn](final.tscn)。初始视角朝向门洞。**5 / 6 / 7** 分别切到门洞、工作角和桌边；**1 / 2** 切换第一、第三人称，**3** 切自由相机。WASD 与鼠标移动观察，Space 跳跃，Esc 释放鼠标。

|固定机位|首轮|最终|
|---|---|---|
|门洞与通行|[first · door](captures/first/door.png)|[final · door](captures/final/door.png)|
|收件、校验与归柜|[first · props](captures/first/props.png)|[final · props](captures/final/props.png)|
|桌面和交接窗|[first · close](captures/first/close.png)|[final · close](captures/final/close.png)|

场景保留 `BaseLab` 和原控制器。编辑 `Art` 下的建筑、门口、灯具、办公家具、单据及收发窗可分别调整各部分；外部 glTF 的原始子网格、纹理及导入设置随包保留。原门洞净宽 1.2 m、净高 2.3 m，三个跳台表面用作平图柜。最终给桌、架、车、凳加了独立碰撞。坡道、台阶及局部以外的试玩空间延续白盒。

## 制作与复看

1. 按三张冻结图确定建筑、照明和工作流程。[参考研究](RESEARCH.md)
2. 在同一工作角对照 [木模混凝土](sample_a.tscn) 与 [预制板](sample_b.tscn)。每组有三个实拍机位。[素材、许可与选择](ASSETS.md)
3. [first.tscn](first.tscn) 保存首轮。最终只进行一次美术修订，随后单独处理柜顶、门套的共面问题。拍摄采用本组 `python3 render.py` 与 Metal Forward+，三机位均为 1280 × 800。[逐图诊断与技术记录](REVIEW.md)

终图中卷盘、通联设备和纸面可分别辨认。门洞外左侧仍空，墙顶明暗分界偏硬，架上文件夹的厚度和切边略整齐。