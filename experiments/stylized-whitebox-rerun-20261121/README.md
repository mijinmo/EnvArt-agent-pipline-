# 原白盒上的四方向重跑

2026-11-21。用户指出上一批四方向忽略原场景后，核实为协调输入错误：把原白盒替换成了单块地板。旧结果仍保留追溯，并标为输入不合规。本轮重新使用原白盒，各游戏一个 GPT-6.2 Astra / high 制作进程，独立上下文、目录及 Git 历史；没有再次开展六档矩阵。

四组已完成并归档，共63张原白盒/制作阶段图；各组17构件结构与10项必要通行检查通过。[同机位 HTML](../../docs/stylized-whitebox-rerun.html) 默认左侧显示原白盒，可切到原作参考，右侧可切素材小样、初稿、自查修复和当前交付。私人浏览入口为 <http://100.96.75.54:8081/docs/stylized-whitebox-rerun.html>，只托管报告与图片；原图字节保持。84项浏览器交互/图片检查与13项HTTP检查通过，桌面和移动布局已查看，详见[报告核验](audits/report-validation.json)。尚未声称MacBook已确认这个新页面。

三张固定机位全部来自 Godot 4.7.2 Metal Forward+，1280×800，未后期修改。结构合规与美术评价分别记录，不代表用户已经验收。

## 原白盒约束

来源是 `GodotProject/envart-pipline/demo/controller_lab.tscn`，原文件 SHA-256 为 `c22e1470f5728633a7b5df91bea6d438a3e1a441322152872a1a79da0b869123`。`tools/extract_protected_whitebox.py` 原样提取物理体、Mesh、Shape 和资源块，去除测试 UI、角色、标签与灯光，再使用已有巡检基础设施；不是重建一个近似关卡。

[输入清单](inputs/common/source/whitebox_manifest.json) 和[三视角白盒](inputs/common/captures/whitebox) 在制作前冻结。抽取白盒 SHA-256 为 `a309dc9fa677d83b490c0223b8cdb62bba718db7ef1b7b812c4a7ebe43373d26`。

- 保留32×32米地面、后墙、两段折墙、门洞三件、坡道、平台、四级台阶、三个跳台和出生垫，共17个原物理体。
- `BaseWhitebox` 必须以单位变换实例化原场景；所有原碰撞的变换、形状、尺寸、启用状态、层与掩码保持。门洞净宽1.2米、净高2.3米。
- 只对局部可见 Mesh 覆面或隐藏，并添加美术构件。门/坡/踏面周围必须保持可通行的视觉净空。巡检控制器、相机书签及截图脚本冻结。
- 本次只制作门侧、右侧道具位和左坡过渡。外围、出生区、后墙端部或未封闭顶棚仍可能显示白盒，不把局部当作全场完成。

每次正式出图前，校验冻结文件哈希，再从磁盘加载场景核对17个物理体。协调者在完成稿中复查门洞双向、坡道登顶、3个跳台与4级台阶落脚面，共10项；此检查不等同于完整游戏测试。[基线与负例检查](audits/input-guard.json)、[未装配白盒通行基线](audits/baseline-routes.json) 可追溯，检查脚本在 [verification/check_routes.gd](verification/check_routes.gd)。

## 可编辑工程

| 方向 | 工程与记录 | 当前交付图目录 |
| --- | --- | --- |
| 盗贼之海：储藏门、分装桶架、卸货通路 | [工程](results/sea-of-thieves/project.godot) · [说明](results/sea-of-thieves/README.md) · [素材](results/sea-of-thieves/ASSETS.md) | `captures/final` |
| 意航员2：校准门、仪器展件、高位设备 | [工程](results/psychonauts-2/project.godot) · [说明](results/psychonauts-2/README.md) · [素材](results/psychonauts-2/ASSETS.md) | `captures/selected` |
| 恶意不息：林地石门、修轮工作位、栈坡 | [工程](results/no-rest-for-the-wicked/project.godot) · [说明](results/no-rest-for-the-wicked/README.md) · [素材](results/no-rest-for-the-wicked/ASSETS.md) | `captures/final` |
| 原神：店铺门、檐下器物、上层通路 | [工程](results/genshin-impact/project.godot) · [说明](results/genshin-impact/README.md) · [素材](results/genshin-impact/ASSETS.md) | `captures/delivery` |

在 Godot 4.7.2 打开各自 `project.godot`，按 F5 运行 `draft.tscn`。5/6/7 是整体、门侧近景、左坡过渡；1/2 是第一/第三人称，F或3为自由观察，WASD移动，空格跳跃，Shift加速，Q/E在自由观察时下降/上升，Esc释放鼠标。原跳台出现在近景前方是冻结机位的结果，不能移动台面来美化构图。

原神的 `captures/final` 是有破面问题的树形试修，实际交付采用 `captures/delivery`；两者均保留，避免凭目录名误选。

`results/` 是制作组已提交文件的逐字节归档；阶段 Git 历史保存在本仓库 `refs/envart-whitebox-reruns/20261121/<游戏id>`。每组 `REVIEW.md` 记录其小样、初稿和自主修复。报告中的[协调者实图判断](delivery.json) 独立记录美术差距，没有把制作组自评当作用户意见。

## 复查与重新出图

归档工程里的 `render.py` 是当时的串行出图请求客户端，制作调度结束后不会单独工作。通常直接用 Godot 编辑器运行即可。若要复拍，在所选 `results/<游戏id>` 目录执行下面命令，最后一项换成尚不存在的输出目录：

```sh
/Applications/Godot.app/Contents/MacOS/Godot --headless --editor --path . --import
/Applications/Godot.app/Contents/MacOS/Godot --headless --path . --script res://verify_whitebox.gd -- draft.tscn
/Applications/Godot.app/Contents/MacOS/Godot --path . --script res://capture.gd -- draft.tscn /private/tmp/envart-new-review
```

捕获脚本拒绝覆盖已有证据目录。导入缓存 `.godot/`、下载压缩包和私有会话日志不入 Git；源旁 `.uid` / `.import` 和许可证保留。工坊的四份上游许可证含原始 CRLF或行尾空格，归档保持原字节，不为了空白检查改写许可文本。

在仓库根重新生成对比页：

```sh
python3 tools/build_stylized_pilots_report.py \
  --task experiments/stylized-whitebox-rerun-20261121 \
  --output docs/stylized-whitebox-rerun.html
```

## 隔离、MCP 与结论边界

各组仅获本组参考、原白盒及中性巡检文件；shell读取受限，渲染使用单独原生沙箱，禁用共享插件、记忆、其他代理与浏览器入口。实际模型、effort、工具调用、文件哈希、渲染结果及用量见[执行审计](audits/execution-summary.json)。路径扫描与调用检查只能说明观察到的访问，不能证明每种工具都具有硬隔离。没有做B接手实验。

远端 Godot AI MCP 配置已合并，本机固定版4.4.2已安装并完成真实游戏截图验证，见[接入证据](audits/mcp-setup.json)与[配置教程](../../docs/godot-ai-mcp.md)。当前聊天未热加载原生工具，验证使用同一配置的临时 MCP SDK 客户端。共享MCP仅供协调端检查，不向独立制作组暴露其他工程会话。因此本轮不能用于比较MCP与脚本制作的优劣。

此前原四方向错误输入的报告仍在[历史入口](../../docs/stylized-local-pilots.html)。本轮仅能比较这些具体局部的装配和美术问题，不能据此选出最优effort，或把一次结构检查通过当作管线已稳定达到原作质量。
