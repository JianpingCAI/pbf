#version 430 core

layout (binding = 0) uniform sampler2D input;
layout (location = 0) out vec4 color;

// input from vertex shader
in vec2 fTexcoord;

// blur weights
layout (std430, binding = 0) readonly buffer Weights {
	vec2 weights[];
};

// offset scale indicating input size and blur direction
uniform vec2 offsetscale;

void main(void)
{
	vec4 c;
	// sum weighted data
	c = texture (input, fTexcoord) * weights[0].r;
	for (int i = 1; i < weights.length (); i++)
	{
		c += texture (input, fTexcoord + weights[i].g * offsetscale) * weights[i].r;
		c += texture (input, fTexcoord - weights[i].g * offsetscale) * weights[i].r;
	}
	
	// output resulting color
	color = c;
}
