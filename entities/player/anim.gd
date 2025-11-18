extends Node
class_name PlayerAnimation

@onready var sprite: AnimatedSprite2D = get_parent().get_node("AnimatedSprite2D")

# ============================
# CONFIGURABLE THRESHOLDS
# ============================
@export var fall_threshold: float = 4000.0      # Vel.y > 2000 ⇒ FALL
@export var jump_threshold: float = -10.0       # Vel.y < -10 ⇒ JUMP
@export var run_threshold: float = 0.1          # abs(dir.x) > 0.1 ⇒ RUN
@export var double_jump_allow_time: float = 0.5 # Durasi max double jump
												# setelah first jump

# ============================
# STATE MACHINE DEFINITIONS
# ============================
enum State { IDLE, RUN, JUMP, DOUBLE_JUMP, FALL, LAND }
var state: State = State.IDLE

var was_on_ground: bool = false
var has_jumped: bool = false
var has_double_jumped: bool = false

var air_time: float = 0.0    # berapa lama di udara
var time_since_jump: float = 0.0  # untuk double jump timing

# ============================
# MAIN UPDATE
# ============================
func update_animation(
	dir: Vector2,
	vel: Vector2,
	body: CharacterBody2D,
	jump_pressed: bool,
	delta: float
) -> void:

	var on_ground := body.is_on_floor()

	# Flip kiri/kanan
	if dir.x < 0:
		sprite.flip_h = true
	elif dir.x > 0:
		sprite.flip_h = false

	# ============================
	# LANDING (ketika baru menyentuh tanah)
	# ============================
	if on_ground and not was_on_ground:
		# Reset flags
		has_jumped = false
		has_double_jumped = false
		air_time = 0.0
		time_since_jump = 0.0

		_set_state(State.LAND, "Landing")
		was_on_ground = true
		return

	was_on_ground = on_ground

	# ============================
	# GROUNDED LOGIC
	# ============================
	if on_ground:
		if abs(dir.x) > run_threshold:
			_set_state(State.RUN, "Running")
		else:
			_set_state(State.IDLE, "Idle")
		return

	# ============================
	# AIR LOGIC
	# ============================
	air_time += delta
	if has_jumped:
		time_since_jump += delta

	# -------- FIRST JUMP (JUMPING) --------
	if vel.y < jump_threshold and not has_jumped:
		has_jumped = true
		time_since_jump = 0.0
		_set_state(State.JUMP, "Jumping")
		return

	# -------- DOUBLE JUMP --------
	if jump_pressed and has_jumped and not has_double_jumped:
		# Flexible timing: bisa kapan saja selama time_since_jump < max
		if time_since_jump <= double_jump_allow_time:
			has_double_jumped = true
			_set_state(State.DOUBLE_JUMP, "DoubleJump")
			return

	# -------- FALLING --------
	# Hanya aktif saat JATUH CEPAT (vel.y > fall_threshold)
	if vel.y > fall_threshold:
		_set_state(State.FALL, "Falling")
		return

	# Jika tidak masuk kondisi di atas, biarkan animasi sebelumnya tetap

func _set_state(new_state: State, anim_name: String) -> void:
	if state == new_state:
		return

	state = new_state

	if sprite.sprite_frames.has_animation(anim_name):
		sprite.play(anim_name)
