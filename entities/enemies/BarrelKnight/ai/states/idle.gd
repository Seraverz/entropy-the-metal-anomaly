extends Node
class_name StateIdleBK
var ai

func _init(ai_ref):
	ai = ai_ref

func enter():
	ai.anim.play_wake()

func update(delta):
	if ai.player_in_aggro:
		ai.change_state("wake")

func exit():
	pass
