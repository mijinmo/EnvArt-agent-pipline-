# 固定机位实机自查

交付场景为 draft.tscn，选用 captures/selected。已逐张查看原白盒、素材小样、初稿和两次复拍。所有机位读取同一份 views.json，捕获使用 Godot 4.7.2 Metal Forward+。状态为 **awaiting_user_calibration**。

| 机位 | 初稿所见与处理 | 最终图所见 |
| --- | --- | --- |
| 整体 | 原错层和门可辨，后场设备挤在坡顶一处，前景木纹和细线出现杂点。分开设备，给纹理生成 mipmaps，降低木纹对比。 | 右边的折墙标出工位边界，三座跳台与四级楼梯完整可见；左侧短棚把坡道与后墙连在一起。外围网格标明制作边界。[初稿](captures/draft/overall.png) · [交付](captures/selected/overall.png) |
| 门洞近景 | 木框展盒与青绿屏幕能读出材质差别。踏面斜纹和小字在斜视下破碎，坡道上方通向空背景。减少高频纹样，调整印花过滤，沿坡外缘接上供电管、檐口与工作灯。 | 仪表指针、屏幕波形、两个展件各有轮廓；门槛与门后地面可见。前景跳台上只有齐平的踏面和印刷，展台立在跳台后侧。[初稿](captures/draft/close.png) · [交付](captures/selected/close.png) |
| 坡道过渡 | 接收碟与后墙分配器恰好同心，控制台低于平台。第一次复拍中灯罩又叠在碟面。给控制台加底座，按同一相机错开灯罩、接收碟和屏头。 | 碟面、分配器中央轮毂和右侧显像管可分别辨识；从原坡面到平台的全宽连续，门口前方的地坪仍然开放。[初稿](captures/draft/transition.png) · [第一次修复](captures/reviewed/transition.png) · [交付](captures/selected/transition.png) |

### 核验与保留

最终保存场景的捕获请求为 `97396b5c8ae34e43adecf88f4abd0ac9`。同次白盒检查返回 `{"errors":[],"passed":true,"whitebox_bodies":17}`。原白盒 SHA-256 与 source/whitebox_manifest.json 一致。结构检查覆盖实际实例的变换、碰撞尺寸、启用状态与层掩码。动线按净空、场景放置与三机位画面复核。

### 仍可见的差距

原图的显像管、展框与支架更歪斜，层层压在一起。本稿给通道与跳台留足空间之后，柜台一带更整齐，零件磨耗与线缆密度也较低。薄顶棚和两端白盒使整体保持剖开感，所交付的是可以继续编辑的局部方向稿。

### 阶段版本

- `2e1cf88` 记录白盒构件、官方工坊参考与补充实拍。
- `8719611` 保存建筑、地面、仪器组合的素材小样。[三张小样](captures/material-study)
- `972aeb0` 保存初稿及当时的全部材质和子场景。[三张初稿](captures/draft)
- `32a999f` 保存纹理过滤、坡侧短棚和工作位调整。[第一次复拍](captures/reviewed)
- 当前交付提交保存最后的灯位、接收设备位置、三机位实拍和说明。[交付图](captures/selected)
