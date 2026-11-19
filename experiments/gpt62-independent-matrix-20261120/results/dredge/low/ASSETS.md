# 素材与试装
采用 Quaternius 的免费 CC0 模型。公开镜像 [FreeAssetsByKenneyNLandQuaternius](https://github.com/beep2bleep/FreeAssetsByKenneyNLandQuaternius/tree/HEAD/FreeModels%20by%20Quaternius%5BPatreon%5D)，作者站 [Quaternius](https://quaternius.com/)。原包许可见 assets/Updated-License.txt。CC0 允许修改、商业使用及再分发。冻结的三张 DREDGE 图仅作观察依据。

|镜像中包名 / FBX 目录|实际采用的网格|
|---|---|
|Modular Medieval Buildings - Jul 2017|WallBricks、WindowSquare；Wall 为同包候选|
|Updated Modular Dungeon - May 2019|Wall_Modular、Table_Big、Bucket、Crate、Barrel|
|Animals Pack - Oct 2016|Fish|

用 Assimp 展平 FBX 变换并转静态三角面 OBJ，底面中心归一化，长边对齐 X，实例设置米制尺寸。原木桶三材质分槽、桌板包铁、桶提手保留，MTL 统一木、铁、墙与玻璃配色。鱼按原网格高度分背、侧、腹三色。未使用法线、透明或写实纹理。实际桌比例约 330:85:158，试装为 2.42 × 0.91 × 1.04 米。

sample_a 整墙的暖色面与桌板分离清楚，墙顶有重复齿口，需以屋檐遮盖。sample_b 的灰石高反差块每隔两米复现，白盒从石块间露出，削弱了鱼台焦点。选 A，保留 B 供同机位复查。

门柱、坡檐、浮具、灯罩、台秤、刀具与仓墙连接件为本项目按白盒补制。assets/landing_emblem.svg 是自绘收鱼所标志，assets/quay_boards.gdshader 负责世界坐标木板分缝与色差。
