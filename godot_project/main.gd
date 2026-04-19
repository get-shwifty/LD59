extends Node2D

@onready var _ink_player: InkPlayer = $InkPlayer
@onready var game_dialogue: DialogeUI = $"DialogueUi"
@onready var dialogue = game_dialogue

func _ready() -> void:
	Global.game_started = true
	game_dialogue.listener = self
	_ink_player.loaded.connect(_story_loaded)
	_ink_player.create_story()

func _process(delta: float) -> void:
	pass
	

func _story_loaded(successfully: bool):
	if !successfully:
		return
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
		if tag == "day_begin":
			start_of_day()

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


func end_of_day():
	game_dialogue.visible = false
	game_dialogue.clear()
	$Day.visible = false
	$Day.next_day()
	
	$Night.visible = true
	game_dialogue.visible = true

func start_of_day():
	game_dialogue.visible = false
	game_dialogue.clear()
	$Night.visible = false
	
	$Day.visible = true
	game_dialogue.visible = true
