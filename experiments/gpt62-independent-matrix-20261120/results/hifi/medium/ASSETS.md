# 素材与改造

Kenney 的 Space Station Kit 1.0 提供完整免费包。下载包内包含 OBJ/MTL、FBX、GLB、调色板、预览和 License.txt。本作取 OBJ 与原 colormap，统一 MTL 路径；原作者 CC0 许可随 art/kit/License.txt 保留，允许修改、商用和再分发。[作者页面](https://kenney.nl/assets/space-station-kit) · [作者发布的下载包](https://opengameart.org/sites/default/files/kenney_space-station-kit.zip)

A 小样在整段右壁重复 wall-pillar，B 用 wall 搭配端部柱。固定工位用 table-large、computer-wide、chair-armrest、container-flat-open 和 container-tall，地板为 floor 与 floor-panel-straight。检查过 OBJ 顶点范围与轴向：墙宽高各 1 原单位，台高 0.4，终端高 0.5。以各自底点安放，桌面升至 0.84 米。原 UV 采样色表，enamel.gdshader 将明暗分区映射至漆色、保留暖色槽位，在斜面叠距离过滤排线。

A 的粗柱在 props 图里分割桌面背景，B 的横向留白更能放下一块完整流程图。选 B，在操作区两端局部使用竖构件。小样的橙色屏幕缺少内容，门框、墙顶、地面开孔和箱体支撑留到首轮补齐。样图保存于 captures/sample-a 和 captures/sample-b。

首轮另用 pipe-ring-colored、wall-switch 和 wall-detail。自制钢板、门框安全斜纹、读数屏、设备铭牌与说明图均在 art/print，可单独替换。印刷字形来自 Barlow Condensed（Jeremy Tribby 等，SIL OFL 1.1），使用 Black Italic 与 SemiBold 栅格化到图中，许可副本随图保留。[字体来源](https://github.com/google/fonts/tree/main/ofl/barlowcondensed)

最终用包内 pipe-bend 与管箍组成落管，配自制压力表盘、接触座、电池压条、测试线、墙边防撞管和远处卷帘。原料周转筒与桌椅仍是 Kenney 网格。art/final/enamel.gdshader 的 paint、trim、grain 控制面漆、附件色和排线；contours.gdshader 的 line_opacity 控制局部轮廓强度。场景本身包含可编辑的管件、仪表、测试件、网格实例和灯光节点。
