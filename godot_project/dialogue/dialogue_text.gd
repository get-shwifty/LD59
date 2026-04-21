extends Control

@onready var text_label_node: RichTextLabel = $TextMarginContainer/RichTextLabel
@onready var name_label_node: RichTextLabel = $NameMarginContainer/RichTextLabel
@onready var timer_node: Timer = $Timer

@onready var text_bg: NinePatchRect = $TextMarginContainer/NinePatchRect
@onready var name_bg: NinePatchRect = $NameMarginContainer/NinePatchRect
@onready var avatar_bg: TextureRect = $AvatarMarginContainer/TextureRect

@onready var text_container: MarginContainer = $TextMarginContainer
@onready var name_container: MarginContainer = $NameMarginContainer
@onready var avatar_container: MarginContainer = $AvatarMarginContainer


################################## Var
var type = 0
var text = ''
var text_buffer = ''
var speed = 4
var listener = null
var center_all = false
var tags = null
var final_text = ''

func write_to_ui():
	var res = final_text
	if center_all:
		res = '[center]' + final_text + '[/center]'
	text_label_node.text = res

func _ready():
	text_buffer = text
	write_to_ui()
	#if text_buffer.length() == 0:
	#	listener.notify_write_end()
	return

	var style = self.get_theme_stylebox("panel")
	
	if type == 0:
		style.content_margin_left = 100.0
		style.content_margin_right = 20.0
		#style.bg_color = Color(83/255.0, 80/255.0, 158/255.0)
	if type == 1:
		style.content_margin_left = 50.0
		style.content_margin_right = 50.0
		#style.bg_color = Color(0,0,0,0)
	if type == 2:
		style.content_margin_left = 20.0
		style.content_margin_right = 100.0
		#style.bg_color = Color(41/255.0, 40/255.0, 78/255.0)

func write_to_text():
	var to_write_n = min(speed, text_buffer.length())
	var to_write = text_buffer.left(to_write_n)
	text_buffer = text_buffer.erase(0, to_write_n)
	final_text += to_write
	write_to_ui()
	if text_buffer.length() == 0:
		listener.notify_write_end()
		timer_node.stop()


func _process(delta):
	if Input.is_action_just_pressed("enter"):
		write_all_buffer()
	elif Input.is_action_just_pressed("right_click"):
		write_all_buffer()
		
func write_all_buffer():
	if text_buffer.length() == 0:
		return
	speed = 1000000
	write_to_text()

func _on_timer_timeout():
	if text_buffer.length():
		write_to_text()
	else:
		# Si jamais on n'a pas de texte, mais directement une option, il faut que l'on passe à autre chose
		listener.notify_write_end()
		timer_node.stop()

func set_speaker_name(name: String):
	name_label_node.text = name
	

func change_dialog_look(color: Color, align_right: bool, avatar: Texture):
	#text_bg.self_modulate = color
	#name_bg.self_modulate = color
	#avatar_bg.self_modulate = color
	%Avatar.texture = avatar
	name_label_node.add_theme_color_override("default_color", color)
	if align_right:
		%Avatar.flip_h = not %Avatar.flip_h
		self.add_theme_constant_override("margin_left", self.get_theme_constant("margin_right"))
		self.add_theme_constant_override("margin_right", 0)
		name_container.size_flags_horizontal |= Control.SIZE_SHRINK_END
		avatar_container.size_flags_horizontal |= Control.SIZE_SHRINK_END
		text_container.add_theme_constant_override("margin_right", text_container.get_theme_constant("margin_left"))
		text_container.add_theme_constant_override("margin_left", 0)
		
		var style = text_label_node.get_theme_stylebox("normal")
		var content_margin_left = style.content_margin_left
		style.content_margin_left = style.content_margin_right
		style.content_margin_right = content_margin_left

	#var style = self.get_theme_stylebox("panel")
	#style.border_color = border_color
	#style.bg_color = bg_color
	#style.content_margin_left = content_left_margin
