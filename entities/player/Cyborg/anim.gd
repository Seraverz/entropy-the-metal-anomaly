extends Node
class_name CyborgAnimation

@onready var sprite: AnimatedSprite2D = get_parent().get_node("Pivot/AnimatedSprite2D")
		
func play_idle():
	sprite.play("Idle2Laserbeam")

func play_run():
	sprite.play("Run2Laserbeam")

func play_jump():
	sprite.play("Jump2Laserbeam")

func play_double_jump():
	sprite.play("DoubleJump")

func play_fall():
	sprite.play("Fall")

func play_attack():
	sprite.play("FiringHotLaserbeam")

func play_hurt():
	if sprite.sprite_frames.has_animation("Hurt"):
		sprite.play("Hurt")
		sprite.sprite_frames.set_animation_loop("Hurt", false)
	else:
		print("Warning: 'Hurt' animation are not found")

func play_death():
	sprite.play("Death")
	if sprite.sprite_frames.has_animation("Death"):
		sprite.sprite_frames.set_animation_loop("Death", false)

func is_finished() -> bool:
	return not sprite.is_playing()
