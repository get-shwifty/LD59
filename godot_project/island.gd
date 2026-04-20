extends Node2D

@export var distance: float = 100

var min_y = 306.0
var max_y = 721.0

# Called when the node enters the scene tree for the first time.
func _ready():
	distance = max_y - global_position.y
	print(name, ": ", distance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
