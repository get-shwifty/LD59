extends MarginContainer
class_name DialogeUI

@export var center_all = false
@export var SCROLL_SPEED: float = 3.0

var max_scroll_length: int = 0
@onready var scrollbar_container: ScrollContainer = $ScrollContainer
@onready var scrollbar: VScrollBar = scrollbar_container.get_v_scroll_bar()
@onready var text_children_container: VBoxContainer = %TextVBoxContainer
@onready var options_children_container: VBoxContainer = %OptionsVBoxContainer

var text_buffer = []
var option_buffer = []
var is_writing = false
var is_waiting: Node = null
var tag_buffer = []
var listener = null

@onready var audio_player: AudioStreamPlayer = $SoundsPlayer
@onready var audio_player2: AudioStreamPlayer = $SoundsPlayer2
@onready var DIALOGUE = preload("res://dialogue/dialogueText.tscn")
@onready var OPTIONS = preload("res://dialogue/dialogueOptionList.tscn")


const TAG_VOICE: Dictionary = {
	"rf": "res://assets/soundEffects/voices/radiofadaises/B_voice",
	"rro": "res://assets/soundEffects/voices/VoixGeneriques/Jeanne",
	"rbr": "res://assets/soundEffects/voices/VoixGeneriques/Jeanne",
	"a": "res://assets/soundEffects/voices/Alain/Alain_Voice",
	"b": "res://assets/soundEffects/voices/bernard/b",
	"c": "res://assets/soundEffects/voices/charles/Charles_Voice",
	"j": "res://assets/soundEffects/voices/jean/jean",
	"party": "res://assets/soundEffects/voices/party/"
}

const TAG_SOUND: Dictionary = {
	"radioon": preload("res://assets/soundEffects/Radioon-off.mp3"),
	"radiooff": preload("res://assets/soundEffects/Radioon-off.mp3"),
	"hang_up": preload("res://assets/soundEffects/raccroche.mp3"),
	"gzzz": preload("res://assets/soundEffects/voices/charles/gzzzcrchbzzcrch.mp3"),
	"u": [
		preload("res://assets/soundEffects/voices/U/U1.mp3"),
		preload("res://assets/soundEffects/voices/U/U2.mp3"),
		preload("res://assets/soundEffects/voices/U/U3.mp3"),
		preload("res://assets/soundEffects/voices/U/U4.mp3")
	]
}

const SOUND_VOLUMES: Dictionary = {
	"res://assets/soundEffects/voices/VoixGeneriques/Jeanne": 0.0,
	"res://assets/soundEffects/voices/Alain/Alain_Voice": - 4.0,
	"res://assets/soundEffects/voices/bernard/b": 0,
	"res://assets/soundEffects/voices/charles/Charles_Voice": 2.75,
	"res://assets/soundEffects/voices/radiofadaises/B_voice": - 1.4,
	"radioon": 0.75,
	"radiooff": 0,
	"u": 0
	#"res://assets/soundEffects/voices/U/U2.mp3":0,
	#"res://assets/soundEffects/voices/U/U3.mp3":0,
	#"res://assets/soundEffects/voices/U/U4.mp3":0
}


func _ready():
	scrollbar.changed.connect(handle_scrollbar_changed)
	max_scroll_length = scrollbar.max_value

func handle_scrollbar_changed():
	if max_scroll_length != scrollbar.max_value:
		max_scroll_length = scrollbar.max_value

func select_option(option):
	if is_waiting:
		clear_waiting()
	else:
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
	if text_buffer.size() > 0:
		write_waiting()
	if tag_buffer:
		execute_tags()

func execute_tags():
	listener.execute_tags(tag_buffer)
	tag_buffer = []

func play_sound(player: AudioStreamPlayer, path: String) -> void:
	player.stream = load(path)
	if SOUND_VOLUMES.has(path):
		player.volume_db = SOUND_VOLUMES[path]
	else:
		player.volume_db = 0.0
	player.play()

