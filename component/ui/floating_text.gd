extends Label

@export_group("Movement Settings")
@export var duration: float = 0.5       
@export var float_distance: Vector2 = Vector2(0, -35) 
@export var spread_amount: float = 15.0  

@export_group("Pop Animation")
@export var pop_duration: float = 0.1
@export var scale_normal: Vector2 = Vector2(0.7, 0.7)
@export var scale_pop_mult: float = 1.5 

@export_group("Visual & Color")
@export var crit_threshold: float = 50.0
@export var color_normal: Color = Color.WHITE
@export var color_crit: Color = Color(3.0, 3.0, 0.0, 1.0)

func _ready() -> void:
	z_index = 100
	top_level = true
	
	modulate.a = 0.0
	scale = Vector2(0.1, 0.1)
	
	await get_tree().process_frame
	pivot_offset = size / 2
	
	_start_animation()

func set_amount(amount: float) -> void:
	text = str(int(amount))
	
	if amount > crit_threshold:
		modulate = color_crit
		scale_normal *= 1.2 
	else:
		modulate = color_normal

func _start_animation() -> void:
	var tween = create_tween()
	var rng_x = randf_range(-spread_amount, spread_amount)
	var final_pos = position + float_distance + Vector2(rng_x, 0)
	
	tween.tween_property(self, "scale", scale_normal * scale_pop_mult, pop_duration)\
		.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", scale_normal, pop_duration)
	
	tween.set_parallel(true)
	
	var float_time = duration - (pop_duration * 2)
	tween.tween_property(self, "position", final_pos, float_time)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	tween.tween_property(self, "modulate:a", 1.0, 0.1)
	
	var fade_delay = float_time * 0.5 
	tween.tween_property(self, "modulate:a", 0.0, float_time - fade_delay)\
		.set_delay(fade_delay).set_ease(Tween.EASE_IN)
	
	tween.chain().tween_callback(queue_free)
