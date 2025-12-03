extends Control

func _ready() -> void:
	$VBoxContainer/BtnQuit.pressed.connect(_on_main_menu_pressed)

func _on_main_menu_pressed() -> void:
	SceneManager.unload_level()
	SceneManager.load_menu(SceneManager.MAIN_MENU_PATH)
