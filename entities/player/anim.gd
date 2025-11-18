extends Node
class_name PlayerAnimation

@onready var sprite: AnimatedSprite2D = get_parent().get_node("AnimatedSprite2D")

enum State { IDLE, RUN, JUMP, PEAK, FALL, LAND }
var state: State = State.IDLE

const PEAK_THRESHOLD := 20.0
const FALL_THRESHOLD := 60.0

var was_on_ground := false

func update_animation(dir: Vector2, vel: Vector2, body: CharacterBody2D) -> void:

	var on_ground := body.is_on_floor()

	if dir.x < 0:
		sprite.flip_h = true
	elif dir.x > 0:
		sprite.flip_h = false

	if not on_ground:

		if vel.y < -PEAK_THRESHOLD:
			_set_state(State.JUMP, "Jumping")
			was_on_ground = false
			return

		if abs(vel.y) <= PEAK_THRESHOLD:
			_set_state(State.PEAK, "")
			_hold_peak_frame()
			was_on_ground = false
			return

		if vel.y > FALL_THRESHOLD:
			_set_state(State.FALL, "Falling")
			was_on_ground = false
			return

		return


	if not was_on_ground:
		_set_state(State.LAND, "Landing")
		was_on_ground = true
		return

	if abs(dir.x) > 0.1:
		_set_state(State.RUN, "Running")
	else:
		_set_state(State.IDLE, "Idle")

func _set_state(new_state: State, anim_name: String) -> void:
	if state == new_state:
		return

	state = new_state
	
	if anim_name != null:
		if sprite.sprite_frames.has_animation(anim_name):
			sprite.stop()             
			sprite.play(anim_name)      

func _hold_peak_frame():
	if sprite.animation == "Jumping":
		var count := sprite.sprite_frames.get_frame_count("Jumping")
		if count > 0:
			var mid := int(count / 2)
			sprite.frame = mid
			sprite.stop()   
