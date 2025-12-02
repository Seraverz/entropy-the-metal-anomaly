extends Button

func _ready():
	self.mouse_entered.connect(_on_hover)
	self.pressed.connect(_on_click)

func _on_hover():
	AudioManager.play_sfx("hover")

func _on_click():
	AudioManager.play_sfx("click")
