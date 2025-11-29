extends Node
class_name Movement

var has_double_jumped := false

func process_movement(
	body: CharacterBody2D,
	dir: Vector2,
	input: PlayerInput,
	anim: PlayerAnimation,
	delta: float
) -> void:

	var stats: PlayerStats = body.get_node("Stats")
	var on_ground := body.is_on_floor()

	
	body.velocity.x = dir.x * stats.move_speed

	
	body.velocity.y += stats.gravity * delta

	
	if input.is_jump_pressed() and on_ground:
		body.velocity.y = stats.jump_force
		has_double_jumped = false

	
	if input.is_jump_pressed() and not on_ground and not has_double_jumped:
		body.velocity.y = stats.double_jump_force
		has_double_jumped = true


	if input.is_glide_pressed() and not on_ground:
		body.velocity.y *= stats.glide_gravity_scale

	
	if input.is_roll_pressed() and on_ground:
		body.velocity.x = (sign(body.velocity.x) if body.velocity.x != 0 else 1) * stats.roll_speed
		
	if input.is_leap_pressed() and on_ground:
		var dir_sign := sprite_flip_dir(body)
		body.velocity.x = dir_sign * stats.leap_speed
		body.velocity.y = stats.jump_force * 0.02

	body.move_and_slide()


func sprite_flip_dir(body: CharacterBody2D) -> int:
	var sprite: AnimatedSprite2D = body.get_node("AnimatedSprite2D")
	return -1 if sprite.flip_h else 1
