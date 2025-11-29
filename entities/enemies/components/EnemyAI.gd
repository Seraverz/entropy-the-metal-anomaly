extends Node
class_name EnemyAI

@export var initial_state: EnemyState

@onready var entity: CharacterBody2D = get_parent()
@onready var stats: EnemyStats = entity.get_node("Stats")
@onready var mover: EnemyMover = entity.get_node("Mover")
@onready var vision: EnemyVision = entity.get_node("Marker2D/VisionArea") 
@onready var attack_area: Area2D = entity.get_node("Marker2D/AttackArea")

var current_state: EnemyState

func _ready() -> void:
	await get_parent().ready
	
	var anim = entity.get_node("Marker2D/AnimatedSprite2D")
	if not anim.animation_finished.is_connected(_on_anim_finished):
		anim.animation_finished.connect(_on_anim_finished)
	
	stats.health_depleted.connect(_on_death)
	
	for child in get_children():
		if child is EnemyState:
			child.setup(self)
	
	if initial_state:
		change_state(initial_state)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func change_state(new_state: EnemyState) -> void:
	if current_state:
		current_state.exit()
	
	current_state = new_state
	
	if current_state:
		current_state.enter()

func _on_anim_finished() -> void:
	if current_state:
		current_state.on_animation_finished()

func _on_death() -> void:
	if has_node("Death"):
		change_state(get_node("Death"))
