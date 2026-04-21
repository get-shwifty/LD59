extends Node2D

@onready var LEVELS = $Levels
@onready var SHIPS = $Ships

func load_level(level: int):
	for child in SHIPS.get_children():
		child.free()
	var level_node = LEVELS.get_child(level)
	if not level_node:
		return
	for ship in level_node.get_children():
		var copy = ship.duplicate()
		SHIPS.add_child(copy)
		copy.start()

func _ready():
	pass
	#load_level(0)
