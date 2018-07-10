shader_type canvas_item;
render_mode unshaded,blend_mix;


void fragment()
{
	float x = UV.x + UV.y * 2.0 * sin(TIME);
	float y = UV.y + UV.x * sin(TIME) * 5.0;
	
	COLOR.r = y * 1.5 + sin(x * 10.0 + TIME * 5.0) * 0.2;
	COLOR.g = y;
	COLOR.b = 1.0 - y / 4.0;
}
