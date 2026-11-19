# 素材账与选型

## 许可及实际取得的文件

以下 Poly Haven 资源通过公开 files API 逐项取得，按源清单 MD5 核对。免费部分为完整列出的模型几何及 1K JPEG PBR 通道。模型目录保留 glTF、它引用的二进制网格和外部 textures；表面目录保留 color、normal 和 arm。模型的 UV 及 GL 法线沿用源文件；ARM 的 R/G/B 分别是遮蔽、粗糙度和金属度。[Poly Haven 资产许可](https://polyhaven.com/license) · [随附 CC0 1.0 全文](art/licenses/CC0-1.0.txt)

|表面及文件目录|用途与调整|源|
|---|---|---|
|wood_textured_concrete · Dimitrios Savva|木模板混凝土，全墙 1.8 m 重复；湿痕与木印在门边能近看。结构承台另用较低法线强度。|[下载页](https://polyhaven.com/a/wood_textured_concrete)|
|concrete_panels · Amal Kumar|交错齿纹预制板，6.8 m 重复，保留于 B 小样。|[下载页](https://polyhaven.com/a/concrete_panels)|
|terrazzo_tiles · Amal Kumar|2 m 重复，局部冷色调水磨石；保留粗糙度纹理。|[下载页](https://polyhaven.com/a/terrazzo_tiles)|
|linoleum_brown · Rob Tuytel|2 m 重复的暖色油毡；B 小样地面。|[下载页](https://polyhaven.com/a/linoleum_brown)|

|模型|实际内容及改造|源|
|---|---|---|
|metal_office_desk · Ulan Cabanilla|2.0 × 0.95 m 双座柜办公桌，桌面高 0.79 m。抽开左上抽屉 6.5 cm，朝操作侧放置。|[下载页](https://polyhaven.com/a/metal_office_desk)|
|metal_stool_02 · Ulan Cabanilla|圆凳、管脚与脚圈为一体，高 0.46 m；以脚底为原点放置。|[下载页](https://polyhaven.com/a/metal_stool_02)|
|boombox · Thomas Paul Mouilleron|机身、扬声器两组材质的磁带机，含伸出天线，高 0.47 m；支持面是桌面。|[下载页](https://polyhaven.com/a/boombox)|

## 小样取舍

A 与 B 共用同一光源、2 m 实物桌、凳和磁带机。重开两场景检查 door、props、close。A 中桌面轮廓明显，墙上浅斑按约一桌宽的间隔反复出现，地面颗粒在近景偏亮。B 中板齿和黑接缝强烈到足以压过小设备，远处门柱又像是截断的预制板图案。选 A 的木模印迹与水磨石组合。生产场景用局部金属护壁截断整墙重复，降低地面的高频对比，给顶灯补真实灯体。小样中的孤立光斑只用于比较。

[小样 A](captures/sample-a/close.png) · [小样 B](captures/sample-b/close.png)

## 首轮工作角所用的额外素材

|实际文件目录|作者、选用部分与适配|源|
|---|---|---|
|art/models/industrial_caged_sconce|Ulan Cabanilla。包中有三种组合灯及管件，选 A 型整灯，清除样本横向位移，以背板贴墙装在门柱与回墙。|[Industrial Caged Sconce](https://polyhaven.com/a/industrial_caged_sconce)|
|art/models/drawer_cabinet|Ulan Cabanilla。高 1.88 m 的木抽屉和开放金属架。单独抽屉节点保留，顶屉向前移 8 cm。|[Drawer Cabinet](https://polyhaven.com/a/drawer_cabinet)|
|art/models/binder_notebook|DaDrood。只装入打开的笔记本，保留牛皮封面、纸张与笔的原 UV，放在登记员右手边。|[Binder Notebook](https://polyhaven.com/a/binder_notebook)|
|art/models/cardboard_box_01|Rahul Chaudhary。带封带、压折和搬运符号的纸箱，落在台面和高搁板上。|[Cardboard Box 01](https://polyhaven.com/a/cardboard_box_01)|
|art/models/wall_clock|PierreB3D。保留钟盘、透明表盖和三根表针，用背壳中心安装。|[Wall Clock](https://polyhaven.com/a/wall_clock)|
|art/surfaces/american_walnut_veneer|Jenelle van Heerden。取 1K 彩色、GL 法线和 ARM。用在回墙柜顶、胶带机侧板与搁板。|[American Walnut Veneer](https://polyhaven.com/a/american_walnut_veneer)|

## 本组制作的部分

门框包边、顶棚、搁板、抽屉式平档柜和播放台为本场景配合白盒尺寸制作。盘带机包含独立三孔盘缘网格、带卷、导带轮、机头罩、表头和按键。在 Godot 中可以单独摆放播放机和展开放卷部件。档案夹分为封皮、纸芯和索引舌。水磨石专用材质沿世界坐标取原图，在地坪叠入 640 mm 分格；声学顶板另绘细孔纹理。

导视、卷带走向图、接收表、曲线和安全传单均为本组设计，印刷品在 art/print 中。印刷字使用 Barlow、Barlow Condensed（Jeremy Tribby）及 IBM Plex Mono（IBM）；交付为排版栅格图。OFL 文本见 art/licenses。原作参考图未用于纹理。[Barlow](https://github.com/google/fonts/tree/main/ofl/barlow) · [Barlow Condensed](https://github.com/google/fonts/tree/main/ofl/barlowcondensed) · [IBM Plex Mono](https://github.com/google/fonts/tree/main/ofl/ibmplexmono)

## Final 的独立改造

art/final 保留修订版混凝土与水磨石贴图。混凝土按原木模纹明度减去棕色偏色，保留法线与粗糙度；水磨石和印刷面独立生成 mipmaps，供远处斜视使用。wall_clock.gltf 继续引用原表盘和表针网格，单独降低透明表盖的反光。盘带机沿首轮结构增加了穿带和锁扣子场景。

立式盘盒、平放封套、接收单及示波记录是本组以同一套印刷字和编号另绘的贴图。编织安全玻璃使用本组空间材质，后侧浅龛、搁板、档案与百叶是有间距的三维部件。窗位于原有回墙厚度内，保留整墙碰撞。
