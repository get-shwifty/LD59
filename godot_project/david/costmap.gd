extends Node2D
class_name Costmap

@onready var source: Sprite2D = get_node('../CostMapSource')

@export var cell_size := 10
@export var border_cells := 20
@export var smooth_radius := 5
@export var smooth_strength := 2

var size := Vector2i.ZERO
var costmap = []

func pos_to_pixel(global_pos: Vector2) -> Vector2i:
	var local = global_transform.affine_inverse() * global_pos
	var pixel = (local / cell_size) + (Vector2(size) * 0.5)
	return Vector2i(pixel.floor())

func pixel_to_pos(pixel: Vector2i) -> Vector2:
	var local = (Vector2(pixel) - Vector2(size) * 0.5) * cell_size
	return global_transform * local

func add_cost(x: int, y: int, v: float):
	if x < 0 or y < 0 or x >= size.x or y >= size.y:
		return
	costmap[x][y] = max(costmap[x][y], v)

func init_costmap():
	costmap.clear()
	for x in range(size.x):
		costmap.append([])
		for y in range(size.y):
			costmap[x].append(0)

func build_costmap():
	var texture: Texture2D = source.texture
	if texture == null:
		push_warning("Costmap: source node has no texture")
		return

	var image: Image = texture.get_image()
	image.convert(Image.FORMAT_RGBA8)

	var img_w := image.get_width()
	var img_h := image.get_height()

	# Use global_scale to get true world size regardless of parent transforms
	var source_world_size := Vector2(source.texture.get_size()) * source.global_scale.abs()
	var resolution := Vector2i(
		int(source_world_size.x / cell_size),
		int(source_world_size.y / cell_size)
	)

	size = resolution + Vector2i(border_cells, border_cells) * 2
	init_costmap()

	var img_origin := Vector2i(border_cells, border_cells)
	for cx in range(size.x):
		for cy in range(size.y):
			var rel := Vector2i(cx, cy) - img_origin
			if rel.x < 0 or rel.y < 0 or rel.x >= resolution.x or rel.y >= resolution.y:
				continue
			var px := int(float(rel.x) / resolution.x * img_w)
			var py := int(float(rel.y) / resolution.y * img_h)
			px = clamp(px, 0, img_w - 1)
			py = clamp(py, 0, img_h - 1)
			var pixel_color: Color = image.get_pixel(px, py)
			var obstacle_value := (1.0 - pixel_color.r) * pixel_color.a
			if obstacle_value > 0.0:
				add_cost(cx, cy, obstacle_value)

func smooth_costmap():
	var smoothed = []
	for x in range(size.x):
		smoothed.append([])
		for y in range(size.y):
			smoothed[x].append(costmap[x][y])
	for cx in range(size.x):
		for cy in range(size.y):
			if costmap[cx][cy] < 1.0:
				continue
			for dx in range(-smooth_radius, smooth_radius + 1):
				for dy in range(-smooth_radius, smooth_radius + 1):
					var nx = cx + dx
					var ny = cy + dy
					if nx < 0 or ny < 0 or nx >= size.x or ny >= size.y:
						continue
					if costmap[nx][ny] >= 1.0:
						continue
					var dist = Vector2(dx, dy).length()
					if dist > smooth_radius:
						continue
					var t = 1.0 - (dist / smooth_radius)
					smoothed[nx][ny] = max(smoothed[nx][ny], t * t * smooth_strength)
	costmap = smoothed

func build_texture() -> ImageTexture:
	var image := Image.create(size.x, size.y, false, Image.FORMAT_L8)
	for x in range(size.x):
		for y in range(size.y):
			var v = 1.0 - float(costmap[x][y])
			image.set_pixel(x, y, Color(v, v, v))
	return ImageTexture.create_from_image(image)

func get_random_border_spawn() -> Vector2:
	var source_world_size := Vector2(source.texture.get_size()) * source.global_scale.abs()
	var resolution := Vector2i(
		int(source_world_size.x / cell_size),
		int(source_world_size.y / cell_size)
	)
	var img_origin := Vector2i(border_cells, border_cells)
	while true:
		var cx := randi_range(0, size.x - 1)
		var cy := randi_range(0, size.y - 1)
		var rel := Vector2i(cx, cy) - img_origin
		if rel.x < 0 or rel.y < 0 or rel.x >= resolution.x or rel.y >= resolution.y:
			return pixel_to_pos(Vector2i(cx, cy))
	return Vector2.ZERO

func _ready():
	build_costmap()
	smooth_costmap()
	var texture = build_texture()
	var sprite = Sprite2D.new()
	sprite.scale = Vector2.ONE * cell_size
	sprite.self_modulate = Color(1, 1, 1, 0.5)
	sprite.texture = texture
	sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	add_child(sprite)
