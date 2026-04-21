extends Node

var game_started = false
var day_number = 1
const POSSIBLE_BOATS = ["BA45", "AX25", "AA00", "DE26",
"AA48",
"CB37",
"EB13",
"ED38",
"BA28",
"CE08"]
var talking_boat = ""
var pathfinder: Pathfinder
var event_to_call = ""
var radar_game: RadarGame
var night
