extends EnemyState

func enter() -> void:
	anim.play("DamagedNDeath")
	if anim.sprite_frames.has_animation("DamagedNDeath"):
		# protection, bcs idk why it loop.
		anim.sprite_frames.set_animation_loop("DamagedNDeath", false) 
	#ai.mover.body.velocity.x = 0
	ai.mover.body.velocity = Vector2.ZERO # syntax looks better lmao
	ai.entity.collision_layer = 0

func physics_update(delta: float) -> void:
	ai.mover.apply_gravity(delta)
	ai.entity.move_and_slide()

func on_animation_finished() -> void:
	GameState.on_enemy_killed(ai.entity.is_boss)
	EntropySystem.add_entropy(ai.entity.entropy_reward)
	ai.entity.queue_free()
