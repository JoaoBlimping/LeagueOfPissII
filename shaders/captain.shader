shader_type canvas_item;
render_mode unshaded,blend_mix;

void fragment()
{
	vec2 point = abs(UV - 0.5);
	float angle = atan(point.y / point.x);
	float dist = point.y / sin(angle);
	float new = TIME + dist * 2.0;
	vec2 rotated = vec2(cos(angle + new),sin(angle + new)) * dist;
	vec2 back = vec2(cos(angle + new / 2.0),sin(angle + new / 2.0)) * dist;
	
	COLOR = max(texture(TEXTURE,back),texture(TEXTURE,rotated));
}