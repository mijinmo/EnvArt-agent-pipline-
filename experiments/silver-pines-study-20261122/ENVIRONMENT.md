# Silver Pines · 渡口办公室局部

状态：制作中，尚未经过用户美术验收。分支 `explore/sideview-2p5d`，起点 `f9b7888`。本任务替代此前明亮山谷驿站作为当前横版探索；旧稿完整保留。

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

## 当前交付与检查

待填：保存场景、真实机位、操作方式、必要控制器检查、已看图差距。第一阶段素材试听图：`captures/audition/audition.png`，明亮照明用于看清模型；不代表目标天气与配色。
