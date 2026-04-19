extends Node2D

@export var start: Node2D
@export var goal: Node2D

@onready var iles = get_node('../Iles')


var size := Vector2i(500, 500)
var cellSize := 10
var smoothRadius = 10

var costmap = []
var astar := AStar2D.new()
var id_map = {}
var worldPath = []

func find_path_global(start: Vector2, goal: Vector2):
	var res = find_path(pos_to_pixel(start), pos_to_pixel(goal))
	var path = []
	for r in res:
		path.append(pixel_to_pos(r))
	return path

func find_path(start_pixel:Vector2i, goal_pixel:Vector2i):
	var start_id = id_map[start_pixel]
	var goal_id = id_map[goal_pixel]
	var path = astar.get_point_path(start_id, goal_id)

	return path

func pos_to_pixel(pos: Vector2) -> Vector2i:
	var local = pos - global_position
	var pixel = (local / cellSize) + (Vector2(size) * 0.5)
	return Vector2i(pixel.floor())
	
func pixel_to_pos(pixel: Vector2i) -> Vector2:
	var local = (Vector2(pixel) - Vector2(size) * 0.5) * cellSize
	return local + global_position
	
func set_cell(x: int, y: int, value: int):
	if x < 0 or y < 0 or x >= size.x or y >= size.y:
		return

	costmap[x][y] = value

func init_costmap():
	costmap.clear()
	
	for x in range(size.x):
		costmap.append([])
		for y in range(size.y):
			costmap[x].append(0)

func add_obstacle(collider):
	var center = pos_to_pixel(collider.global_position)

	var radius = collider.get_node("shape").shape.radius
	var radius_cells = radius / cellSize

	var maxRadius = int(ceil(radius_cells + smoothRadius))

	for x in range(-maxRadius, maxRadius + 1):
		for y in range(-maxRadius, maxRadius + 1):
			var p = center + Vector2i(x, y)
			var dist = Vector2(x, y).length()
			var value := 0.0
			if dist <= radius_cells:
				value = 1.0
			elif dist <= radius_cells + smoothRadius:
				var t = (dist - radius_cells) / smoothRadius
				value = 1.0 - t
			if value > 0.0:
				add_cost(p.x, p.y, value)
				

func add_cost(x:int, y:int, v:float):
	if x < 0 or y < 0 or x >= size.x or y >= size.y:
		return
	costmap[x][y] = max(costmap[x][y], v)
	
func build_astar():
	astar.clear()
	var id := 0
	for x in size.x:
		for y in size.y:
			if costmap[x][y] >= 1.0:
				continue
			var p = Vector2i(x,y)
			id_map[p] = id
			astar.add_point(
				id,
				Vector2(x,y),
				1.0 + costmap[x][y] * 10.0
			)
			id += 1
	var dirs := [
		Vector2i(1,0),Vector2i(-1,0),
		Vector2i(0,1),Vector2i(0,-1),
		Vector2i(1,1),Vector2i(-1,-1),
		Vector2i(1,-1),Vector2i(-1,1),
	]
	for p in id_map.keys():
		for d in dirs:
			var n = p + d
			if not id_map.has(n):
				continue

			astar.connect_points(
				id_map[p],
				id_map[n],
				true
			)

func add_all_obstacles():
	for node in iles.get_children():
		add_obstacle(node)
		
func build_texture():
	var image := Image.create(size.x, size.y, false, Image.FORMAT_L8)

	for x in range(size.x):
		for y in range(size.y):
			var v = 1.0 - float(costmap[x][y])
			image.set_pixel(x, y, Color(v, v, v))

	return ImageTexture.create_from_image(image)

func _ready():
	global_scale = Vector2.ONE * cellSize
	init_costmap()
	add_all_obstacles()
	build_astar()
	var texture = build_texture()

	var sprite := Sprite2D.new()
	sprite.texture = texture
	sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	add_child(sprite)
	#worldPath = find_path_global(start.global_position, goal.global_position)
	#Pathfinder.path = worldPath
	#start.set_path(worldPath)
	
	Pathfinder.map = self
	
func _process(delta):
	pass
	
