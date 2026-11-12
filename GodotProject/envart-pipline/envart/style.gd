@tool
extends Node3D
## An editable, visual-only art layer. Gameplay geometry lives in BaseLab.
@export var title: String
@export var environment: Environment
@export var sun_color: Color = Color.WHITE
@export var sun_energy: float = 1.0
@export var sun_rotation: Vector3 = Vector3(-45, -30, 0)
