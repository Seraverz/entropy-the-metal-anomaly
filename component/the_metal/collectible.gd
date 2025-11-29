extends Area2D

@export var score_value: int = 10

func _ready() -> void:
	# Connect sinyal body_entered secara code (boleh juga lewat editor)
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("player"):
		return
	GameState.add_score(score_value)

	# Bisa update state lain juga di GameState, contoh:
	# GameState.collected_items += 1
	# GameState.check_level_complete()

	# Hapus item dari scene setelah di-collect
	queue_free()
