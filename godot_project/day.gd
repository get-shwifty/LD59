extends Node2D

func _process(delta: float) -> void:
	$DayNumber.text = "Day %0*d" % [2, Global.day_number]

func display_game_title(game_dialogue):
	game_dialogue.visible = false
	game_dialogue.clear()
	
	$GameTitle.visible = true
	$AnimationPlayer.play("Game_title")
	await $AnimationPlayer.animation_finished
	
	game_dialogue.visible = true
	$GameTitle.visible = false

func next_day():
	Global.day_number += 1

func display_object(object_name: String):
	pass
	#get_node(object_name).visible = true