func _process(delta):
	if is_waiting:
		pass
	elif text_buffer.size() and not is_writing:
		write_text_from_buffer()
	elif option_buffer.size() and not is_writing:
		write_options_from_buffer()
	
	if scrollbar_container.scroll_vertical < max_scroll_length:
		var value = lerp(scrollbar_container.scroll_vertical, max_scroll_length, delta * SCROLL_SPEED)
		scrollbar_container.scroll_vertical = value
		

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
	
	if text.strip_edges(true, true).length() == 0:
		dial.visible = false
	
	text_children_container.add_child(dial)
	
	var speaker_name = ""
	var color = Color(1.0, 1.0, 1.0)
	#var border_color = Color(0.0, 0.0, 0.0)
	#var background_color = Color(0.106, 0.322, 0.451, 0.588)
	var align_right = false
	var avatar: Texture
	var voice = ""
	
	for tag in dial.tags:
		align_right = false

		if tag == "rbr":
			speaker_name = "Roquebrise Radio"
			color = Color(0.219, 0.653, 0.438)
			avatar = preload("res://assets/images/radio_portrait.png")
			#background_color = Color(0.219, 0.653, 0.438, 0.588)
			#border_color = Color(0.365, 0.91, 0.776)
		elif tag == "rf":
			speaker_name = "Radio Falaise"
			color = Color(0.273, 0.401, 0.409)
			avatar = preload("res://assets/images/radio_portrait.png")
			#background_color = Color(0.273, 0.401, 0.409, 0.588)
			#border_color = Color(0.391, 0.426, 0.483)
		elif tag == "rro":
			speaker_name = "Radio Rêve Oeil"
			color = Color(0.377, 0.19, 0.611)
			avatar = preload("res://assets/images/radio_portrait.png")
			#background_color = Color(0.377, 0.19, 0.611, 0.588)
			#border_color = Color(0.699, 0.0, 0.666)
		elif tag == "a":
			speaker_name = "Alain"
			color = Color(0.173, 0.408, 0.192)
			avatar = preload("res://assets/images/alain.png")
			#background_color = Color(0.173, 0.408, 0.192, 0.588)
			#border_color = Color(0.176, 0.753, 0.259)
		elif tag == "b":
			speaker_name = "Bernard"
			avatar = preload("res://assets/images/bernard.png")
			color = Color(0.574, 0.567, 0.077)
			#background_color = Color(0.574, 0.567, 0.077, 0.588)
			#border_color = Color(0.769, 0.863, 0.145)
		elif tag == "c":
			speaker_name = "Charles"
			avatar = preload("res://assets/images/charles.png")
			color = Color(0.701, 0.21, 0.325)
			#background_color = Color(0.701, 0.21, 0.325, 0.588)
			#border_color = Color(0.742, 0.108, 0.47, 1.0)
			align_right = true
		elif tag == "j":
			speaker_name = "Jean Fume"
			avatar = preload("res://assets/images/jean.png")
			color = Color(0.5, 0.733, 1.0)
			#background_color = Color(0.5, 0.733, 1.0, 0.471)
			#border_color = Color(0.76, 0.825, 0.955, 1.0)
		elif tag == "party":
			speaker_name = "Partygoers"
			color = Color(0.814, 0.655, 0.814)
			#background_color = Color(0.814, 0.655, 0.814, 0.471)
			#border_color = Color(0.73, 0.62, 0.687, 1.0)
		elif tag == "ship":
			speaker_name = ""
			color = Color(0.0, 0.0, 0.0)
			avatar = preload("res://assets/images/bteau_portrait.png")
			#background_color = Color(0.814, 0.655, 0.814, 0.471)
			#border_color = Color(0.73, 0.62, 0.687, 1.0)

		if TAG_VOICE.has(tag):
			voice = TAG_VOICE.get(tag)
	
	if voice:
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
		var path = voice + suffixe
		audio_player.stream = load(path)
		if SOUND_VOLUMES.has(voice):
			audio_player.volume_db = SOUND_VOLUMES[voice]
		else:
			audio_player.volume_db = 0.0
		audio_player.play()
	
	dial.set_speaker_name(speaker_name)
	dial.change_dialog_look(color, align_right, avatar)

	for tagsound in dial.tags:
		if TAG_SOUND.has(tagsound):
			var sound = TAG_SOUND[tagsound]
			if sound is Array:
				sound = sound[randi() % sound.size()]
			audio_player2.stream = sound
			if SOUND_VOLUMES.has(tagsound):
				audio_player2.volume_db = SOUND_VOLUMES[tagsound]
			else:
				audio_player2.volume_db = 0.0
			audio_player2.play()
		
	text_buffer.pop_front()
	
func write_options_from_buffer():
	var options = OPTIONS.instantiate()
	options.options = option_buffer
	options.listener = self
	options_children_container.add_child(options)
	option_buffer.clear()

func write_waiting():
	var options = OPTIONS.instantiate()
	var next = InkChoice.new()
	next.text = "..."
	options.options = [next]
	options.listener = self
	options_children_container.add_child(options)
	is_waiting = options

func clear_waiting():
	is_waiting.queue_free()
	is_waiting = null
	

func add_choices(choices):
	option_buffer = choices

func clear():
	#text_buffer.clear()
	#option_buffer.clear()
	for c in text_children_container.get_children():
		c.queue_free()
	for c in options_children_container.get_children():
		c.queue_free()

func clean_text(text: String):
	text = text.replace("__", "[i]")
	text = text.replace("_", "[/i]")
	text = text.replace("**", "[b]")
	text = text.replace("*", "[/b]")

	return text
