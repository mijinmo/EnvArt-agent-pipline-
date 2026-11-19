# Control · 档案交接室 A

用 Godot 4.7.2 打开本目录的 `project.godot`，F5 启动最终场景。编辑器中可分别打开 [第一轮](pass01.tscn) 和 [最终版](final.tscn)，在 RegistryDressing 下编辑空间陈设。装箱手推车有独立的[可编辑子场景](final_art/hand_truck.tscn)。

| 固定机位 | 共同起点 | 第一轮 | 最终版 |
| --- | --- | --- | --- |
| 整体 | [room](evidence/start_overall.png) | [room](evidence/pass01_overall.png) | [room](evidence/final_overall.png) |
| 近景 | [props](evidence/start_detail.png) | [props](evidence/pass01_detail.png) | [props](evidence/final_detail.png) |
| 入口 | [door](evidence/start_transition.png) | [door](evidence/pass01_transition.png) | [door](evidence/final_transition.png) |

## 参考与起点

主图右侧橙褐档案箱按层堆在钢架上，蓝色搬运设备从货架边凸出。左侧桌椅颜色较沉，海报的人手和大字在混凝土上形成识别点。地坪能读出碎粒、伸缩缝、光泽与阴影。辅助图门侧木纹、薄金属分隔与小型方向牌构成同一入口，红毯提示公共区边界。原图见[共同输入](../INPUT.md)。起点三个机位已有白桌、灯、档案柜、目录和天窗。独架的中部留白、褐色椅子与地上单箱之间缺少搬运状态。入口近处灰墙、灰地和远处木目录的关系较弱。

## 两轮制作与读图

第一轮沿用扫描材质与原工作桌，在后墙拼入第二个实际钢架。每层箱量和分类码随待处理状态变化，给箱端、排班板和交接海报分别绘制印刷面。混凝土按世界坐标混合两种尺度的扫描并加入浇筑接缝与拉杆孔。磨石地坪加入稀疏分缝和较窄的镜面反应。入口门垛安装贴面与压边。实拍显示新增的箱列和印刷品从 room 就能分辨；props 中柜体缺少层次，右下的破箱孤立；door 中地毯露出短边，木纹偏灰。

第二轮用保留源纹理的深色座面、灰蓝柜漆、抽屉索引和双层收件盘改善近看。手推车将原散落箱改为待派出件，独立子场景含连续弯管、把套、两轮轮毂、横撑、承重底板与设备铭牌。入口延长红毯，补门槛收口和贴面压顶，门边与远处目录使用相同的胡桃色胶合板处理。对照三个 final 机位，钢架、柜、登记和派出形成从后墙到桌边的顺序，手推车轮廓在两种室内距离都可区分。门外红地与门内蓝灰磨石的交接清楚。

整体图下缘仍有偏圆、偏亮的灯光反射。近景右侧车架较新，柜门折边细节较弱；架上多件纸箱的外形雷同。过渡图两侧仍可见白盒遮挡物，原作的整面玻璃隔断和纵深不在当前局部。仅检查静止机位，未评价移动中的反射或远处文字。

## 素材与可调参数

- 钢架为 James Ray Cock 的 Steel Frame Shelves 01，按 0.11 等比缩放；箱体为 Rahul Chaudhary 的 Cardboard Box 01，保留扫描纸板表面。座椅为 Kuutti Siitonen 的 Mid Century Lounge Chair，沿用原底色、ARM 和法线，座面整体压暗；金属办公桌、无线电、原推车及灯具保留起点资产。均使用本地已供给的 Poly Haven CC0 完整模型及所选贴图。原始来源与作者见[道具清单](provenance/asset_manifest.json)及[细节清单](provenance/detail_manifest.json)。
- 档案柜沿用 Ron Kapaun / 3TD Studios 的 Office Starter Pack 免费 CC0 柜体。车架使用本地 3TD 漆面扫描作为底层起伏。柜体与车架在 finish_enamel.gdshader 的 body 参数分别设灰蓝与汽油蓝，粗糙度由扫描调制。自绘印刷图、弯管和收件盘均为本轮制作。项目保留[原资产许可](baseline/licenses/)。
- 墙体 pour.gdshader 使用 Smooth Concrete Floor 扫描，分板间距 2.48 × 1.86 米；ground.gdshader 使用 Terrazzo Tiles，分缝间距 2.8 米，concourse 参数切换入口哑光红面。最终版 walnut.gdshader 使用 Plywood 的三个 PBR 通道，每 0.90 米调整取样偏移。上述扫描为本地 Poly Haven CC0 图集。来源见[材质清单](provenance/astra-v2/selection.md)。这些参数是基于图像的制作选择。
- 两轮分别保存重开实拍，每轮三张 1600 × 1000 PNG。渲染包装器报告两次 GPU 排队均为 0.00 秒。技术重拍 0 次；两次退出均报告 7 个纹理 RID 未释放，六张 PNG 均成功写出并已看图。无头导入不能保存用户级编辑器设置，项目内的资源导入文件均已生成。
- 两轮约束记录逐项相等，含 17 个 StaticBody3D 和三个相机；191 个冻结清单文件的 SHA-256 全部匹配。门洞维持 1.2 × 2.3 米，门槛压条与贴面只做视觉收口。第一轮提交 355cb8a，第二轮提交 1a7c14f。
