extends Node2D

@onready var start_game_button = $StartGame
@onready var end_day_button = $EndDay
@onready var day_number = $DayNumber
@onready var _ink_player: InkPlayer = $InkPlayer
@onready var game_dialogue: DialogeUI = $"DialogueUi"
@onready var dialogue = game_dialogue

func _ready() -> void:
	if Global.game_started == false:
		start_game_button.visible = false  # A retirer si on n'en a plus besoin
		Global.game_started = true
	else:
		Global.day_number += 1 
		start_game_button.visible = false  # A retirer si on n'en a plus besoin
		start_day()
	game_dialogue.listener = self
	_ink_player.loaded.connect(_story_loaded)
	_ink_player.create_story()

func _process(delta: float) -> void:
	day_number.text = "Day %0*d" % [2, Global.day_number]

func _on_start_game_pressed() -> void:
	start_game_button.visible = false
	start_day()
	
func start_day() -> void:
	end_day_button.visible = true

func _on_end_day_pressed() -> void:
	get_tree().change_scene_to_file("res://night.tscn")


func _story_loaded(successfully: bool):
	if !successfully:
		return
	_continue_story()

func select_choice(index: int):
	_ink_player.choose_choice_index(index)
	await get_tree().physics_frame
	_continue_story()

func execute_tags(tags):
	for t in tags:
		pass
	# TO DO : écrire le code pour chaque type de tag

func _continue_story():
	while _ink_player.can_continue:
		print('loop')
		var text = _ink_player.continue_story()

		# This text is a line of text from the ink story.
		# Set the text of a Label to this value to display it in your game.
		print('text')
		text = text.replace("__","[i]")
		text = text.replace("_","[/i]")
		print(text)
		
		var type = 1
		var tags = _ink_player.current_tags
		dialogue.add_dialogue(text, type, tags)

		if _ink_player.has_choices:
			var choices = _ink_player.current_choices
			for c in choices:
				print(c.text + '   ' + str(c.tags))
			dialogue.add_choices(choices)

		else:
			# This code runs when the story reaches it's end.
			print("The End")
	print(_ink_player.can_continue)
