extends Node2D

@onready var LEVELS = $Levels
@onready var SHIPS = $Ships

func load_level(level: int):
	var children = SHIPS.get_children()
	for child in children:
		child.free()
	var id = 0
	var ships = LEVELS.get_child(level)
	for ship in ships.get_children():
		ship.reparent(SHIPS)
		ship.id = id
		ship.start()
		id+=1
		
func _ready():
	load_level(0)
