# Records Annex — Control 环境美术小样

独立空项目制作，Godot **4.7.2 / Metal / Forward+**。研究 `Control` Steam 截图 `control-3`（黄色 SHELTER 门厅）与 `control-4`（档案柜与荧光灯）。参考图仅用于研究，没有成为贴图或交付素材。

## 打开与查看

1. 用 Godot 4.7.2 导入本目录 `project.godot`，等待素材导入。
2. 打开 `main.tscn`。主体、灯光、标牌、摄像机都是已保存的原生节点；桌椅/隔断/柜/道具为导入模型的实例。
3. **F5 默认显示 overall 固定相机并保持运行**。`main.tscn` 没有挂载运行时生成或自动退出脚本。窗口关闭或编辑器 F8 停止。
4. 场景树有 `overall`、`detail`、`transition` 三个 Camera3D。编辑器选择相机并 Preview 可查看相同画面；没有控制器、UI 或交互系统。

## 图像证据

- `captures/round-01/{overall,detail,transition}.png`：首次真实 Godot 图；保留失败的密集板材墙、柜背面、过暗与边界问题。
- `captures/round-02/{overall,detail,transition}.png`：按 root 逐图反馈修改的冻结版；三机位位置/FOV相同。
- `captures/round-01/main_before.tscn`、`build_before.gd`：首轮场景/装配快照。旧板材纹理保留以支持复现。

可选重新截图（会在指定目录生成三张图，结束截图进程；不影响 F5 正常运行）：

```sh
/Applications/Godot.app/Contents/MacOS/Godot --path /absolute/path/to/control --rendering-method forward_plus --rendering-driver metal -s res://capture.gd -- round=review-copy
```

可选重建：`Godot --headless --path /absolute/path/to/control -s res://build.gd` 会覆盖 `main.tscn`，手工编辑后不要无意运行。

## 来源与边界

`asset_manifest.json` 记录实际文件、作者、许可、下载来源、修改与免费范围；`candidate_notes.md` 记录候选及取舍；`licenses/` 保存随包许可与 CC0 来源记录。全部使用素材均为这次新检索下载，未复制旧项目场景、生成器或素材。

主家具使用实际下载的 CC0 模型。未找到并验证合适的混凝土室内模块包，因此结构壳、门框、荧光灯支架、栏杆和小型办公适配件为自制缺口补件；不声称建筑主体完成了素材优先。3TD DAE 经格式转换成为 GLB，原源文件以 `.dae.source` 留存；没有执行下载包内脚本。

本小样是可审阅的美术试验，**未通过用户美术验收，也不等同于 Control 品质**。陈设密度、柜/箱排列、材质重复和部分简化道具仍有限制，详见 `art_notes.md`。

复制/提交时保留源素材、`.uid`、源旁 `.import`、native 场景、许可和两轮截图；排除 `.godot/`、临时日志与外部下载zip。本目录未创建 Git 提交。
