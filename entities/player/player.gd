extends CharacterBody2D

@onready var movement: Movement = $Movement
@onready var input: PlayerInput = $Input
@onready var anim: PlayerAnimation = $Anim

func _physics_process(delta: float) -> void:
	var dir: Vector2 = input.get_direction()
	var jump: bool = input.is_jump_pressed()

	movement.process_movement(self, dir, jump, delta)

	anim.update_animation(dir, velocity, self, jump, delta)
