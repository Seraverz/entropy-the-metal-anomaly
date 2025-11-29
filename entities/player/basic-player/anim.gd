extends Node
class_name PlayerAnimation

@onready var sprite: AnimatedSprite2D = get_parent().get_node("AnimatedSprite2D")

enum State {
	IDLE, RUN, JUMP, DOUBLE_JUMP,
	FALL, LAND, LAND_IMPACT,
	ROLL, GLIDE, LEAP
}

var state: State = State.IDLE

var was_on_ground := false
var has_jumped := false
var has_double_jumped := false
var air_time := 0.0
var time_since_jump := 0.0
var last_fall_speed := 0.0


func update_animation(
	dir: Vector2,
	vel: Vector2,
	body: CharacterBody2D,
	jump_pressed: bool,
	delta: float
) -> void:

	var stats: PlayerStats = body.get_node("Stats")
	var on_ground := body.is_on_floor()

	if dir.x < 0:
		sprite.flip_h = true
	elif dir.x > 0:
		sprite.flip_h = false

	if vel.y > 0:
		last_fall_speed = vel.y

	if on_ground and not was_on_ground:
		var impact := last_fall_speed > stats.landing_impact_threshold

		has_jumped = false
		has_double_jumped = false
		air_time = 0.0
		time_since_jump = 0.0
		last_fall_speed = 0.0

		if impact:
			_set_state(State.LAND_IMPACT, "LandingWithImpact")
		else:
			_set_state(State.LAND, "Landing")

		was_on_ground = true
		return

	was_on_ground = on_ground

	if on_ground:

		if Input.is_action_just_pressed("player_roll"):
			_set_state(State.ROLL, "Roll")
			return

		if Input.is_action_just_pressed("player_leap"):
			_set_state(State.LEAP, "Leap")
			return

		if abs(dir.x) > stats.run_threshold:
			_set_state(State.RUN, "Running")
		else:
			_set_state(State.IDLE, "Idle")
		return

	air_time += delta
	if has_jumped:
		time_since_jump += delta

	if Input.is_action_pressed("player_glide"):
		_set_state(State.GLIDE, "GlidingJump")
		return

	if vel.y < stats.jump_threshold and not has_jumped:
		has_jumped = true
		time_since_jump = 0.0
		_set_state(State.JUMP, "Jumping")
		return

	if jump_pressed and has_jumped and not has_double_jumped:
		if time_since_jump <= stats.double_jump_allow_time:
			has_double_jumped = true
			_set_state(State.DOUBLE_JUMP, "DoubleJump")
			return

	if vel.y > stats.fall_threshold:
		_set_state(State.FALL, "Falling")
		return


func _set_state(new_state: State, anim_name: String) -> void:
	if state == new_state:
		return
	state = new_state

	if sprite.sprite_frames.has_animation(anim_name):
		sprite.play(anim_name)
