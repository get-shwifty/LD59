extends Node2D

################################## On Ready
@onready var minutes_lab = $Minute
@onready var hours_lab = $Hour
@onready var timer = Timer.new()

################################## Const
const START_NIGHT = 21
const NIGHT_DURATION_HOURS = 2
const HALF_HOUR_DURATION_SECS = 1

################################## Var
var total_minutes = START_NIGHT * 2 * 30 # On veut commencer la nuit à une heure donnée
var total_hours = 0

################################## Signals
signal end_night

func _ready() -> void:
	add_child(timer)
	timer.set_one_shot(false)
	timer.set_wait_time(HALF_HOUR_DURATION_SECS)
	timer.connect("timeout", _on_timeout)

func _on_timeout() -> void:
	total_minutes += 30
	var hours = floor(total_minutes / 60) % 24
	var minutes = total_minutes % 60
	total_hours = (total_minutes /60) - START_NIGHT
	
	hours_lab.text = "%02d" % [hours]
	minutes_lab.text = "%02d" % [minutes]
	
	if total_hours >= NIGHT_DURATION_HOURS:
		timer.stop()
		emit_signal("end_night")
	else:
		timer.start()
		

func start_timer():
	timer.paused = false
	timer.start()
	
func pause_timer():
	timer.paused = true
	
func restart_timer():
	timer.paused = false
	
func stop_timer():
	timer.paused = false
	timer.stop()

func reset_timer():
	timer.paused = false
	total_minutes = START_NIGHT * 2 * 30
	total_hours = 0
	hours_lab.text = "%02d" % [START_NIGHT]
	minutes_lab.text = "00"
