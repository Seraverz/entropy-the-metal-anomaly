extends Node2D

func _ready() -> void:
	AudioManager.play_bgm("level_1")
	GameState.level_completed.connect(_on_level_won)

func _on_level_won() -> void:
	SceneManager.show_victory()
	GameState.level_completed.disconnect(_on_level_won)
