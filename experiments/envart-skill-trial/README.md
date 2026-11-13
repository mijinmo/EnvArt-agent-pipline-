# Emberwatch · EnvArt Skill 独立试跑

从空工程开始，根据 `godot-envart` skill 与基线参考图独立装配。只复刻灰烬堡垒方向，不包含玩家或玩法系统。

1. 用 Godot 4.7.2 导入本目录的 `project.godot`，等待首次素材导入完成。
2. 按 F5，或打开 `courtyard.tscn` 后按 F6。
3. 按 1 / 2 / 3 / 4 查看总览、入口、道具组、高差区域。

`courtyard.tscn` 可直接编辑；`build_scene.gd` 用于重建，会覆盖场景。`captures/` 保存四张最终实机图和早期迭代证据。默认 Metal Forward+；没有建立跨平台兼容性测试。

素材来源、许可与哈希见 `asset_manifest.json`、`assets/LICENSE.txt`。本次使用与灰烬参考同族的 KayKit 素材，验证独立装配和视觉迭代，不代表已经验证跨素材风格迁移或得到用户美术认可。

[图文试跑复盘](../../docs/envart-skill-trial.html) · [Skill](../../skills/godot-envart/SKILL.md)
