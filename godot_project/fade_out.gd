extends Node

@onready var music: AudioStreamPlayer = $MusicDay

func fade_out(duration: float = 1) -> void:
	music.volume_db = 0
	var silence = create_tween()
	silence.tween_property(music, "volume_db", -100, duration)\
		.set_trans(Tween.TRANS_LINEAR)
	silence.silence_callback(music.stop)	
	
func end_day_or_night():
	fade_out(3)
