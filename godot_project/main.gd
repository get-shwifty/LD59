extends Node2D

@onready var start_game_button = $StartGame
@onready var end_day_button = $EndDay
@onready var day_number = $DayNumber

func _ready() -> void:
	if Global.game_started == false:
		start_game_button.visible = true 
		Global.game_started = true
	else:
		Global.day_number += 1 
		start_game_button.visible = false
		start_day()

func _process(delta: float) -> void:
	day_number.text = "Day %0*d" % [2, Global.day_number]

func _on_start_game_pressed() -> void:
	start_game_button.visible = false
	start_day()
	
func start_day() -> void:
	end_day_button.visible = true

func _on_end_day_pressed() -> void:
	get_tree().change_scene_to_file("res://night.tscn")
