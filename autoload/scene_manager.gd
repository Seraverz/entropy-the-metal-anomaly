extends Node

var world_root: Node2D
var ui_root: CanvasLayer

var current_level: Node = null
var current_menu: Node = null
var is_game_paused: bool = false

const MAIN_MENU_PATH = "res://scenes/ui/menus/MainMenu/MainMenu.tscn"
const PAUSE_MENU_PATH = "res://scenes/ui/menus/PauseMenu/PauseMenu.tscn"
const SETTINGS_MENU_PATH = "res://scenes/ui/menus/SettingsMenu/SettingsMenu.tscn"
const LEVEL_1_PATH = "res://scenes/levels/Level1.tscn"
const LEVEL_2_PATH = "res://scenes/levels/Level2.tscn"
const HUD_PATH = "res://scenes/ui/PlayerHUD/PlayerHUD.tscn"

func _ready() -> void:
	var main = get_tree().root.get_node("Main")
	if main:
		world_root = main.get_node("WorldRoot")
		ui_root = main.get_node("UiRoot")
		
		load_menu(MAIN_MENU_PATH)

func load_level(level_path: String) -> void:
	unload_menu()
	unload_level()
	
	var level_res = load(level_path)
	if level_res:
		current_level = level_res.instantiate()
		world_root.add_child(current_level)
		
		load_hud()
		
		get_tree().paused = false
		is_game_paused = false

func unload_level() -> void:
	if current_level:
		current_level.queue_free()
		current_level = null
	unload_hud()

func load_menu(menu_path: String) -> void:
	unload_menu()
	
	var menu_res = load(menu_path)
	if menu_res:
		current_menu = menu_res.instantiate()
		ui_root.add_child(current_menu)

func unload_menu() -> void:
	if current_menu:
		current_menu.queue_free()
		current_menu = null

func load_hud() -> void:
	if not ui_root.has_node("PlayerHUD"):
		var hud = load(HUD_PATH).instantiate()
		hud.name = "PlayerHUD"
		ui_root.add_child(hud)

func unload_hud() -> void:
	if ui_root.has_node("PlayerHUD"):
		ui_root.get_node("PlayerHUD").queue_free()

func toggle_pause() -> void:
	if not current_level: return
	
	is_game_paused = !is_game_paused
	get_tree().paused = is_game_paused
	
	if is_game_paused:
		var pause_menu = load(PAUSE_MENU_PATH).instantiate()
		ui_root.add_child(pause_menu)
		current_menu = pause_menu
	else:
		unload_menu()
