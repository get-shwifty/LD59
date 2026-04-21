extends Node2D

################################## On Ready
@onready var button1_map = ["A", "B", "C", "D", "E"]
@onready var button2_map = ["A", "B", "C", "D", "E"]
@onready var button3_map = ["0", "1", "2", "3", "4"]
@onready var button4_map = ["0", "5", "6", "7", "8"]


@onready var BUTTON_AUDIO: Dictionary = {
	"Button1HAUT": $Button1HAUT/AudioStreamPlayer,
	"Button1BAS": $Button1BAS/AudioStreamPlayer8,
	"ButtonHAUT2": $ButtonHAUT2/AudioStreamPlayer2,
	"ButtonBAS2": $ButtonBAS2/AudioStreamPlayer3,
	"ButtonHAUT3": $ButtonHAUT3/AudioStreamPlayer4,
	"ButtonBAS3": $ButtonBAS3/AudioStreamPlayer5,
	"ButtonHAUT4": $ButtonHAUT4/AudioStreamPlayer6,
	"ButtonBAS4": $ButtonBAS4/AudioStreamPlayer7,
}

################################## Var
var indexes = {}
var actual_call_event = ""

################################## Signal
signal contact_boat
signal call_from_ship

func _ready():
	$RadioButtonCalling.modulate = Color(0.0, 0.0, 0.0)
	for i in range(4):
		indexes[i+1] = 0
	indexes[1] = 1
	indexes[2] = 0
	indexes[3] = 4
	indexes[4] = 1

func _on_button_pressed(extra_arg_0: NodePath,button: int) -> void:
	var increment_index = 0
	if extra_arg_0.get_name(0).contains("BAS"):
		increment_index = 1
	else:
		increment_index = -1
	indexes[button] = posmod(indexes[button] + increment_index, 5)
	
	var btn_name = extra_arg_0.get_name(0)
	if BUTTON_AUDIO.has(btn_name):
		BUTTON_AUDIO[btn_name].play()

func _process(delta: float):
	$Label1.text = button1_map[indexes[1]]
	$Label2.text = button2_map[indexes[2]]
	$Label3.text = button3_map[indexes[3]]
	$Label4.text = button4_map[indexes[4]]
	
func _on_call_button_pressed() -> void:
	if len(actual_call_event):
		return
	# On teste si la combinaison existe bien
	var combinaison = $Label1.text + $Label2.text + $Label3.text + $Label4.text
	if Global.POSSIBLE_BOATS.has(combinaison):
		$CallButton.modulate = Color(0.192, 0.969, 0.0)
		Global.talking_boat = combinaison
		emit_signal("contact_boat", combinaison)
		$CallBoat.play()
		$CallBoat2.play()
		
func light_button_call(call_event: String):
	actual_call_event = call_event
	$AnimationPlayer.play("Calling_button")
	$Call.play()

func _on_radio_button_calling_pressed() -> void:
	$AnimationPlayer.stop()
	$Call.stop()
	$ClickToAnswer.play()
	$RadioButtonCalling.modulate = Color(0.0, 0.0, 0.0)
	call_from_ship.emit(actual_call_event)
	actual_call_event = ""
	

func _on_tooltip_enter(node: NodePath) -> void:
	var child = get_node(str(node) + "/Tooltip")
	child.visible = true

func _on_tooltip_exit(node: NodePath) -> void:
	var child = get_node(str(node) + "/Tooltip")
	child.visible = false

func quit_call():
	$CallButton.modulate = Color(1.0, 1.0, 1.0)
