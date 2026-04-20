shader_type canvas_item;

const int VU_COUNT = 14;
const float segment_count = 10.0;

 
uniform vec3 background_color = vec3(0.0, 0.62, 0.02);
uniform vec3 display_color = vec3(1.0, 1.0, 1.0);
uniform float[VU_COUNT] freq_data;
uniform float squeeze_left : hint_range(0.0, 0.5, 0.01) = 0.2;

void fragment() {
	float vu_count = float(VU_COUNT);
	float squeeze_amount = squeeze_left * (1.0 - UV.x);
	vec2 uv = vec2(UV.x, 1.0 - UV.y * (1.0 + 2.0 * squeeze_amount) + squeeze_amount);

	COLOR.a = step(0.0, uv.y) * step(uv.y, 1.0);

	vec2 pos = vec2(floor(uv.x * vu_count) / vu_count, floor(uv.y * segment_count) / segment_count);
	float fft = freq_data[int(uv.x * vu_count)];
	
	float mask = pos.y < fft ? 1.0 : 0.0;
	vec2 dist = fract((uv - pos) * vec2(vu_count, segment_count)) - 0.5;
	float led = smoothstep(0.5, 0.3, abs(dist.x)) * smoothstep(0.5, 0.3, abs(dist.y));
	
	COLOR.rgb = mix(background_color, display_color, led * mask);
}