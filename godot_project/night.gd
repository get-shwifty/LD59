extends Node2D

@onready var clock = $Clock
@onready var next_day_button = $NextDay

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	clock.connect("end_night", _on_end_night)
	pass

func _on_end_night() -> void:
	next_day_button.visible = true


func _on_next_day_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")
