extends Node
class_name Entropy

var entropy: float = 0.0
var multiplier: float = 1.0

func _ready() -> void:
	reset()

func add_entropy(amount: float) -> void:
	entropy += amount
	_update_multiplier()
	print("Entropy Increased! Total: ", entropy, " | New Multiplier: ", multiplier)

func reset() -> void:
	entropy = 0.0
	multiplier = 1.0

func _update_multiplier() -> void:
	multiplier = 1.0 + (entropy / 10.0) * 0.05
