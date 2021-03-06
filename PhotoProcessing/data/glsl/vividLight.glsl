#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

// viewport resolution (in pixels)
uniform vec2  sketchSize;      

// Textures to blend
uniform sampler2D sourceImage; 
uniform sampler2D backdropImage; 

// Resolution of the textures
uniform vec2 sourceImageResolution;
uniform vec2 backdropImageResolution;


float vividLight( float s, float b )
{
	return (s < 0.5) ? 1.0 - (1.0 - b) / (2.0 * s) : b / (2.0 * (1.0 - s));
}

// Mixing function
vec3 mixing(vec3 b, vec3 s) {
	vec3 c;
	c.x = vividLight(s.x,b.x);
	c.y = vividLight(s.y,b.y);
	c.z = vividLight(s.z,b.z);
	return c;
}


void main(void)
{
	vec2 uv = gl_FragCoord.xy / sketchSize.xy * vec2(1.0,-1.0) + vec2(0.0, 1.0);
	
	// Sample the source texture (upper layer) note: y axis is mirrored because of Processing's inverted coordinate system
	vec2 sPos = vec2( gl_FragCoord.x / sourceImageResolution.x, 1.0 - (gl_FragCoord.y / sourceImageResolution.y) );
	vec4 s = texture2D(sourceImage, sPos ).rgba;

	
	// Sample the backdrop texture (lower layer) note: y axis is mirrored because of Processing's inverted coordinate system
    vec2 bPos = vec2( gl_FragCoord.x / backdropImageResolution.x, 1.0 - (gl_FragCoord.y / backdropImageResolution.y) );
	vec4 b = texture2D(backdropImage, bPos ).rgba;
	vec3  bColor = b.rgb;
	float bAlpha = b.a;

	// Step 1: Mixing 
	vec3 mix = mixing(b.rgb, s.rgb);

	// Step 2: Blending 
	vec3 blend = (1.0 - b.a) * s.rgb + b.a * mix;

	// Step 3: Compositing ("Source Over")
	vec3 composite = s.a * blend + b.a * b.rgb * (1.0 - s.a);

	// Step 4: Coverage
	float coverage = s.a + b.a * (1.0 - s.a);

	// Limit values to the [0.0,1.0] range
	vec4 pixelColor = vec4( clamp( composite, 0.0, 1.0 ), clamp( coverage, 0.0, 1.0 ) );

	// Apply to the fragment
	gl_FragColor = pixelColor;
}
