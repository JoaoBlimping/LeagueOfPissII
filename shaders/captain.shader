shader_type canvas_item;
render_mode unshaded,blend_mix;

uniform float speed = 2.0;

uniform vec4 gradientStart:hint_color = vec4(0.0, 0.1, 0.0, 1.0);
uniform vec4 gradientEnd:hint_color = vec4(1.0, 0.0, 0.0, 1.0);

float gamma(vec4 colour)
{
	return 0.299 * colour.r + 0.587 * colour.g + 0.114 * colour.b;
}

void fragment()
{
	vec2 point = (UV - vec2(0.5, 0.2));
	float angle = atan(point.y / point.x);
	float dist = point.y / sin(angle);
	float new = TIME * speed + dist * 3.0;
	vec2 rotated = vec2(cos(angle + new), sin(angle + new)) * dist;
	vec2 back = vec2(cos(angle + new / 2.0), sin(angle + new / 2.0)) * dist;
	float g = gamma(texture(TEXTURE,rotated));
	COLOR = min(texture(TEXTURE,back),mix(gradientEnd, gradientStart, g));
}
