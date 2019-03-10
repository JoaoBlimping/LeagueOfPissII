shader_type canvas_item;
render_mode unshaded,blend_mix;

uniform sampler2D sky;
uniform sampler2D water;
uniform float skyHeight = 0.1;
uniform vec2 waterDrift = vec2(0.0,0.0);
uniform vec2 skyDrift = vec2(0.0,0.0);
uniform float angle = 0.0;
uniform vec2 pos = vec2(0.0,0.0);


void fragment()
{
    float fov = 0.5;
    float horizon = 0.5;
    vec3 p = vec3(UV.x - horizon, fov,UV.y - horizon);
    vec2 s = vec2(p.x / p.z,p.y / p.z);
    
    float a = atan(s.y / s.x);
    float dist = s.y / sin(a);
    
    s.x = cos(a - angle) * dist; 
    s.y = sin(a - angle) * dist;
	
	  vec2 pp = vec2(pos.y,pos.x);
    
    
    
    float lambda = (UV.x / 2.0 + angle / 6.5);
    float phi = UV.y / 2.0 + 0.25 + 1.0;
    
    if (UV.y > horizon) COLOR = texture(water,s + pp + 0.2 * vec2(cos(angle + TIME + UV.y * 5.0),sin(angle + TIME + UV.y * 5.0)));
    else COLOR = texture(sky,vec2(lambda,phi));
}