# 素材与小样

Poly Haven 公开素材按 CC0 1.0 提供，可用于商业项目、修改及再分发。本项目直接从对应 API 文件清单取得 1K JPG 与 glTF、二进制网格，逐项校验 MD5。许可全文保存在 assets/CC0-1.0.txt。每行链接对应 assets 下同名源目录。

|来源 / 文件夹|作者|用途与适配|
|---|---|---|
|[concrete](https://polyhaven.com/a/concrete)|Rob Tuytel|纵向模板整墙及门柱，世界坐标三向映射|
|[concrete_layers](https://polyhaven.com/a/concrete_layers)|Amal Kumar|横层混凝土对照墙|
|[floor_tiles_02](https://polyhaven.com/a/floor_tiles_02)|Rob Tuytel|地面降彩偏冷。三个表面均保留 Diffuse、Rough、nor_gl|
|[metal_office_desk](https://polyhaven.com/a/metal_office_desk)|Ulan Cabanilla|2 m 宽桌、独立活动抽屉，台面高 0.788 m|
|[drawer_cabinet](https://polyhaven.com/a/drawer_cabinet)|Ulan Cabanilla|1.88 m 高的开放架和四抽柜|
|[filmstrip_projector_8mm](https://polyhaven.com/a/filmstrip_projector_8mm)|PeterM|双卷盘机，略放大以分辨控制面板|
|[mounted_fluorescent_lights](https://polyhaven.com/a/mounted_fluorescent_lights)|Ulan Cabanilla|七款中单独取 A，另配灯芯与灯光|
|[office_notepads](https://polyhaven.com/a/office_notepads)|Ulan Cabanilla|十个变体中提取黄色拍纸簿、A4 纸堆与单页，移除目录排列偏移|
|[SchoolChair_01](https://polyhaven.com/a/SchoolChair_01)|Ethan Place|蓝色座面与金属脚工作椅|
|[clipboard](https://polyhaven.com/a/clipboard)|ProgrammerOnCoffee|收件板夹|
|[vintage_stapler](https://polyhaven.com/a/vintage_stapler)|Mateusz Sadek|台面装订单件|
|[cardboard_box_01](https://polyhaven.com/a/cardboard_box_01)|Rahul Chaudhary|收纳纸箱|

模型保留原 UV、颜色、切线空间 OpenGL 法线及打包遮蔽/粗糙/金属贴图。灯和纸件通过 glTF 场景节点选取变体，仍使用原包的网格缓冲区和贴图。未使用参考图像作贴图。

## 整墙对照

sample_a、sample_b 在同一张桌、卷盘机、木架和室内灯下比较。props 图中 A 的直缝延续门柱的竖向尺度；B 的横向水渍在柜顶以上重复为数条深带，和架板争夺水平轮廓。采用 A。A 的近景灯下孔洞偏重，生产阶段将控制亮斑，并用文件区打断整墙重复。两组原始截图在 captures/sample-a 和 captures/sample-b。

印刷品均为本项目原创排版，卷盘线路图、内部编号与章戳为虚构内容。栅格化使用 Barlow Condensed（Jeremy Tribby）与 IBM Plex Mono（IBM Corp.），字体许可见 assets/print/OFL-*.txt。

终版的胶片扁罐按分体罐身与卷边补模，索引柜按胶片分组定制。罐贴、柜标与同步钟刻度均为本项目绘制。
