// Texture images
PImage sourceImage, backdropImage;

// current blend mode
int blendIndex = 0;

// 0-24 modes (-1)
int maxIndex = 24;

// enable GUI automatically
boolean isGUI = true;

// current shader
PShader myShader;

// begin looping
boolean isPlaying = true;

// data folder files
String shaderSubDirectory = "glsl/";
String textureSubDirectory = "textures/";

// Storing blend mode names
String[] blendNames = {
                        "Darken",
                        "Multiply",

                        "Color burn",
                        "Linear burn",
                        "Darker color",

                        "Lighten",
                        "Screen",
                        "Color dodge",
                        "Linear dodge",
                        "Lighter color",

                        "Overlay",
                        "Soft light",
                        "Hard light",
                        "Vivid light",
                        "Linear light",
                        "Pin light",
                        "Hard mix",

                        "Difference",
                        "Exclusion",
                        "Substract",
                        "Divide",

                        "Hue",
                        "Color",
                        "Saturation",
                        "Luminosity"
                      };

// Storing shader file names
String[] blendFilenames = { 
                          "darken.glsl",
                          "multiply.glsl",

                          "colorBurn.glsl",
                          "linearBurn.glsl",
                          "darkerColor.glsl",

                          "lighten.glsl",
                          "screen.glsl",
                          "colorDodge.glsl",
                          "linearDodge.glsl",
                          "lighterColor.glsl",

                          "overlay.glsl",
                          "softLight.glsl",
                          "hardLight.glsl",
                          "vividLight.glsl",
                          "linearLight.glsl",
                          "pinLight.glsl",
                          "hardMix.glsl",

                          "difference.glsl",
                          "exclusion.glsl",
                          "subtract.glsl",
                          "divide.glsl",

                          "hue.glsl", 
                          "color.glsl",
                          "saturation.glsl",
                          "luminosity.glsl"
                          };

// Naming 
static final int BL_DARKEN        =  0;
static final int BL_MULTIPLY      =  1;

static final int BL_COLORBURN     =  2;
static final int BL_LINEARBURN    =  3;
static final int BL_DARKERCOLOR   =  4;

static final int BL_LIGHTEN       =  5;
static final int BL_SCREEN        =  6;
static final int BL_COLORDODGE    =  7;
static final int BL_LINEARDODGE   =  8;
static final int BL_LIGHTERCOLOR  =  9;

static final int BL_OVERLAY       = 10;
static final int BL_SOFTLIGHT     = 11;
static final int BL_HARDLIGHT     = 12;
static final int BL_VIVIDLIGHT    = 13;
static final int BL_LINEARLIGHT   = 14;
static final int BL_PINLIGHT      = 15;
static final int BL_HARDMIX       = 16;

static final int BL_DIFFERENCE    = 17;
static final int BL_EXCLUSION     = 18;
static final int BL_SUBSTRACT     = 19;
static final int BL_DIVIDE        = 20;

static final int BL_HUE           = 21;
static final int BL_COLOR         = 22;
static final int BL_SATURATION    = 23;
static final int BL_LUMINOSITY    = 24;

// List of the PShader objects
ArrayList<PShader> blendModes;

void setup() {

  size( 512, 512, P2D );
  
  // Load in the texture images
  sourceImage   = loadImage( textureSubDirectory + "duck-with-alpha.png" );
  backdropImage = loadImage(  textureSubDirectory + "rainbow-background-with-alpha.png" );

  // Instantiate list of shader files
  blendModes = new ArrayList<PShader>();
  
  // Load the shader files
  for(int i=0; i< blendFilenames.length; i++) {
    String filePath = shaderSubDirectory + blendFilenames[i];
    
    PShader s = loadShader(filePath);
    
    // Show shader the size of the viewport
    s.set( "sketchSize", float(width), float(height) );
  
    // Send images to the shader
    s.set( "sourceImage", sourceImage ); 
    s.set( "backdropImage", backdropImage );
  
    // Send image resolutions to the shader
    s.set( "sourceImageResolution", float( sourceImage.width ), float( sourceImage.height ) );
    s.set( "backdropImageResolution", float( backdropImage.width ), float( backdropImage.height ) );

    blendModes.add(s);
  }
 
  setBlendMode(blendIndex);
 
}

void draw() {
  
  drawCheckerboard();

  // Switches the shader mode every 100 frames
  if(isPlaying && frameCount % 100 == 0) {
    // Allow the switching of blend modes from 0 to 24
    blendIndex = ( blendIndex + 1 ) % maxIndex;
    setBlendMode(blendIndex);
  }
  
  // Apply current shaders after this point
  shader(myShader);

  // Send the shader output onto a rectangle on screen
  rect(0, 0, width, height);

  // Call resetShader() to ensure upcoming geometry isn't shown the previous shaders
  resetShader();
  
  // Display the GUI with G to hide or show
  if(isGUI) {
    // Text backdrop
    fill(255, 255, 255, 150);
    noStroke();
    rect(0,0,width,50);

    // Show current blend mode on screen
    pushStyle();
    textAlign(LEFT);
    textSize(20);
    fill(60);
    text( blendIndex + ") " + blendNames[ blendIndex ], 10, 30 );
    popStyle();
  }

}

void setBlendMode(int i) {
  myShader = blendModes.get(i);
}

void drawCheckerboard() {
  
  float row = 64;
  float squareSize = height / row;
  float col = width / squareSize;
  
  pushMatrix();
  
  pushStyle();
  
  noStroke();
  
  for(int i = 0; i <= row; i++) {
    
    pushMatrix();
    for(int j = 0; j <= col; j++) {
      
      // Alternate between colors of white and grey
      if(i%2 == 1) {
        if( j%2 == 1 ) { fill(200); }
        else { fill(255); }
      }
      else {
        if( j%2 == 1 ) { fill(255); }
        else { fill(200); }
      }
      
      rect(0, 0, squareSize, squareSize);
      
      translate(squareSize, 0);
    }
    popMatrix();
    
    translate(0, squareSize);
  }
  
  popStyle();
  
  popMatrix();
  
}

// all keyboard input
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      blendIndex--;
    } else if (keyCode == DOWN) {
      blendIndex++;
    } 
    // loop shader after 24 back to 0
       if ( blendIndex > maxIndex ) { blendIndex =  0; }
  else if ( blendIndex <  0 ) { blendIndex = maxIndex; }
  
  // Update shader
  setBlendMode(blendIndex);
  }
  
  else if ( key == ' ' ) {
    isPlaying = !isPlaying; // start & stop mode looping
  }
  else if ( key == 'g' || key == 'G') {
    isGUI = !isGUI;
  }
}