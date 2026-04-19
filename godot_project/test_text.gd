extends Node2D

@onready var _ink_player: InkPlayer = $InkPlayer
@onready var game_dialogue: DialogeUI = $"DialogueUi"
@onready var dialogue = game_dialogue


func _ready():
	_ink_player.loaded.connect(_story_loaded)
	_ink_player.create_story()


func _story_loaded(successfully: bool):
	if !successfully:
		return

	_continue_story()


func _continue_story():
	while _ink_player.can_continue:
		print('loop')
		var text = _ink_player.continue_story()

		# This text is a line of text from the ink story.
		# Set the text of a Label to this value to display it in your game.
		print('text')
		print(text)
		
		print(_ink_player.current_tags)
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
