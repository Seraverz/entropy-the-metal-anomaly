extends EnemyState

@export var attack_range: float = 40.0

func enter() -> void:
	anim.play("Run")

func physics_update(delta: float) -> void:
	var target = ai.vision.get_target()
	
	if not target:
		ai.change_state(ai.get_node("Idle"))
		return
	
	ai.mover.move_towards(target.global_position, delta)
	
	var dist = ai.entity.global_position.distance_to(target.global_position)
	if dist <= attack_range:
		ai.change_state(ai.get_node("Attack"))
