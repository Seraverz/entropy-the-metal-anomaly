extends CharacterBody2D
class_name BarrelKnight

@onready var stats = $Stats 

func _ready() -> void:
	add_to_group("enemies")

func apply_damage(amount: float) -> void:
	if stats.has_method("apply_damage"):
		stats.apply_damage(amount)
