extends ScrollContainer
class_name DialogeUI

@export var center_all = false

var max_scroll_length = 0 
@onready var scrollbar = get_v_scroll_bar()

var text_buffer = []
var option_buffer = []
var is_writing = false
var tag_buffer = []

@onready var audio_player: AudioStreamPlayer = $SoundsPlayer

const TAG_SOUNDS: Dictionary = {
	"rf": "res://assets/soundEffects/voices/VoixGeneriques/Jeanne",
	"rro": "res://assets/soundEffects/voices/VoixGeneriques/Jeanne",
	"rbr": "res://assets/soundEffects/voices/VoixGeneriques/Jeanne",
	"rre": "res://assets/soundEffects/voices/VoixGeneriques/Jeanne",
	"a": "res://assets/soundEffects/voices/Alain/Alain_Voice",
	"b": "res://assets/soundEffects/voices/Bernard/B_Voice",
	"c": "res://assets/soundEffects/voices/Charles/Charles"
}

func _ready(): 
	scrollbar.changed.connect(handle_scrollbar_changed)
	max_scroll_length = scrollbar.max_value

func handle_scrollbar_changed():
	if max_scroll_length != scrollbar.max_value: 
		max_scroll_length = scrollbar.max_value 
		self.scroll_vertical = max_scroll_length

@onready var DIALOGUE = preload("res://dialogue/dialogueText.tscn")
@onready var OPTIONS = preload("res://dialogue/dialogueOptionList.tscn")

var listener = null

		
func select_option(option):
	listener.select_choice(option.index)
	if option.tags:
		listener.execute_tags(option.tags)

func add_dialogue(text, type, tags):
	for t in tags:
		if t == "p":
			type = 0
		if t == "c":
			type = 2
	text_buffer.append([text, type, tags])
	
func notify_write_end():
	is_writing = false
	if tag_buffer:
		execute_tags()

func execute_tags():
	listener.execute_tags(tag_buffer)
	tag_buffer = []
	

func _process(delta):
	if text_buffer.size() and not is_writing:
		write_text_from_buffer()
	elif option_buffer.size() and not is_writing:
		write_options_from_buffer()

func write_text_from_buffer():
	var text_req = text_buffer[0]
	var text = text_req[0]
	var type = text_req[1]
	is_writing = true
	var dial = DIALOGUE.instantiate()
	dial.text = text
	dial.type = type
	dial.listener = self
	dial.center_all = center_all
	dial.tags = text_req[2]
	tag_buffer = text_req[2]
	dial.visible = true 
	
	$VBoxContainer.add_child(dial)
	if text.length() == 0:
		dial.visible = false
	
	var speaker_name = ""
	var border_color = Color(0.0, 0.0, 0.0)
	var background_color = Color(0.106, 0.322, 0.451, 0.588)
	var content_left_margin = -1
		
	# Si pas de tag, c'est nous qui parlons
	if dial.tags.is_empty():
		background_color = Color(0.036, 0.376, 0.871, 0.588)
		border_color = Color(0.0, 0.216, 0.658)
		content_left_margin = 160
		dial.change_dialog_look(border_color, background_color, content_left_margin)
		
	else:
		for tag in dial.tags:
			if tag == "rbr":
				speaker_name = "Roquebrise Radio"
				background_color = Color(0.219, 0.653, 0.438, 0.588)
				border_color = Color(0.365, 0.91, 0.776)
			if tag == "rf":
				speaker_name = "Radio Falaise"
				background_color = Color(0.273, 0.401, 0.409, 0.588)
				border_color = Color(0.391, 0.426, 0.483)
			if tag == "rre":
				speaker_name = "Radio Rêve Oeil"
				background_color = Color(0.377, 0.19, 0.611, 0.588)
				border_color = Color(0.699, 0.0, 0.666)
			if tag == "a":
				speaker_name = "Alain"
				background_color = Color(0.173, 0.408, 0.192, 0.588)
				border_color = Color(0.176, 0.753, 0.259)
			if tag == "b":
				speaker_name = "Bernard"
				background_color = Color(0.574, 0.567, 0.077, 0.588)
				border_color = Color(0.769, 0.863, 0.145)
			if TAG_SOUNDS.has(tag):
				var longueur = text.length()
				var suffixe: String
				if longueur < 40:
					suffixe = "_trescourt.mp3"
				elif longueur < 80:
					suffixe = "_court.mp3"
				elif longueur < 120:
					suffixe = "_moyen.mp3"
				else:
					suffixe = "_long.mp3"
				audio_player.stream = load(TAG_SOUNDS[tag] + suffixe)
				audio_player.play()
				
			dial.set_speaker_name("[b][i]"+speaker_name+"[/i][/b]")
			dial.change_dialog_look(border_color, background_color, content_left_margin)

	text_buffer.pop_front()
	
func write_options_from_buffer():
	var options = OPTIONS.instantiate()
	options.options = option_buffer
	options.listener = self
	$VBoxContainer.add_child(options)
	option_buffer.clear()

func add_choices(choices):
	option_buffer = choices

func clear():
	for c in $VBoxContainer.get_children():
		c.queue_free()
