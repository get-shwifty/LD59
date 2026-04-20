extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _draw():
	var length := 200.0
	var head := 100.0
	var dir := Vector2.RIGHT
	var tip := dir * length
	var left := (dir.rotated(deg_to_rad(150))) * head
	var right := (dir.rotated(deg_to_rad(-150))) * head
	draw_line(Vector2.ZERO, tip, Color.RED, 40.0)
	draw_line(tip, tip + left, Color.RED, 40.0)
	draw_line(tip, tip + right, Color.RED, 40.0)
