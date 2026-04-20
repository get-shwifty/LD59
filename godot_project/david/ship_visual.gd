extends Node2D
var id = "null"

func set_ship_rotation(rot):
	$Circle.rotation = rot

func set_id(ship_id: String):
	id = ship_id
	$Label.text = id
	
func set_color(color):
	$Circle.modulate = color
