extends Node2D

@export var SHIP_VISUAL: PackedScene

################################## On Ready
@onready var clock = $UI/Clock
@onready var next_day_button = $UI/NextDay
@onready var camera = $Camera2D
@onready var landscape = $Parallax/Landscape
@onready var radar_game = $"radar game"
@onready var sav_rotation_degrees = $UI/Radar/Cone.rotation_degrees 

################################## Const
const VISION_ANGLE = 90
const INCREMENT_DIVIDOR = 3
const paralax_width = 5120
const MAX_DIST = 325.0

const MIN_DIST = 60.0

var ship_y_min: float = 700.0
var ship_y_max: float = 320.0

################################## Var
var landscape_pct = 0.0
var ship_visuals = {}  # ship.id -> Node2D

################################## Signal
signal switch_to_day

func _ready() -> void:
	var vision_pct = 360 / VISION_ANGLE
	landscape_pct = landscape.texture.get_width() / vision_pct
	clock.connect("end_night", _on_end_night)
	load_level(0)
	
func load_level(level: int):
	print("start level ", level)
	$"radar game".load_level(level)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("droite") and get_parent().is_night:
		_on_right_button_pressed()
	if Input.is_action_just_pressed("gauche") and get_parent().is_night:
		_on_left_button_pressed()
	
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
		visual.position.x = (angle_pct - 0.5) * paralax_width + screen_center_x
		
		# --- PERSPECTIVE MATH STARTS HERE ---
		
		# 1. Prevent division by zero if ship is exactly at center
		var safe_dist = max(ship.distance, MIN_DIST) 
		
		# 2. Calculate the inverse depth
		var inv_min = 1.0 / MIN_DIST
		var inv_max = 1.0 / MAX_DIST
		var inv_d = 1.0 / safe_dist
		
		# 3. Get the perspective ratio (0.0 at MIN_DIST, 1.0 at MAX_DIST)
		var t_persp = (inv_min - inv_d) / (inv_min - inv_max)
		t_persp = clamp(t_persp, 0.0, 1.0) 
		
		# 4. Apply the perspective ratio to scale and Y position
		var s = lerp(1.0, 0.3, t_persp)
		visual.position.y = lerp(ship_y_min, ship_y_max, t_persp)
		visual.scale = Vector2(s, s)
		visual.z_index = ships_container.get_node("islands").get_ship_z(ship.distance)
		visual.get_node('Label').text = str(ship.distance)
		
	# Remove visuals for ships no longer present
	for id in ship_visuals.keys():
		if id not in active_ids:
			ship_visuals[id].queue_free()
			ship_visuals.erase(id)
		
	# Gestion des évènements qui arrivent selon une heure précise, lorsque le timer n'est pas en pause
	var call_event = Global.event_to_call
	var event_hour = 0
	if call_event.length() > 0:
		event_hour = int(call_event.lstrip("h"))
		if clock.hours >= event_hour and (!clock.timer.is_paused()) :
			Global.event_to_call = ""
			$UI/Radio.light_button_call(call_event)
	
func _on_end_night() -> void:
	next_day_button.visible = true

func _on_next_day_pressed() -> void:
	switch_to_day.emit()

func _on_left_button_pressed() -> void:
	camera.position.x -= landscape_pct / INCREMENT_DIVIDOR
	$UI/Radar/Cone.rotation_degrees -= VISION_ANGLE / INCREMENT_DIVIDOR
	$UI/Radar/Sprite2D.material.set("shader_parameter/cone_angle", $UI/Radar/Cone.rotation_degrees - 135)

func _on_right_button_pressed() -> void:
	camera.position.x += landscape_pct / INCREMENT_DIVIDOR
	$UI/Radar/Cone.rotation_degrees += VISION_ANGLE / INCREMENT_DIVIDOR
	$UI/Radar/Sprite2D.material.set("shader_parameter/cone_angle", $UI/Radar/Cone.rotation_degrees - 135)

func _on_order_sent(tag: String):
	print("Réception des ordres")
	print("Direction %s" % tag)
	print("Ship %s" % Global.talking_boat)

func _on_uporder_pressed():
	var id = ship_visuals.keys()[0]
	$"radar game".send_order(id, Vector2.UP)

func reset_cone_rotation_degrees():
	$UI/Radar/Cone.rotation_degrees = sav_rotation_degrees
	$UI/Radar/Sprite2D.material.set("shader_parameter/cone_angle", $UI/Radar/Cone.rotation_degrees - 135)
