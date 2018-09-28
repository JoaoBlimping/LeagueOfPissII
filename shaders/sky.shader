shader_type canvas_item;
render_mode unshaded,blend_mix;

uniform sampler2D ground;
uniform float power = 0.1;


void fragment()
{
	float fov = 0.3;
	float horizon = 0.5;
	
	vec3 p = vec3(UV.x - 0.5, fov, UV.y - horizon);      
	vec2 s = vec2(p.x/p.z,p.y/p.z);
	
	float a = atan(s.y / s.x);
	float dist = s.y / sin(a);
	s.x = cos(a - TIME * 0.3) * dist; 
    s.y = sin(a - TIME * 0.3) * dist;
	
	vec2 move = vec2(0,TIME * 3.0);
	
	if (UV.y > horizon) COLOR = texture(TEXTURE,s - move);
	else COLOR = texture(TEXTURE,s + move);
	COLOR.rgb = mix(vec3(1.0,0.9,0.6), COLOR.rgb, abs(p.z * 5.0));
}