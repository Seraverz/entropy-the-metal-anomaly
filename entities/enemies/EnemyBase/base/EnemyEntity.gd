extends CharacterBody2D
class_name EnemyEntity

@export var floating_text_scene: PackedScene = preload("res://component/ui/FloatingText.tscn")

@onready var stats: EnemyStats = $Stats
@onready var mover: EnemyMover = $Mover
@onready var ai: EnemyAI = $AI

func _ready() -> void:
	add_to_group("enemies")

func apply_damage(amount: float, source_pos: Vector2 = Vector2.ZERO, is_crit: bool = false, is_kb: bool = false) -> void:
	if stats:
		var damage_dealt = stats.take_damage(amount)
		_spawn_damage_text(damage_dealt, is_crit)
	
	if ai and source_pos != Vector2.ZERO and is_kb:
		ai.trigger_knockback(source_pos)
		_spawn_status_text("Knockback!", Color(0.2, 0.8, 1.0))

func _spawn_damage_text(amount: float, is_crit: bool) -> void:
	if not floating_text_scene: return
	var txt = floating_text_scene.instantiate()
	get_tree().current_scene.add_child(txt)
	
	txt.set_damage(amount, is_crit)
	
	txt.global_position = global_position + Vector2(randf_range(-10, 10), -30)

func _spawn_status_text(status: String, color: Color) -> void:
	if not floating_text_scene: return
	var txt = floating_text_scene.instantiate()
	get_tree().current_scene.add_child(txt)
	
	txt.set_status(status, color)
	
	txt.global_position = global_position + Vector2(0, -50)
