extends Node2D
class_name RadarGame

@onready var costmapManager = $RadarGame/CostmapGenerated

func _ready():
	Global.radar_game = self
	#load_level(0)

func _process(_delta):
	#queue_redraw()
	pass

func load_level(level: int):
	$RadarGame.load_level(level)

func _draw():
	var center = Vector2.ZERO
	var radius = 10.0
	draw_circle(center, radius, Color.WHITE)

func get_ships_polar() -> Array:
	var ships = get_node("RadarGame/Ships").get_children()
	var result = []
	for ship in ships:
		var offset = ship.global_position - global_position
		result.append({
			"ship": ship,
			"angle": offset.angle(),
			"rotation": ship.facing.angle(),
			"distance": offset.length(),
			"color": ship.modulate
		})
	return result
	
func send_order(ship_id, direction: Vector2):
	var ships = $RadarGame/Ships.get_children()
	var ship = null
	for s in ships:
		if s.id == ship_id:
			ship = s
			break
	if ship == null:
		return
		
	ship.send_order(direction)
