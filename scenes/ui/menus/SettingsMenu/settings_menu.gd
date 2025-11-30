extends Control

func _ready() -> void:
	$BtnBack.pressed.connect(_on_back_pressed)

func _on_back_pressed() -> void:
	if SceneManager.current_level == null:
		SceneManager.load_menu(SceneManager.MAIN_MENU_PATH)
	else:
		var pause_menu = load(SceneManager.PAUSE_MENU_PATH).instantiate()
		SceneManager.ui_root.add_child(pause_menu)
		SceneManager.current_menu = pause_menu
		queue_free()
