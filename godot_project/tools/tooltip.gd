extends PanelContainer

const OFFSET: Vector2 = Vector2.ONE * 20

func _input(event: InputEvent) -> void:
	if visible and event is InputEventMouseMotion:
		# On veut que le tooltip apparaisse même si on se rapproche du bord de l'écran (oui, c'est sale)
		if get_global_mouse_position()[0] + OFFSET[0] + 200 >= 1280:
			global_position[0] = get_global_mouse_position()[0] - (OFFSET[0] + 200) 
			global_position[1] = get_global_mouse_position()[1] + OFFSET[1]
		else:
			global_position = get_global_mouse_position() + OFFSET
