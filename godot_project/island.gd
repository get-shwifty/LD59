extends Node2D

@export var distance: float = 100

# These must match your main scene's values
var ship_y_min: float = 721.0 # Bottom (Closest)
var ship_y_max: float = 306.0 # Top (Furthest)
const MAX_DIST = 325.0
const MIN_DIST = 60.0

func _ready():
	# 1. Manual inv_lerp to find the screen ratio 't'
	# This gives us 0.0 at ship_y_min and 1.0 at ship_y_max
	var t = (global_position.y - ship_y_min) / (ship_y_max - ship_y_min)
	t = clamp(t, 0.0, 1.0)
	
	# 2. Get the reciprocal bounds
	var inv_min = 1.0 / MIN_DIST
	var inv_max = 1.0 / MAX_DIST
	
	# 3. Interpolate between the reciprocal bounds
	var inv_d = lerp(inv_min, inv_max, t)
	
	# 4. Flip back to get actual ground distance
	distance = 1.0 / inv_d
	
	print(name, " calculated ground distance: ", distance)
