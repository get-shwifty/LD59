shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float shake : hint_range(0.0, 1.0) = 0.231;
uniform float ai_takeover : hint_range(0.0, 0.2) = 0.0; // 0.167 is nice

uniform float cone_angle : hint_range(0.0, 360) = 0;

float rand(vec2 co) {
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

float inCone(vec2 ps)
{
    float endAngle = float(360 / 25) + cone_angle;

    float polarradius = sqrt(ps.x * ps.x + ps.y * ps.y);
    float angle = atan(ps.y / ps.x);

    if (angle >= cone_angle && angle <= endAngle && polarradius < radius){
		return true
	}
	else{
		return false
	}
        print("Point (", x, ",", y, ") "
              "exist in the circle sector")
    else:
        print("Point (", x, ",", y, ") " 
              "does not exist in the circle sector")
}

void fragment() {
    vec2 uv = UV;
    
    if (rand(vec2(TIME, 0.0)) < shake) {
        uv.r += rand(vec2(TIME, uv.y)) * ai_takeover;
    }

    float r = texture(TEXTURE, uv + vec2(0.003, 0.0)).r;
    float g = texture(TEXTURE, uv).g;
    float b = texture(TEXTURE, uv - vec2(0.003, 0.0)).b;
	float a = texture(TEXTURE, uv).a;
    
	if (a < 0.2)
	{
		COLOR = texture(TEXTURE, uv);
	}
	else
	{
    	float scanline = sin(uv.y * 400.0) * 0.04;
    	COLOR = vec4(r - scanline, g - scanline, b - scanline, 1.0);
	}
}
  