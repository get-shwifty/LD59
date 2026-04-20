extends Node2D

@export var SHIP_VISUAL: PackedScene

################################## On Ready
@onready var clock = $UI/Clock
@onready var next_day_button = $UI/NextDay
@onready var camera = $Camera2D
@onready var landscape = $Parallax/Landscape
@onready var radar_game = $"radar game"

################################## Const
const VISION_ANGLE = 90
const INCREMENT_DIVIDOR = 3
const paralax_width = 5120
const MAX_DIST = 325.0

var ship_y_min: float = 700.0
var ship_y_max: float = 310.0

################################## Var
var landscape_pct = 0.0
var ship_visuals = {}  # ship.id -> Node2D

func _ready() -> void:
	var vision_pct = 360 / VISION_ANGLE
	landscape_pct = landscape.texture.get_width() / vision_pct
	clock.connect("end_night", _on_end_night)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("droite") and get_parent().is_night:
		_on_right_button_pressed()
	if Input.is_action_just_pressed("gauche") and get_parent().is_night:
		_on_left_button_pressed()
	pass
	var ships = radar_game.get_ships_polar()
	var screen_center_x = get_viewport().get_visible_rect().size.x / 2.0
	var ships_container = $Parallax/Ships

	var active_ids = []
	for ship in ships:
		var id = ship.ship.id
		active_ids.append(id)

		# Spawn if not tracked
		if not ship_visuals.has(id):
			var visuali = SHIP_VISUAL.instantiate()
			ships_container.add_child(visuali)
			ship_visuals[id] = visuali

		# Update position, scale, z
		var visual = ship_visuals[id]
		var angle_pct = fposmod((ship.angle - PI / 2.0) / (2.0 * PI), 1.0)
		var t = clamp(ship.distance / MAX_DIST, 0.0, 1.0)
		var s = lerp(1.0, 0.25, t)
		visual.position.x = (angle_pct - 0.5) * paralax_width + screen_center_x
		visual.position.y = lerp(ship_y_min, ship_y_max, t)
		visual.scale = Vector2(s, s)
		visual.z_index = ships_container.get_node("islands").get_ship_z(ship.distance)
		visual.get_node('Label').text = str(ship.distance)
		print(ship.distance)
		
	# Remove visuals for ships no longer present
	for id in ship_visuals.keys():
		if id not in active_ids:
			ship_visuals[id].queue_free()
			ship_visuals.erase(id)

func _on_end_night() -> void:
	next_day_button.visible = true

func _on_next_day_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")

func _on_left_button_pressed() -> void:
	camera.position.x -= landscape_pct / INCREMENT_DIVIDOR
	$UI/Radar/Cone.rotation_degrees -= VISION_ANGLE / INCREMENT_DIVIDOR
	$UI/Radar/Sprite2D.material.set("shader_parameter/cone_angle", $UI/Radar/Cone.rotation_degrees - 135)

func _on_right_button_pressed() -> void:
	camera.position.x += landscape_pct / INCREMENT_DIVIDOR
	$UI/Radar/Cone.rotation_degrees += VISION_ANGLE / INCREMENT_DIVIDOR
	$UI/Radar/Sprite2D.material.set("shader_parameter/cone_angle", $UI/Radar/Cone.rotation_degrees - 135)


func _on_uporder_pressed():
	var id = ship_visuals.keys()[0]
	$"radar game".send_order(id, Vector2.UP)
