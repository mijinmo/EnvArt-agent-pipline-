# 素材与小样

[石桥小样](scenes/masonry_study.tscn) 与[三个原始机位](captures/study/)保存了进场前的材料判断。双拱的起拱线、铺面与低墙、桶和石锤的相对尺度适用。近看时新加铺石的亮面过匀、倒角重复，原桥侧面在阴影里石缝更好。保留双拱桥体和原 UV，正式稿收窄铺石间隙、压低浅石白度，用块面化岩纹、岸泥和落叶接住边沿。小样里的灯、梯用于尺度判断，正式稿分别需要吊点和落脚。

小样阶段将总览推进到能读清两个拱孔的距离，近景对准北端施工带，过渡机位保留南岸踏入方向。三机位参数见 `views.json`，从本小样起冻结。
## 下载与授权

双拱桥体为 Paul Wortmann 的 **Stone bridge 2**。下载公开文件 `stone_bridge_2.1.zip`，采用其中 `export_obj/stone_bridge_2_001.obj` 及 `stone_bridge_2_001_d.png / _n.png`，移除压缩包中未附的 MTL 引用，在 Godot 重接颜色及 OpenGL 法线。原贴图据 Cethiel 和 minime453 的 CC0 素材修改。桥体沿 Z 转向，桥宽调至约 3.1 米，拱腹仍为原网格。作者随包说明与 CC0 全文保存在 [licenses](licenses/)。[作者发布页](https://opengameart.org/content/stone-bridge-2) · [实际下载](https://opengameart.org/sites/default/files/stone_bridge_2.1.zip)

下表为本稿使用的 Poly Haven 免费公开文件。模型取 1K glTF、对应几何 BIN 与贴图，改装为 GLB 和外部材质图，保留模型原 UV、支点、法线与原包提供的粗糙度或 ARM 通道。少量中值滤波和降饱和用于协调扫描表面。CC0 允许修改、商用及素材再分发。[Poly Haven 素材许可](https://polyhaven.com/license) · [CC0 全文](licenses/CC0-1.0.txt)

|实际公开文件 / 作者|交付与改动|
|---|---|
|[wooden_lantern_01_1k.gltf](https://polyhaven.com/a/wooden_lantern_01)，James Ray Cock|灯笼带门及提环，玻璃加入暖色发光。|
|[wooden_bucket_01_1k.gltf](https://polyhaven.com/a/wooden_bucket_01)，James Ray Cock|桶身和活动提手保留原组件，移到施工区路肩。|
|[sledgehammer_01_1k.gltf](https://polyhaven.com/a/sledgehammer_01)，Dylan Guzman|石工区的锤头与长柄。正式稿另存 masons_maul.glb 和 maul_patina.jpg，将亮黄色握柄压为木褐，保留原有纹理。|
|[wooden_ladder_1k.gltf](https://polyhaven.com/a/wooden_ladder)，Miroslav Turura|两片式木踏梯，支在北端后部的垫石上。|
|[fern_02_1k.gltf](https://polyhaven.com/a/fern_02)，Rob Tuytel、Rico Cilliers|拆出四个独立蕨丛。将原包单独的 Alpha 遮罩合入颜色图，MASK 双面绘制。|
|[rock_moss_set_01_1k.gltf](https://polyhaven.com/a/rock_moss_set_01)，Kless Gyzen|原包六块岩石，选前四款。清除展台式排列位移，分别落于岸面及浅水；按原图集使用。|
|[tree_stump_01_1k.gltf](https://polyhaven.com/a/tree_stump_01)，Rob Tuytel|扫描伐桩，嵌入岸土旁的蕨丛。|
|[rock_boulder_dry / 1K JPG](https://polyhaven.com/a/rock_boulder_dry)，Dimitrios Savva、Rico Cilliers|取 1K JPEG Diffuse / nor_gl 两张。将岩纹投在补砌石、铺面和残柱的切面上。|
|[forest_ground_04 / 1K JPG](https://polyhaven.com/a/forest_ground_04)，Rob Tuytel、Rico Cilliers|取 1K JPEG Diffuse / nor_gl 两张。地表按高程湿化，并在路肩与裸土间调色。|

## 自制与取舍

两岸高程网格、水与河床材质、拱圈嵌石、缺角铺石、破柱、杨树枝叶、草和红褐阔叶、漂落叶、缠扎灯杆、双尾太阳旗均为本项目制作。石块、拱体、工具、树木、植被丛和两岸都可在 `draft.tscn` 中选取。材质控制位于 `materials/`，河面参数控制深水与金色反光，铺石的五种色阶和苔量分别可调。

另检索了 JamesWhite 的 512×256 单图石桥及 Pixor 的像素城镇桥。此处需要原始可读双拱和近看用的砌石表面，采用带贴图的 Wortmann 桥作为唯一实景试装候选。下载检查过 Poly Haven `tree_small_02` 的高面数文件，未交付，改用贴合主参考长树干、细黑皮纹和分层冠幅的自制树形。商店截图限本地观察，未作为成品纹理或截图背景。

自制植被、落叶、灯杆和徽旗在修复稿中使用随模型的颜色图集，以独立 UV 色块保留枝干、叶面和布纹的配色。
