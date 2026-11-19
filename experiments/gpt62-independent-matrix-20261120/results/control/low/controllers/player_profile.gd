class_name EAPlayerProfile
extends Resource
## Shared spatial and movement contract. Units are metres and seconds.

@export_category("Body")
@export_range(0.1, 1.0, 0.01) var radius: float = 0.3
@export_range(0.6, 3.0, 0.01) var height: float = 1.8
@export_range(0.2, 2.8, 0.01) var eye_height: float = 1.65

@export_category("Movement")
@export_range(0.1, 20.0, 0.1) var walk_speed: float = 4.5
@export_range(0.1, 30.0, 0.1) var sprint_speed: float = 7.5
@export_range(0.1, 100.0, 0.1) var acceleration: float = 24.0
@export_range(0.1, 100.0, 0.1) var air_acceleration: float = 8.0
@export_range(0.0, 5.0, 0.05) var jump_height: float = 1.2
@export_range(0.1, 50.0, 0.1) var gravity: float = 20.0
@export_range(0.0, 89.0, 1.0) var max_slope_degrees: float = 46.0
@export_range(0.0, 0.5, 0.01) var floor_snap: float = 0.2
@export_range(0.0, 0.3, 0.01) var coyote_time: float = 0.1
@export_range(0.0, 0.3, 0.01) var jump_buffer_time: float = 0.1
