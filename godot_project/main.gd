extends Node2D

@onready var _ink_player: InkPlayer = $InkPlayer
@onready var game_dialogue: DialogeUI = $"DialogueUi"
@onready var dialogue = game_dialogue
@onready var music_player: AudioStreamPlayer = $MusicPlayer
@onready var is_night = false
@onready var sav_position_dialog_UI = $DialogueUi.position
@onready var night_timer = $Night/UI/Clock

const MUSIC_DAY = preload("res://assets/music/Ludum59_ThemeJour_V1.ogg")
const MUSIC_NIGHT = preload("res://assets/music/Ludum59_ThemeNuit_SansBasse.ogg")
const FADE_DURATION = 1


func _ready() -> void:
	Global.game_started = true
	game_dialogue.listener = self
	_ink_player.loaded.connect(_story_loaded)
	_ink_player.create_story()
	$Night/UI/Radio.connect("contact_boat", _contact_boat)
	$Night.connect("switch_to_day",start_of_day)
	

func _process(delta: float) -> void:
	if is_night:
		$DialogueUi.position = sav_position_dialog_UI
	else:
		$DialogueUi.position = $Night/Camera2D.position
	

func _story_loaded(successfully: bool):
	if !successfully:
		return
	music_player.stream = MUSIC_DAY
	music_player.play()
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

func _continue_story():
	while _ink_player.can_continue:
		print('loop')
		var text = _ink_player.continue_story()

		# This text is a line of text from the ink story.
		# Set the text of a Label to this value to display it in your game.
		print('text')
		text = text.replace("__","[i]")
		text = text.replace("_","[/i]")
		text = text.replace("**","[b]")
		text = text.replace("*","[/b]")
		print(text)
		
		var type = 1
		var tags = _ink_player.current_tags
		dialogue.add_dialogue(text, type, tags)
		
		if _ink_player.has_choices:
			var choices = _ink_player.current_choices
			var isNightHub = false;
			for c in choices:
				if (c.text in Global.POSSIBLE_BOATS):
					isNightHub = true;
					break;
				print(c.text + '   ' + str(c.tags))
			if (!isNightHub):
				dialogue.add_choices(choices)

		else:
			# This code runs when the story reaches it's end.
			print("The End")
	print(_ink_player.can_continue)

func play_music(new_stream: AudioStream) -> void:
	var tween = create_tween()
	tween.tween_property(music_player, "volume_db", -99, FADE_DURATION)
	await tween.finished
	music_player.stream = new_stream
	music_player.volume_db = 0
	music_player.play()

func end_of_day():
	# Fin du jour
	game_dialogue.visible = false
	is_night = true
	game_dialogue.clear()
	$Day.visible = false
	$Day.next_day()
	
	# Début de la nuit
	$Night.visible = true
	night_timer.start_timer()
	play_music(MUSIC_NIGHT)
	remove_child($DialogueUi)
	$Night/UI.add_child(game_dialogue)
	print("current day: ", Global.day_number)
	$Night.load_level(Global.day_number-1)
	

func start_of_day():
	# On remet la scène Night comme il faut
	is_night = false
	game_dialogue.visible = false
	$Night.visible = false
	night_timer.stop_timer()
	
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
		if (boat_code == c.text):
			found_boat = true
			print('contacting boat' + c.text)
			night_timer.pause_timer()
			break
	
	if (!found_boat):
		return 
	
	game_dialogue.visible = true
	select_choice(choice_index)


func hang_up():
	dialogue.clear()
	night_timer.restart_timer()
	
