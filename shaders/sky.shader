shader_type canvas_item;
render_mode unshaded,blend_mix;

uniform sampler2D ground;
uniform float power = 0.1;


void fragment()
{
	float fov = 0.3;
	float horizon = 0.5;
	float scaling = 1.0;
	
	vec3 p = vec3(UV.x - 0.5, fov, UV.y - horizon);      
	vec2 s = vec2(p.x/p.z, p.y/p.z + TIME * 2.0) * scaling;
	
	
	vec3 plane = vec3(UV.x - 0.5,0.3,UV.y - 0.5);
	vec2 floorPlane = vec2(UV.x,UV.y - TIME * 0.1);
	COLOR = max(texture(TEXTURE,s),texture(ground,floorPlane));
	COLOR.rgb = mix(vec3(1.0,0.9,0.6), COLOR.rgb, abs(p.z * 2.0));
}