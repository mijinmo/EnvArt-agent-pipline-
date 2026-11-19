# GPT-6.2：从白盒独立制作比较

2026-11-20 用户授权重跑现有四游戏 × 四档 effort：**Control、Sable、Hi-Fi RUSH、DREDGE × low、medium、high、xhigh**，模型统一为 `gpt-6.2-astra`。正式结果尚在制作，不沿用旧成品，不把先行 Control 单组验证计入排名。

## 固定与变量

- 每个游戏的四组使用相同的白盒、局部范围、三机位、1280×800 分辨率、Godot 4.7.2 Metal Forward+、skill 快照和冻结参考。每组独立找素材，不提供固定素材池。
- 每组完成素材小样、首轮场景和一次自主美术修订。首轮三张图必须实际查看；首轮资源和截图冻结。技术修复单列，不追加组间美术反馈。
- 唯一计划改变的模型参数是 effort。每档只有一次样本，结果用于本次局部的方案筛选，不能证明某档普遍最优。

## 隔离与审阅

每组使用随机临时目录、新 Git 历史、新 CLI 上下文、独立临时/下载/引擎缓存。制作进程禁止读取宿主成果、其他组目录和聊天历史；协调者收集后才进入本目录。CLI 的 shell 文件权限与 Godot 专用渲染进程分别施加文件边界；渲染排队只交换本组的场景路径和完成状态，不传播别组内容。图片工具的路径行为不能仅凭 shell 预检推断，最终另查实际调用记录。

先按随机标签审阅全部固定机位，分别评价参考贴合、内部统一、素材适配、功能/叙事细节、光影/空间层次，再揭示 effort 和用量。token 不等于金额，含排队/审批的总耗时不作为速度排名。用户美术验收与代理评审分开。

计划交付：16 个可编辑工程、白盒/首轮/最终同机位实图、素材来源和许可、匿名评审与隔离记录、按游戏和能力类别筛选的 HTML。进度与产物以实际保存的清单为准。

[HTML 分类与同机位对比](../../docs/gpt62-independent-matrix.html) · [输入与运行清单](run-manifest.json) · [隔离预检](ISOLATION.md)。四游戏参考共 11 张已实际查看并冻结，只归档来源与哈希，私有参考原图不再分发。每个游戏四组归一化输入哈希一致；唯一归一化字段是用于分离 Godot 用户缓存的 config/name。

## 打开与重新拍图

收集后的工程在 `results/<游戏>/<effort>/project.godot`，用 Godot 4.7.2 标准版导入，F5 打开 final.tscn。源场景与资产不依赖当时临时目录。first.tscn 和原白盒均保留；控制方式见各工程 README。

各工程内的 render.py 是当次隔离试跑的队列客户端，收集后不会自动启动协调服务。普通本机复看可直接调用已安装的 Godot：

```sh
# 在要复看的单个结果工程目录内执行，输出使用未存在的新目录。
godot --headless --path . --editor --import --quit
godot --path . --rendering-driver metal --audio-driver Dummy \
  --script res://capture.gd -- final.tscn /absolute/path/to/new-evidence
```

Windows/Linux 换用对应图形后端；跨平台画面尚未验证。不要重跑 builder 覆盖保存场景，不要覆盖现有首轮/终图。`.work/frozen-references` 是当时私有参考缓存，未归档；公开来源、准确图片 URL 与哈希保存在 REFERENCES.md / references.json。
