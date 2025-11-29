extends CharacterBody2D
class_name EnemyEntity

@export var floating_text_scene: PackedScene = preload("res://component/ui/FloatingText.tscn")

@onready var stats: EnemyStats = $Stats
@onready var mover: EnemyMover = $Mover
@onready var ai: EnemyAI = $AI

func _ready() -> void:
	add_to_group("enemies")

func apply_damage(amount: float, source_pos: Vector2 = Vector2.ZERO) -> void:
	if stats:
		var damage_dealt = stats.take_damage(amount)
		_spawn_damage_text(damage_dealt)
	if ai and source_pos != Vector2.ZERO:
		ai.trigger_knockback(source_pos)

func _spawn_damage_text(amount: float) -> void:
	if not floating_text_scene: return
	var text_instance = floating_text_scene.instantiate()
	text_instance.set_amount(amount)
	get_tree().current_scene.add_child(text_instance)
	text_instance.global_position = global_position + Vector2(randf_range(-5, 5), -25)

func apply_entropy(multiplier: float) -> void:
	if stats: stats.apply_entropy(multiplier)
	if mover: mover.apply_entropy(multiplier)
