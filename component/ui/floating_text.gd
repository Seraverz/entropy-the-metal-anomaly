extends Label

@export_group("Movement")
@export var duration: float = 0.5
@export var float_distance: Vector2 = Vector2(0, -35)
@export var spread_amount: float = 15.0

@export_group("Visuals")
@export var color_normal: Color = Color.WHITE
@export var color_crit: Color = Color(1, 0.8, 0.2)
@export var color_knockback: Color = Color(0.2, 0.6, 1.0)
@export var scale_normal: Vector2 = Vector2(0.7, 0.7)
@export var scale_big: Vector2 = Vector2(1.2, 1.2)

var target_scale: Vector2

func _ready() -> void:
	z_index = 100
	top_level = true
	modulate.a = 0.0
	scale = Vector2(0.1, 0.1)
	
	await get_tree().process_frame
	pivot_offset = size / 2
	_start_animation()

func set_damage(amount: float, is_crit: bool) -> void:
	text = str(int(amount))
	
	if is_crit:
		modulate = color_crit
		target_scale = scale_big
		text += "!"
	else:
		modulate = color_normal
		target_scale = scale_normal

func set_status(status_text: String, custom_color: Color = Color.WHITE) -> void:
	text = status_text
	modulate = custom_color
	target_scale = scale_normal

func _start_animation() -> void:
	var tween = create_tween()
	var rng_x = randf_range(-spread_amount, spread_amount)
	var final_pos = position + float_distance + Vector2(rng_x, 0)
	
	tween.tween_property(self, "scale", target_scale * 1.5, 0.1)\
		.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", target_scale, 0.1)
	
	tween.set_parallel(true)
	var float_time = duration - 0.2
	tween.tween_property(self, "position", final_pos, float_time)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "modulate:a", 1.0, 0.1)
	tween.tween_property(self, "modulate:a", 0.0, float_time - 0.2)\
		.set_delay(0.2).set_ease(Tween.EASE_IN)
	
	tween.chain().tween_callback(queue_free)
