# 协调端补充的技术证据

制作停止后，从本组私有 `.work/fit-check/` 补存九张小样修复前的原始 1280×800 PNG。原场景和制作文档未改；每张源文件和归档文件的 SHA256 记录在本轮 `run-audit.json` 的 `coordinator_supplemental_evidence`。

| 旧小样 | 门洞 | 工作区 | 近看 |
| --- | --- | --- | --- |
| A | [图](captures/technical/sample-a-before-fit/door.png) | [图](captures/technical/sample-a-before-fit/props.png) | [图](captures/technical/sample-a-before-fit/close.png) |
| B | [图](captures/technical/sample-b-before-fit/door.png) | [图](captures/technical/sample-b-before-fit/props.png) | [图](captures/technical/sample-b-before-fit/close.png) |
| 连续着色对照 | [图](captures/technical/sample-control-before-fit/door.png) | [图](captures/technical/sample-control-before-fit/props.png) | [图](captures/technical/sample-control-before-fit/close.png) |

这些图记录覆板穿墙和背面朝向问题；修正后的小样在 `captures/audition-a`、`audition-b`、`audition-control`。它们不加入两轮正式美术排名。终轮桌垫缩放修复的前图已由制作组保存在 `captures/technical/mat-scale`，无需额外复制。

`sample_a.tscn` 与 `sample_control.tscn` 的文本仅差一个材质引用，几何、灯光、相机相同。自定义材质同时加入墨线和排线，并使用近似 sRGB 转换；普通材质使用引擎的颜色转换。这能比较整套材质处理，不能当成仅开关描边的单因素实验。两套近景原图已由协调者查看。
