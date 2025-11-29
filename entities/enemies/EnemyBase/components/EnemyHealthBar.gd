extends ProgressBar
class_name EnemyHealthBar

@onready var entity: CharacterBody2D = get_parent()
@onready var stats: EnemyStats = entity.get_node("Stats")

func _ready() -> void:
	show_percentage = false 
	
	if stats:
		stats.health_changed.connect(_on_health_changed)
		
		max_value = stats.max_hp
		value = stats.current_hp
		
		visible = false 

func _on_health_changed(current_hp: float, max_hp_val: float) -> void:
	max_value = max_hp_val
	value = current_hp
	
	if current_hp < max_hp_val:
		visible = true
	else:
		visible = false
	
	if current_hp <= 0:
		visible = false
