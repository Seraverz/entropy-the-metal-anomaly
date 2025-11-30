extends Control

@onready var health_bar: ProgressBar = $HealthBar

func _ready() -> void:
	await get_tree().process_frame
	
	var player = get_tree().get_first_node_in_group("player")
	
	if player:
		player.stats.health_changed.connect(_update_health)
		
		_update_health(player.stats.current_hp, player.stats.max_hp)
	else:
		printerr("HUD Error: Player tidak ditemukan di group 'player'!")

func _update_health(current: float, max_val: float) -> void:
	health_bar.max_value = max_val
	health_bar.value = current
