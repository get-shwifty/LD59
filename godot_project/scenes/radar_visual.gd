extends Node2D

@export var scaleFactor = 2.0
@export var bigOffset = Vector2(-200, -100)
@export var SHIP: PackedScene

var big = false
@onready var baseScale = scale
@onready var bigScale = baseScale * scaleFactor
@onready var basePosition = position
@onready var bigPosition = basePosition + bigOffset

var ship_nodes = {}

func _ready():
	pass

func _process(_delta):
	var game = Global.radar_game
	if game:
		update_ships(game.get_ships_polar())
	queue_redraw()

func _get_max_dist() -> float:
	return 350

func _get_world_to_radar_scale() -> float:
	var radar_sprite = $Sprite2D
	var radar_radius = min(
		radar_sprite.texture.get_size().x * radar_sprite.scale.x,
		radar_sprite.texture.get_size().y * radar_sprite.scale.y
	) * 0.5
	return radar_radius / _get_max_dist()

func world_offset_to_radar(angle: float, distance: float) -> Vector2:
	return Vector2.RIGHT.rotated(angle) * distance * _get_world_to_radar_scale()

func update_labels():
	# $Area2D2.visible = false
	for ship in ship_nodes.values():
		ship.set_show_label(true)
	
	await get_tree().create_timer(10).timeout
	
	for ship in ship_nodes.values():
		ship.set_show_label(false)
	
		# $Area2D2.visible = true
	

func update_ships(ships):
	var valid_ids = []
	for ship in ships:
		var id = ship.ship.id
		if ship.ship.not_visible_on_radar:
			continue
		valid_ids.append(id)
		if not ship_nodes.has(id):
			var node = SHIP.instantiate()
			$Ships.add_child(node)
			ship_nodes[id] = node
			if ship.ship.should_not_cross_boats:
				node.set_zone(ship.ship.cross_radius)
		ship_nodes[id].position = world_offset_to_radar(ship.angle, ship.distance)
		ship_nodes[id].set_ship_rotation(ship.rotation)
		ship_nodes[id].set_id(ship.ship.name)
		ship_nodes[id].set_color(ship.color)
	for id in ship_nodes.keys():
		if id not in valid_ids:
			ship_nodes[id].queue_free()
			ship_nodes.erase(id)

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if big:
				big = false
				scale = baseScale
				position = basePosition
			else:
				big = true
				scale = bigScale
				position = bigPosition


func _on_area_2d_2_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			update_labels()
			$sonar.play()
			
func _on_tooltip_enter(node: NodePath) -> void:
	var child = get_node(str(node) + "/Tooltip")
	child.scale = Vector2(2,2)
	child.visible = true

func _on_tooltip_exit(node: NodePath) -> void:
	var child = get_node(str(node) + "/Tooltip")
	child.scale = Vector2(2,2)
	child.visible = false
