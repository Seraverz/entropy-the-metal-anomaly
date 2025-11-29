extends Node
class_name PlayerStats

# ===== Movement Stats =====
@export var move_speed: float = 200.0
@export var gravity: float = 900.0
@export var jump_force: float = -450.0
@export var double_jump_force: float = -350.0
@export var glide_gravity_scale: float = 0.2
@export var roll_speed: float = 2000.0
@export var leap_speed: float = 2500.0

# ===== Animation Thresholds =====
@export var fall_threshold: float = 2000.0
@export var jump_threshold: float = -10.0
@export var run_threshold: float = 0.1
@export var landing_impact_threshold: float = 2500.0
@export var double_jump_allow_time: float = 0.5

# ===== Combat  =====
@export var max_hp: int = 100
var hp: int = max_hp

@export var attack: int = 10
@export var defense: int = 5
