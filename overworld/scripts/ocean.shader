shader_type canvas_item;
render_mode unshaded,blend_mix;


void fragment()
{
	COLOR.r = 0.5 + sin(UV.x * 6.0 - TIME * 0.3) * (1.0 - UV.y);
	COLOR.g = 0.5;
	if (UV.y < 0.5)
	{
		COLOR.b = sin(TIME);
	}
	else
	{
		COLOR.b = 0.5 +  sin(UV.y) * 0.5;
	}
}
