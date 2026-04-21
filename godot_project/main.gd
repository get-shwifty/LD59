extends Node2D

@export var state: String

@onready var _ink_player: InkPlayer = $InkPlayer
@onready var game_dialogue: DialogeUI = $"DialogueUi"
@onready var dialogue = game_dialogue
@onready var music_player: AudioStreamPlayer = $MusicPlayer
@onready var is_night = false
@onready var night_timer = $Night/UI/Clock

const MUSIC_DAY = preload("res://assets/music/Ludum59_ThemeJour_V1.ogg")
const MUSIC_NIGHT = preload("res://assets/music/Ludum59_ThemeNuit_SansBasse.ogg")
const FADE_DURATION = 1

@onready var sav_position_dialog_UI = $DialogueUi.position
@onready var sav_size_dialog_UI = $DialogueUi.size
@onready var sav_position_camera = $"Night/Camera2D".position

var saved_state = null
var actual_level = 5

func _ready() -> void:
	Global.game_started = true
	game_dialogue.listener = self
	_ink_player.loaded.connect(_story_loaded)
	_ink_player.create_story()
	$Night/UI/Radio.connect("contact_boat", _contact_boat)
	$Night.connect("switch_to_day",start_of_day)
	$Night/UI/Radio.connect("call_from_ship",call_from_ship)
	

func _process(delta: float) -> void:
	if is_night:
		$DialogueUi.size.y = 400
		$DialogueUi.position.x = $Night/Camera2D.position.x - 245
		$DialogueUi.position.y = $Night/Camera2D.position.y - 300
	else:
		$DialogueUi.position = sav_position_dialog_UI
		$DialogueUi.size = sav_size_dialog_UI
	

func _story_loaded(successfully: bool):
	if !successfully:
		return
	music_player.stream = MUSIC_DAY
	music_player.play()
	
	if state:
		_ink_player.set_state(state)
		end_of_day()
	
	_continue_story()

func select_choice(index: int):
	_ink_player.choose_choice_index(index)
	await get_tree().physics_frame
	_continue_story()

func execute_tags(tags):
	for tag in tags:
		if tag == "title_screen":
			$Day.display_game_title(game_dialogue)
		if tag == "day_end":
			end_of_day()
		if tag == "hang_up":
			hang_up()
		if tag in ["N","S", "E", "W", "P"]:
			$Night._on_order_sent(tag)
		if tag.contains("display_"):
			$Day.display_object(tag)

func _continue_story():
	while _ink_player.can_continue:
		var text = _ink_player.continue_story()
		text = dialogue.clean_text(text)
		var type = 1
		var tags = _ink_player.current_tags
		dialogue.add_dialogue(text, type, tags)
		
		if _ink_player.has_choices:
			var choices = _ink_player.current_choices
			var isNightHub = false
			var regex = RegEx.new()
			regex.compile("\\d\\d[a-zA-Z]")
			for c in choices:
				if (c.text in Global.POSSIBLE_BOATS):
					isNightHub = true
					break
				if regex.search(c.text):
					Global.event_to_call = c.text
					break
				c.text = dialogue.clean_text(c.text)
			if (!isNightHub):
				dialogue.add_choices(choices)

		else:
			pass
	#print(_ink_player.can_continue)

func play_music(new_stream: AudioStream) -> void:
	var tween = create_tween()
	tween.tween_property(music_player, "volume_db", -99, FADE_DURATION)
	await tween.finished
	music_player.stream = new_stream
	music_player.volume_db = 0
	music_player.play()

func end_of_day():
	print(_ink_player.get_state())
	saved_state = _ink_player.get_state()
	# Fin du jour
	
	game_dialogue.visible = false
	is_night = true
	game_dialogue.clear()
	$Day.visible = false
	$Day.next_day()
	
	# Début de la nuit
	$Night.reset_cone_rotation_degrees()
	$Night.visible = true
	night_timer.reset_timer()
	night_timer.start_timer()
	play_music(MUSIC_NIGHT)
	print("current day: ", Global.day_number)
	$Night.load_level(actual_level)
	actual_level +=1
	

func start_of_day():
	# On remet la scène Night comme il faut
	is_night = false
	game_dialogue.visible = false
	$Night.visible = false
	night_timer.stop_timer()
	night_timer.reset_timer()
	$Night/Camera2D.position = sav_position_camera
	Global.talking_boat = ""
	Global.event_to_call = ""
	$Night/UI/NextDay.visible = false
	game_dialogue.clear()
	
	# On prépare la scène day
	$Day.visible = true
	for c in _ink_player.current_choices:
		if c.text == "Finish Night":
			select_choice(c.index)
	
	game_dialogue.visible = true
	play_music(MUSIC_DAY)

func _contact_boat(boat_code):
	var choices = _ink_player.current_choices
	var choice_index = -1;
	var found_boat = false;
	for c in choices:
		choice_index += 1;
		print(c.text)
		if (boat_code == c.text):
			found_boat = true
			print('contacting boat' + c.text)
			night_timer.pause_timer()
			break
	
	if (!found_boat):
		return 
	
	game_dialogue.visible = true
	$Night.pause_game()
	select_choice(choice_index)

func hang_up():
	game_dialogue.visible = false
	dialogue.clear()
	night_timer.restart_timer()
	$Night/UI/Radio.quit_call()
	$Night.play_game()

func call_from_ship(event: String):
	var choices = _ink_player.current_choices
	for c in choices:
		if c.text == event:
			night_timer.pause_timer()
			game_dialogue.clear()
			game_dialogue.visible = true
			select_choice(c.index)
			break
	$Night.pause_game()
	
func retry():
	_ink_player.set_state(saved_state)
	$Night.reset_cone_rotation_degrees()
	$Night.visible = true
	night_timer.reset_timer()
	night_timer.start_timer()
	play_music(MUSIC_NIGHT)
	print("current day: ", Global.day_number)
	$Night.load_level(actual_level-1)
	_ink_player.continue_story()
	
	


func _on_night_failed():
	retry()
