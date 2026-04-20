extends Node2D
class_name RadarGame

@onready var costmapManager = $RadarGame/CostmapGenerated

func _ready():
	Global.radar_game = self

func _process(_delta):
	#queue_redraw()
	pass

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
			"distance": offset.length()
		})
	return result
