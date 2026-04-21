extends Node2D
var id = "null"
var zone_size = 0

func set_ship_rotation(rot):
	$Circle.rotation = rot

func set_id(ship_id: String):
	id = ship_id
	$Label.text = id
	
func set_color(color):
	$Circle.modulate = color
	
func set_show_label(value: bool):
	$Label.visible = value
	
func set_zone(size: int):
	zone_size = size
	queue_redraw()
	
func _draw():
	if zone_size:
		var segments = 64
		var angle_step = TAU / segments
		var dash_length = 8.0
		var gap_length = 8.0
		var circumference = TAU * zone_size
		var total_dashes = int(circumference / (dash_length + gap_length))
		var actual_step = TAU / total_dashes
		var dash_angle = actual_step * (dash_length / (dash_length + gap_length))

		for i in range(total_dashes):
			var start_angle = i * actual_step
			var end_angle = start_angle + dash_angle
			var from = Vector2(cos(start_angle), sin(start_angle)) * zone_size
			var to = Vector2(cos(end_angle), sin(end_angle)) * zone_size
			draw_line(from, to, Color.RED, 1.5)
