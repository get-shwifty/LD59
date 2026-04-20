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
	print($UI/Radar/Cone.rotation_degrees)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("droite") and get_parent().is_night:
		_on_right_button_pressed()
	if Input.is_action_just_pressed("gauche") and get_parent().is_night:
		_on_left_button_pressed()
	pass

func _on_end_night() -> void:
	next_day_button.visible = true

func _on_next_day_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")

func _on_left_button_pressed() -> void:
	print(camera)
	camera.position.x -= landscape_pct / INCREMENT_DIVIDOR
	$UI/Radar/Cone.rotation_degrees -= VISION_ANGLE / INCREMENT_DIVIDOR
	print($UI/Radar/Cone.rotation_degrees)
	$UI/Radar/Sprite2D.material.set("shader_parameter/cone_angle", $UI/Radar/Cone.rotation_degrees - 135)

func _on_right_button_pressed() -> void:
	camera.position.x += landscape_pct / INCREMENT_DIVIDOR
	$UI/Radar/Cone.rotation_degrees += VISION_ANGLE / INCREMENT_DIVIDOR
	print($UI/Radar/Cone.rotation_degrees)
	$UI/Radar/Sprite2D.material.set("shader_parameter/cone_angle", $UI/Radar/Cone.rotation_degrees - 135)
