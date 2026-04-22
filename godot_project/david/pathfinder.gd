extends Node2D
class_name Pathfinder

@export var costmapManager: Costmap

var fullAstar := AStar2D.new()
var paths = {}
var modified_ids = {}
var ship_radius_cache = {}

func pos_to_id(global_pos: Vector2) -> int:
	return pixel_to_id(costmapManager.pos_to_pixel(global_pos))

func pixel_to_id(pixel: Vector2i) -> int:
	return pixel.x + pixel.y * costmapManager.size.x

func id_to_pixel(id: int) -> Vector2i:
	var width = costmapManager.size.x
	return Vector2i(id % width, id / width)

func id_to_pos(id: int) -> Vector2:
	return costmapManager.pixel_to_pos(id_to_pixel(id))

func pixel_to_cost(pixel: Vector2i) -> float:
	return 1.0 + costmapManager.costmap[pixel.x][pixel.y] * 5.0

func is_obstacle(pixel: Vector2i) -> bool:
	return costmapManager.costmap[pixel.x][pixel.y] >= 1.0
	
func is_position_obstacle(pos: Vector2):
	var pixel = costmapManager.pos_to_pixel(pos)
	return is_obstacle(pixel)

func get_ship_cell_radius(ship) -> int:
	if ship_radius_cache.has(ship):
		return ship_radius_cache[ship]
	var radius = ship.get_node("CollisionShape2D").shape.radius
	var cell_radius = int(ceil(radius / costmapManager.cell_size)) * 4
	ship_radius_cache[ship] = cell_radius
	return cell_radius

func update_ships_pos(ships):
	for id in modified_ids:
		fullAstar.set_point_weight_scale(id, pixel_to_cost(id_to_pixel(id)))
	modified_ids.clear()

	for ship in ships:
		if ship.should_not_cross_boats:
			continue
		var cell_radius = get_ship_cell_radius(ship)
		var ship_cell = costmapManager.pos_to_pixel(ship.global_position)
		for dx in range(-cell_radius, cell_radius + 1):
			for dy in range(-cell_radius, cell_radius + 1):
				var cell = ship_cell + Vector2i(dx, dy)
				if cell.x >= 0 and cell.x < costmapManager.size.x \
						and cell.y >= 0 and cell.y < costmapManager.size.y:
					var id = pixel_to_id(cell)
					if fullAstar.has_point(id):
						var dist = Vector2(dx, dy).length()
						var t = clamp(dist / cell_radius, 0.0, 1.0)
						var weight = lerp(10.0, 1.0, t*t)
						var current = fullAstar.get_point_weight_scale(id)
						weight = max(weight, pixel_to_cost(cell), current)
						fullAstar.set_point_weight_scale(id, weight)
						modified_ids[id] = true

func compute_path(ship, goal: Vector2) -> Array:
	var t = Time.get_ticks_usec()
	var ships = get_node('../Ships').get_children().filter(func(s): return s != ship)
	update_ships_pos(ships)
	var path = fullAstar.get_point_path(pos_to_id(ship.global_position), pos_to_id(goal))
	#print("compute_path: ", (Time.get_ticks_usec() - t), " us")
	return Array(path)

func build_astar():
	fullAstar.clear()
	var size = costmapManager.size
	var dirs := [
		Vector2i(1,0), Vector2i(-1,0),
		Vector2i(0,1), Vector2i(0,-1),
		Vector2i(1,1), Vector2i(-1,-1),
		Vector2i(1,-1), Vector2i(-1,1),
	]
	for x in size.x:
		for y in size.y:
			var p = Vector2i(x, y)
			if is_obstacle(p):
				continue
			# Store global world position directly in astar
			fullAstar.add_point(pixel_to_id(p), costmapManager.pixel_to_pos(p), pixel_to_cost(p))
	for x in size.x:
		for y in size.y:
			var p = Vector2i(x, y)
			if is_obstacle(p):
				continue
			var id = pixel_to_id(p)
			for d in dirs:
				var n = pixel_to_id(p + d)
				if not fullAstar.has_point(n):
					continue
				if not fullAstar.are_points_connected(id, n):
					fullAstar.connect_points(id, n, true)

func _ready():
	build_astar()
	Global.pathfinder = self

func draw_path(id, path):
	paths[id] = path
	queue_redraw()

func _process(_delta):
	queue_redraw()
	redraw_map()

func build_texture() -> ImageTexture:
	var size = costmapManager.size
	var image := Image.create(size.x, size.y, false, Image.FORMAT_L8)
	for x in range(size.x):
		for y in range(size.y):
			var id = pixel_to_id(Vector2i(x, y))
			if not fullAstar.has_point(id):
				image.set_pixel(x, y, Color(0, 0, 0))
				continue
			var w = clamp(fullAstar.get_point_weight_scale(id), 1.0, 10.0)
			var v = 1.0 - (w / 10.0)
			if fullAstar.is_point_disabled(id):
				image.set_pixel(x, y, Color(1, 0, 0))
			else:
				image.set_pixel(x, y, Color(v, v, v))
	return ImageTexture.create_from_image(image)

func redraw_map():
	var container = get_node("../AstarMap")
	for c in container.get_children():
		c.queue_free()
	update_ships_pos(get_node('../Ships').get_children())
	var sprite := Sprite2D.new()
	sprite.texture = build_texture()
	sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	sprite.scale = Vector2.ONE * costmapManager.cell_size
	sprite.global_position = costmapManager.global_position
	container.add_child(sprite)

func _draw():
	for path in paths.values():
		if len(path) < 2:
			continue
		# Convert global path positions to this node's local space for drawing
		var local_path = path.map(func(p): return to_local(Vector2(p)))
		draw_polyline(local_path, Color.RED, 1.0, true)
