class_name EABackdropConfig
extends Resource
## Offline generator input. Rebuild to apply; no per-frame generation.
@export var seed_value: int = 81421
@export_range(180,320,10) var terrain_extent: float = 220.0
@export_range(2,8,1) var terrain_grid_step: float = 4.0
@export_range(0,900,25) var tree_count: int = 460
@export_range(0.5,1.6,0.05) var hill_height_scale: float = 1.0
@export var near_grass: Color = Color("647249")
@export var far_grass: Color = Color("6b8590")
@export var rock_color: Color = Color("87908a")
