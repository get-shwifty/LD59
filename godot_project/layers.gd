extends Node2D

var layers = []

# Called when the node enters the scene tree for the first time.
func _ready():
	layers = get_children()
	layers.sort_custom(func(a, b): return a.distance > b.distance)
	for idx in len(layers):
		layers[idx].z_index = idx+1

func get_ship_z(distance):
	for idx in len(layers):
		if distance > layers[idx].distance:
			return idx
	return len(layers)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
