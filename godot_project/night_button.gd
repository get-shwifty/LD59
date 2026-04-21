extends TextureButton

var base_x: float
var amplitude : float = 3.5
var speed : float = 5.0 

var initial_color = modulate

func _ready():
	button_down.connect(_on_pressed)
	button_up.connect(_on_released)
	base_x = position.x
	
func _process(delta):
	position.x = base_x + sin(Time.get_ticks_msec() / 1000.0 * speed) * amplitude

func _on_pressed():
	modulate = Color(0.416, 0.275, 0.033, 1.0)  # teinte rouge

func _on_released():
	modulate = initial_color  # couleur normale
