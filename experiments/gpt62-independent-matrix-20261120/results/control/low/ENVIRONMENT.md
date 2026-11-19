# Control：从白盒制作一个完整局部

从 `whitebox.tscn` 完成可编辑、可近看、可试玩的环境局部。使用本包 `skills/godot-envart/SKILL.md` 完整流程。范围：门洞及右侧墙边工作角，主要 x=-2..10、z=-10..1；相邻只补必要连续围护/地面，不扩大为全场制作。

## 空间与不可改变的输入

室内档案交接工作区。可补约 4.5 m 净高顶棚、上部围护、支撑及实际灯具；参考决定材料与照明，不能因白盒没有顶棚就当成室外。

单位米。原始几何/碰撞在 `demo/controller_lab.tscn`；所有原始 StaticBody3D / CollisionShape3D 位置、旋转、尺寸保留。门洞 x=-0.6..0.6、净高 2.3m、z≈-4 不侵占。右墙原高 3m，可以加高。坡道、台阶、跳台保持形状与通路；局部之外可继续白盒并说明。可隐藏占位 Mesh，以实际素材覆面；新增视觉也不能堵路。

`demo/`、`controllers/`、`characters/`、`whitebox.tscn`、`review.gd`、`views.json`、`capture.gd`、`render.py` 是冻结输入，不直接修改。通过新场景实例/属性覆盖与新 Art 节点制作；保留名为 BaseLab 的原白盒实例。`project.godot` 仅改最终入口及有依据的渲染设置，不改 config/name（它隔离运行缓存）、输入控制或分辨率。固定三机位 door/props/close，1280×800、Godot 4.7.2 Metal Forward+；不得改机位来隐藏问题。

## 参考、素材与两轮制作

1. 阅读 `REFERENCES.md`，实际查看 `.work/frozen-references/` 中全部冻结图，写 `RESEARCH.md`：可观察依据、视觉方向和实现假设分开。这轮参考已固定，不替换为其他作品参考；素材目录/模型图片可独立检索。
2. 独立检索、下载、检查真实建筑构件/表面和代表性叙事道具；记录实际免费包内容、源地址、作者、许可及改造，保留许可文件。主要可见建筑与 props 必须体现素材选择。不得用大面积程序方块代替检索；基本网格只补必要缺口。素材不合适就换，不以下载量证明质量。可用 Blender、专门 shader 和有依据的网格/UV/材质适配。
3. 至少对照两种合理素材/材质组合做 Godot 小样，包含全墙重复尺度及相邻代表 props；实际看图后决定，不只检查导入。
4. 保存 `first.tscn`，重开拍 `captures/first/{door,props,close}.png`，实际查看全部三图。写简短首轮诊断，自主做一次美术修订，保存 `final.tscn` 与 `captures/final/` 三图并实际查看。首轮场景/依赖/截图冻结；改共享资源前为最终复制新版本。不得悄悄替换首轮。技术修复可继续，单独记录，不增加第三轮美术润色。
5. F5 最终进入 `final.tscn`；5/6/7 固定机位，1/2 玩家，3 自由相机，WASD/鼠标、Space、Esc 延续原控制器。不要新增控制器、面板、额外回归测试。
6. 交付 README.md（打开方法、阶段、可见不足）、ASSETS.md（免费范围、实际文件/改造、许可）、RESEARCH.md、REVIEW.md（首轮诊断、修订、终图剩余问题）、可编辑场景、资产、两轮实图。保留 `.uid` / 源侧 `.import`；`.godot`、`.work`、下载 ZIP 不提交。仅依据实际图评价，不宣称用户验收。
7. 每个可独立验证阶段在本组 Git 提交：参考方向、素材小样、首轮、最终。检查暂存范围，不清理未知文件。无需向用户或协调者逐阶段索要许可，完成两轮后提交最终并停止。

## 本机工具与实际出图

Python: `/Library/Developer/CommandLineTools/usr/bin/python3`；Blender: `/Applications/Blender.app/Contents/MacOS/Blender`。本组 Godot 在 `.work/runtime/Godot.app/Contents/MacOS/Godot`。命令 shell 限制不能直接打开 Metal 窗口；用已提供的中性请求脚本，它只在本组内导入或截图，协调端串行渲染：

```sh
python3 render.py import
python3 render.py capture sample_a.tscn captures/sample-a
python3 render.py capture first.tscn captures/first
python3 render.py capture final.tscn captures/final
```

保存场景的 headless builder 可在本组直接执行，无法保存 MultiMesh 等渲染资源时报告技术问题；不要改中性 capture 脚本。每次出图用新目录，已有证据禁止覆盖。渲染返回日志在本组 `.work/render/`；队列等待不是制作速度证据。首次已提供统一白盒实图。

网络可用；若直连下载连续失败，最多有界尝试后换可靠来源。本机 HTTP 代理可用 `http://127.0.0.1:8118`（例如 curl --proxy）；不能读取任何本机代理管理界面或内部服务。公开素材访问与本组临时文件以外没有授权。

## 严格输入边界

只读写此项目及自己的 `.work`、必要安装工具和公开源。不得读取/列出上级临时目录、宿主成果、其他制作项目、聊天/会话历史、全局 Git、其他组缓存。禁止通过浏览器、插件、MCP、网络本地服务或 image 工具绕过文件限制。图像只打开本组已存的文件，公开网页用 web 搜索/抓取。禁止再派生 agent、读取/消息其他 agent 或创建新的聊天。任何限制失败都报告，不绕过。你的任务只在本包中，不要寻找更完整的旧成果。
