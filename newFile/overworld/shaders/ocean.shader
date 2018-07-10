shader_type canvas_item;
render_mode unshaded,blend_mix;


void fragment()
{
	float x = UV.x + sin(UV.y * 30.0 + TIME * 3.0) / 50.0;
	float y = UV.y;

	
	COLOR.r = 0.25 + sin(x * 6.0 - TIME * 0.3) * (1.0 - y);
	COLOR.g = 0.5;
	if (y < 0.5)
	{
		COLOR.b = 1.0;
	}
	else
	{
		COLOR.b = 0.5 +  sin(y) * 0.5;
	}
}
