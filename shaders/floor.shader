shader_type canvas_item;
render_mode unshaded,blend_mix;

uniform sampler2D ground;
uniform sampler2D overlay;
uniform float speed = -3.0;
uniform float fov = 1.0;
uniform float swing = 2.0;
uniform vec4 modulator: hint_color = vec4(1.0, 1.0, 1.0, 1.0);


void fragment()
{
	float horizon = 0.4;
	
	vec3 p = vec3(UV.x - 0.5, fov, UV.y - horizon);      
	vec2 s = vec2(p.x/p.z,p.y/p.z);
	
	COLOR = texture(ground,s - vec2(0, TIME * speed));
	COLOR = mix(COLOR, texture(overlay, UV), texture(overlay, UV).a);
}