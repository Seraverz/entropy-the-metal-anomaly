extends Control

func _ready() -> void:
	$VBoxContainer/BtnResume.pressed.connect(_on_resume_pressed)
	$VBoxContainer/BtnSettings.pressed.connect(_on_settings_pressed)
	$VBoxContainer/BtnQuit.pressed.connect(_on_quit_pressed)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		SceneManager.toggle_pause()

func _on_resume_pressed() -> void:
	SceneManager.toggle_pause()

func _on_settings_pressed() -> void:
	SceneManager.load_menu(SceneManager.SETTINGS_MENU_PATH)

func _on_quit_pressed() -> void:
	SceneManager.toggle_pause()
	SceneManager.unload_level()
	SceneManager.load_menu(SceneManager.MAIN_MENU_PATH)
