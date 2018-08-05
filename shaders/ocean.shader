shader_type canvas_item;
render_mode unshaded,blend_mix;

uniform sampler2D sky;
uniform float angle = 0.0;
uniform vec2 pos;


void fragment()
{
	float fov = sin(TIME) * 0.1 + 0.5;
	float horizon = 0.5;
	float scaling = 1.0;
	
	vec3 p = vec3(UV.x - 0.5, fov, UV.y - horizon);      
	vec2 s = vec2(p.x/p.z, p.y/p.z) * scaling;
	
	if (UV.y > horizon) COLOR = texture(TEXTURE,s);
	else COLOR = texture(sky,s);
}