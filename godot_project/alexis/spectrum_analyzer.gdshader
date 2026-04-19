shader_type canvas_item;

const int VU_COUNT = 16;
const float segment_count = 10.0;

 
uniform vec3 background_color = vec3(0.09, 0.15, 0.18);
uniform vec3 display_color = vec3(0.86, 0.67, 0.02);
uniform float[VU_COUNT] freq_data;

void fragment() {
	float vu_count = float(VU_COUNT);
	vec2 uv = vec2(UV.x, 1.0 - UV.y); // transform
	// TODO transform (tilt)
	
	if (uv.x >= 0.0 && uv.y >= 0.0 && uv.x <= 1.0 && uv.y <= 1.0) {
		vec2 pos = vec2(floor(uv.x * vu_count) / vu_count, floor(uv.y * segment_count) / segment_count);
		float fft = freq_data[int(uv.x * vu_count)];
		
		float mask = pos.y < fft ? 1.0 : 0.0;
		vec2 dist = fract((uv - pos) * vec2(vu_count, segment_count)) - 0.5;
		float led = smoothstep(0.5, 0.4, abs(dist.x)) * smoothstep(0.5, 0.4, abs(dist.y));
		
		COLOR.rgb = mix(background_color, display_color, led * mask);
	} else {
		COLOR.a = 0.0;
	}
}