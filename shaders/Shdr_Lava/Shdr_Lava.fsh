//
// Simple passthrough fragment shader
//

const float PI = 3.14159265;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vPosition;
uniform float u_time;
uniform float u_resw;
uniform float u_resh;
uniform float u_camx;
uniform float u_camy;

float signed2unsigned(float inVal)
{
    return (inVal+1.)/2.;
}

void main()
{
	
	float time = u_time / 1000.;

	vec2 pos = v_vPosition.xy - vec2(u_camx, u_camy);
    float val1, val2, val;
	
	val1 = signed2unsigned(sin(dot(pos, vec2(sin(time),cos(time)))*.005+time));
	
	vec2 center = vec2(u_resw, u_resh)/2. + vec2(u_resw/2.*sin(-time), u_resh/2.*cos(-time));
	
	val2 = signed2unsigned(cos(length(pos - center)*.0075));
	
	val = (val1+val2)/2.;
	
	float red	= signed2unsigned(cos(PI*val/.5+time));
	float green	= signed2unsigned(sin(PI*val/.5+time));
	float blue	= .3 * signed2unsigned(sin(time)) + .5;
	
    gl_FragColor = vec4(red, green, blue, 1.);
}
