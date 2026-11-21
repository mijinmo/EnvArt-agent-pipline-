# Silver Pines · 渡口办公室局部

状态：可试玩局部初稿已完成，尚未经过用户美术验收。分支 `explore/sideview-2p5d`，起点 `f9b7888`；素材试听提交 `e3dba12`。本任务替代此前明亮山谷驿站作为当前横版探索；旧稿完整保留。

## 本次用户决定

2026-11-22 用户指定“参考游戏 silver pine”“不要强行用这个白盒”“先尝试复现一个场景”，并允许必要的简单 2D platformer player controller。确认对应 Wych Elm / Team17 的 **Silver Pines**。

- 新布局服从选定渡口办公室参考，**不套用 controller_lab 的17构件**；旧批次仍须保留原白盒的约定未改变。
- 室外横向 2.5D：立体建筑与道具、墨线人物、固定纵深的左右移动和跳跃。控制器只服务此局部试玩。
- 素材优先、完整远景/过渡、真实 Godot 出图与可编辑场景仍为要求。不重开矩阵、不重新核对 MCP。

## 主参考与画面解释

来源：[游戏官网](https://www.silverpinesgame.com/) / [Steam 官方截图](https://store.steampowered.com/app/2333000/Silver_Pines/)。已逐张查看商店前六张，选 screenshot 01 的 Ferry Office 室外场景为主参考。

精确图像：`https://shared.akamai.steamstatic.com/store_item_assets/steam/apps/2333000/3ab713a4a26d907522067941ecff9376bd5e7401/ss_3ab713a4a26d907522067941ecff9376bd5e7401.1920x1080.jpg?t=1793974979`

参考确立：低矮横向木屋、中央高山墙门廊、两翼窗格、灰绿旧木材、冷灰屋顶、暖门灯、蓝招牌；近处栏杆/电杆与电线，中景码头和围网，后景冷雾山林。黑色墨线人物与环境分属不同表现语言。屋顶、墙与地面不能靠暗部遮掉。主画面近似平视但可见地板纵深。

实现假设：不复制商业游戏模型、贴图或角色；选用 CC0 建筑模块重组，对材质做灰绿调色；原创墨线人物。雨、雾、湿地反光为环境辅助手段。忠实度须由实际图像判断，不能以“气氛接近”替代建筑比例与细节检查。

## 素材试听与决定

- Tevy 免费 CC0 模型，来源/原文件哈希/转换后哈希见 `assets.json`。实际下载包均经 SHA-256 核对。
- `red-cottage` 实际 Godot 试听：木板、窗格、屋顶与道具尺度可用，但一层半住宅轮廓与小门廊不符合参考。**不用整栋作为最终主建筑**，改用同家族真实墙/窗/门/山墙/屋顶模块拼接单层办公室。
- 两层 `village-house` 因比例不符淘汰；不使用旧中世纪套件，也不以大面积程序方块代替主要建筑。
- `wooden-jetty`、围网、长椅、电杆、交通灯、木箱、路桩为实际下载资产。招牌、中央门廊连接、栏杆及远山分层为局部补件。
- 源模型的 meshopt / Basis 压缩无法被本机 Godot/Blender直接导入。`tools/decode-assets.mjs` 解压几何与量化数据、KTX2 转 PNG，保留 UV/材质/模型；依赖 glTF Transform 4.3.0、meshoptimizer 0.25.0、sharp 0.34.5、three 0.186.1。打开交付工程不需要这些转换依赖。

## 人物生成记录

使用内置 ImageGen，透明底 3×2 六帧原创侦探图集：`project/art/investigator-sheet.png`。不是游戏截图或场景证据。已检查为1536×1024 RGBA，背景存在真实透明 alpha。

完整提示词见 `project/art/PROMPT.txt`。六帧仅满足站立/行走/跳跃局部试用，尚非完整角色动画生产管线。

同样使用内置 ImageGen 补制 `project/art/aged-clapboard.png`，完整提示词为 `project/art/CLAPBOARD-PROMPT.txt`。用于真实建筑模块原红木材区域的世界坐标贴图，保留窗、门、屋顶和构件几何。图像为材质来源，不是场景效果图；模型原板条仍有细小几何痕迹，不能声称完全重做横搭木板结构。纹理按1.8米重复，接缝、钉孔和漆面微细节在近景可见；相同磨损仍有重复。

## 当前交付与检查

- 工程：`project/project.godot`；可直接编辑的保存场景：`project/ferry_office.tscn`。建筑、道具、背景、天气与玩家分组；17份来源记录包含试听淘汰整栋和当前模块/道具/树木，不等同于17份均在最终场景使用。
- 实际 Godot 4.7.2 / macOS Metal Forward+ 出图：`captures/final/{hero,entrance,shore,structure}.png`。最终目录名表示本轮交付快照，**不表示用户美术验收**。已逐张查看当前四机位；未修图。
- `captures/draft-01` / `draft-02` 为早期正交机位；`draft-03` / `draft-04` / `final` 为相同透视机位，可用于材质与气氛修订对比。当前3D环境为透视相机、固定横向玩法平面，不是全场景像素滤镜。
- `validation/player-01/checks.json` 的9项实际输入/物理检查全部通过：落在栈道、右移、行走动画、木箱阻挡、跳跃升高0.88米、跳过后落地、锁定纵深、镜头跟随、左移与转身。同次运行的 idle / walk / jump / land 是关键帧，不是视频。
- 素材导入、保存重开和游戏渲染成功。退出时 Metal Forward+ 打印资源/RID未释放警告与错误行；正常运行及检查完成，进程退出。**该退出清理问题未定位，不能写成零错误验证**；没有为此扩大引擎回归。其他平台后端未验证。

### 观察到的进展和差距

首稿透明处理遗漏导致围网像白板、树叶卡片可见，现已修正；近景整体被雾冲灰，现把雾移到远处；玻璃原白色实心效果已改为暗窗。过强的硬阴影出现条带瑕疵，阴天主光改为无硬阴影，门灯仍有阴影，SSAO保留接触。

当前建立了参考的灰绿横木板、中央三角门廊、两翼窗格、暖灯、墨线人物与冷山林，室外前后层连续存在。**仍是较简化复现**：门窗及檐口不够精细，缺少原图的复杂装饰/旗帜和临时杂物；围网为方格而非原图菱形网；远山轮廓和雾层较平，湿地块状变化偏大，木板磨损有重复。不能称为达到原作精度。下一步先由用户看局部校准，再决定是否继续集中细化；不自动扩展关卡或矩阵。

## 打开、操作与复拍

Godot 4.7.2 导入本目录 `project/project.godot`，F5。A / D 或左 / 右方向键移动，Space 跳跃。玩法为 X/Y 平面，底层 `CharacterBody3D` 与三维道具碰撞，Z 固定为1.4；无攻击、交互或进入建筑内部功能。本轮室外范围不包含办公室内部。

```sh
godot --path experiments/silver-pines-study-20261122/project --editor
# 必须换成新的绝对输出目录；脚本拒绝覆盖已有证据。
godot --path experiments/silver-pines-study-20261122/project --rendering-driver metal \
  --script res://capture.gd -- ferry_office.tscn /absolute/path/to/new-captures
godot --path experiments/silver-pines-study-20261122/project --rendering-driver metal \
  --script res://check_player.gd -- /absolute/path/to/new-player-check
```

打开已保存场景不依赖转换器、外部模型下载、MCP或 ImageGen。`build_ferry.gd` 是本轮生成来源，**不要在手工修改场景后再次运行覆盖它**。`.godot/` 为缓存，源文件旁 `.import` / `.uid` 随Git保存。
