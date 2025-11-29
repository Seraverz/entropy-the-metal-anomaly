extends EnemyState

@onready var collision_attack: CollisionShape2D = ai.attack_area.get_node("CollisionAttack")
var has_dealt_damage: bool = false

func enter() -> void:
	anim.play("Attack")
	ai.mover.body.velocity = Vector2.ZERO
	has_dealt_damage = false
	collision_attack.set_deferred("disabled", false)

func physics_update(delta: float) -> void:
	ai.mover.apply_gravity(delta)
	ai.entity.move_and_slide()
	
	if not has_dealt_damage:
		_check_hit()

func exit() -> void:
	collision_attack.set_deferred("disabled", true)

func on_animation_finished() -> void:
	ai.change_state(ai.get_node("Chase"))

func _check_hit() -> void:
	var bodies = ai.attack_area.get_overlapping_bodies()
	for b in bodies:
		if b.is_in_group("player") and b.has_method("apply_damage"):
			b.apply_damage(ai.stats.attack_damage)
			has_dealt_damage = true
