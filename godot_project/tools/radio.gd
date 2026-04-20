extends Node2D

################################## On Ready
@onready var button1_map = ["A", "B", "C", "D"]
@onready var button2_map = ["W", "X", "Y", "Z"]
@onready var button3_map = ["1", "2", "3", "4"]
@onready var button4_map = ["5", "6", "7", "8"]

################################## Var
var indexes = {}

################################## Signal
signal contact_boat

func _ready():
	for i in range(4):
		indexes[i+1] = 0

func _on_button_pressed(extra_arg_0: NodePath,button: int) -> void:
	var increment_index = 0
	print(extra_arg_0.get_name(0))
	if extra_arg_0.get_name(0).contains("BAS"):
		increment_index = 1
	else:
		increment_index = -1
	indexes[button] = posmod(indexes[button] + increment_index, 4)

func _process(delta: float):
	$Label1.text = button1_map[indexes[1]]
	$Label2.text = button2_map[indexes[2]]
	$Label3.text = button3_map[indexes[3]]
	$Label4.text = button4_map[indexes[4]]
	
func _on_call_button_pressed() -> void:
	# On teste si la combinaison existe bien
	var combinaison = $Label1.text + $Label2.text + $Label3.text + $Label4.text
	if Global.POSSIBLE_BOATS.has(combinaison):
		$CallButton.modulate = Color(0.192, 0.969, 0.0)
		Global.talking_boat = combinaison
		emit_signal("contact_boat", combinaison)
