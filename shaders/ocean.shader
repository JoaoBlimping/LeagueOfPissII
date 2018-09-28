shader_type canvas_item;
render_mode unshaded,blend_mix;

uniform sampler2D sky;
uniform float angle = 0.0;
uniform vec2 pos = vec2(0.0,0.0);


void fragment()
{
    float fov = 0.2;
    float horizon = 0.5;
    vec3 p = vec3(UV.x - horizon, fov,UV.y - horizon);
    vec2 s = vec2(p.x / p.z,p.y / p.z);
    
    float a = atan(s.y / s.x);
    float dist = s.y / sin(a);
    
    s.x = cos(a - angle) * dist; 
    s.y = sin(a - angle) * dist;
	
	vec2 pp = vec2(pos.y,pos.x);
    
    if (UV.y > horizon) COLOR = texture(TEXTURE,s + pp / 2.0 + vec2(0.0,tan(s.x * 5.0 + TIME) * 0.1));
    else COLOR = mix(texture(sky,s - pp / 15.0 + vec2(TIME * 0.1,TIME * 0.3)),vec4(0.0,0.2,0.5,0.7),UV.y * UV.y);
}