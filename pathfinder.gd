extends Node2D


var map
var path = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	queue_redraw()


func _draw():
	if path.size() < 2:
		return
	draw_polyline(path, Color.RED, 1.0, true)
