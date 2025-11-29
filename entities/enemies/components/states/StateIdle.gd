extends EnemyState

func enter() -> void:
	anim.play("Wake")

func physics_update(delta: float) -> void:
	ai.mover.stop(delta)
	
	if anim.animation != "Wake" and ai.vision.get_target():
		ai.change_state(ai.get_node("Chase"))

func on_animation_finished() -> void:
	if anim.animation == "Wake":
		if ai.vision.get_target():
			ai.change_state(ai.get_node("Chase"))
		else:
			anim.play("Idle")
