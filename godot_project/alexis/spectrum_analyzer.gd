extends Node2D

const VU_COUNT = 16
const FREQ_MAX = 2500 # 11050.0
const MIN_DB = 60
const ANIMATION_SPEED = 0.1

@onready var color_rect: ColorRect = $ColorRect
@onready var shader: ShaderMaterial = color_rect.get_material()

var spectrum: AudioEffectSpectrumAnalyzerInstance
var min_values = []
var max_values = []

func _ready():
	var radio_bus = AudioServer.get_bus_index("Radio")
	if radio_bus >= 0:
		spectrum = AudioServer.get_bus_effect_instance(radio_bus, 0)
		min_values.resize(VU_COUNT)
		min_values.fill(0.0)
		max_values.resize(VU_COUNT)
		max_values.fill(0.0)

func _process(delta):
	if not spectrum:
		return
	
	var prev_hz = 0
	var data = []
	for i in range(VU_COUNT):
		var hz = (i + 1) * FREQ_MAX / VU_COUNT
		var f = spectrum.get_magnitude_for_frequency_range(prev_hz, hz)
		var energy = clamp((MIN_DB + linear_to_db(f.length())) / MIN_DB, 0.0, 1.0)
		prev_hz = hz
		
		#energy *= 8.0
		#max_values[i] = lerp(max_values[i], energy, 1.0 if energy > max_values[i] else ANIMATION_SPEED)
		#min_values[i] = lerp(min_values[i], 0.0, 0.0 if energy <= 0 else ANIMATION_SPEED)
		#data.append(lerp(0.0, max_values[i], ANIMATION_SPEED))
		
		max_values[i] += clampf(energy - max_values[i], -ANIMATION_SPEED, ANIMATION_SPEED) * ANIMATION_SPEED
		data.append(max_values[i])

	shader.set_shader_parameter("freq_data", data)
