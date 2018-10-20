shader_type canvas_item;
render_mode unshaded,blend_mix;

uniform sampler2D ground;
uniform float speed = 3.0;
uniform float fov = 1.0;
uniform float swing = 2.0;
uniform vec4 modulator: hint_color = vec4(1.0, 1.0, 1.0, 1.0);


void fragment()
{
	float horizon = 0.0;
	
	vec3 p = vec3(UV.x - 0.5, fov, UV.y - horizon);      
	vec2 s = vec2(p.x/p.z,p.y/p.z);
	
	vec4 high = texture(TEXTURE,s - vec2(sin(UV.y * 5.0 + TIME * 2.0) * swing,TIME * 3.0));
	vec4 low = texture(TEXTURE,s - vec2(sin(UV.y * 5.0 + TIME * 1.0) * swing * 0.5,TIME * 2.0));
	
	if (UV.y > horizon) COLOR = min(high,low);
	COLOR = mix(vec4(0.0, 0.0, 0.0, 1.0), COLOR, abs(p.z)) * modulator;
}