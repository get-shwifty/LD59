shader_type canvas_item;
uniform float shake : hint_range(0.0, 1.0) = 0.0;
uniform float ai_takeover : hint_range(0.0, 0.2) = 0.0;
uniform float cone_angle : hint_range(0.0, 360.0) = 225.0;  
uniform float cone_width : hint_range(0.0, 360.0) = 90.0; 
uniform float cone_radius : hint_range(0.0, 1.0) = 0.5;  
uniform vec2  cone_origin = vec2(0.5, 0.5);

uniform sampler2D GLOW_TEXTURE;
uniform sampler2D BASE_TEXTURE;


float rand(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

bool inCone(vec2 ps) {
    vec2 delta = ps - cone_origin;

    float polarRadius = length(delta);
    if (polarRadius > cone_radius) return false;

    float angleDeg = degrees(atan(delta.y, delta.x));

    float startAngle = mod(cone_angle, 360.0);
    if (startAngle > 180.0){
		startAngle -= 360.0;
	}
    float endAngle = startAngle + cone_width;

    float a = angleDeg;
    if (a < startAngle){
		a += 360.0;
	}

    return a <= endAngle;
}

void fragment() {
    vec2 uv = UV;

    if (rand(vec2(TIME, 0.0)) < shake) {
        uv.r += rand(vec2(TIME, uv.y)) * ai_takeover;
    }
	float border_a = texture(BASE_TEXTURE, uv).a;
	float r,g,b,a;
	if (inCone(uv))
	{
		     r = texture(GLOW_TEXTURE, uv + vec2(0.003, 0.0)).r;
		     g = texture(GLOW_TEXTURE, uv).g;
		     b = texture(GLOW_TEXTURE, uv - vec2(0.003, 0.0)).b;
			a = texture(GLOW_TEXTURE, uv).a;
	}
	else
	{
		     r = texture(BASE_TEXTURE, uv + vec2(0.003, 0.0)).r;
		     g = texture(BASE_TEXTURE, uv).g;
		     b = texture(BASE_TEXTURE, uv - vec2(0.003, 0.0)).b;
			a = texture(BASE_TEXTURE, uv).a;
	}


    if (border_a < 0.2) {
        COLOR = texture(BASE_TEXTURE, uv);
    } else {
        float scanline = sin(uv.y * 400.0) * 0.04;
        COLOR = vec4(r - scanline, g - scanline, b - scanline, 1.0);
    }
}