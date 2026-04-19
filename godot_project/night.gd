extends Node2D

################################## On Ready
@onready var clock = $UI/Clock
@onready var next_day_button = $UI/NextDay
@onready var camera = $Camera2D
@onready var landscape = $Parallax/Landscape

################################## Const
const VISION_ANGLE = 90
const INCREMENT_DIVIDOR = 3

################################## Var
var landscape_pct = 0.0

func _ready() -> void:
	var vision_pct = 360 / VISION_ANGLE
	landscape_pct = landscape.texture.get_width()/ vision_pct
	clock.connect("end_night", _on_end_night)

func _process(delta: float) -> void:
	pass

func _on_end_night() -> void:
	next_day_button.visible = true

func _on_next_day_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")

func _on_left_button_pressed() -> void:
	print(camera)
	camera.position.x -= landscape_pct / INCREMENT_DIVIDOR
	$UI/Radar/Cone.rotation_degrees -= VISION_ANGLE / INCREMENT_DIVIDOR

func _on_right_button_pressed() -> void:
	camera.position.x += landscape_pct / INCREMENT_DIVIDOR
	$UI/Radar/Cone.rotation_degrees += VISION_ANGLE / INCREMENT_DIVIDOR
