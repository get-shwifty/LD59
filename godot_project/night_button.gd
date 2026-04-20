extends TextureButton


var initial_color = modulate

func _ready():
	button_down.connect(_on_pressed)
	button_up.connect(_on_released)

func _on_pressed():
	modulate = Color(0.416, 0.275, 0.033, 1.0)  # teinte rouge

func _on_released():
	modulate = initial_color  # couleur normale
