                         // Instance Variables \\
/* In object oriented programming with classes, an instance variable is a variable defined in a class,
   for which each instantiated object of the class has a separate copy, or instance. */

// Initializes variables of type PImage.
PImage wand, howto, gameboard, face1, face2, face3;         

// Initializes variables of type float.
float hairY;                                        

// Initializes variables of type int.
int gameState, facenumber, hairX, clicks, r, g, b; 

// Initialize the x and y positions of the hair in float arrays.
float[] hairXpos = new float[10000];
float[] hairYpos = new float[10000];

// Initialize variables of array type boolean - allows us to check for hairs close to the magnet.
boolean[] isBeingMoved = new boolean[10000];


                             // setup() \\
/* The setup() function is only run once, when the program starts. It's used to define
   initial environment properties such as screen size and to load media like images and
   fonts whenever the program starts. It isn't called again after its initial execution. */
   
void setup() {                                                 //
  background(255);                                            // Sets the background color to white.
  gameState = 0;                                             // Initializes the gameState variable to 0, the default.
  size(700, 800);                                           // Sets the size (w x h) of the window.
  noCursor();                                              // Hides the cursor from view.
  wand = loadImage("magnetwand.png");                     // Loads in the image of the wand.
  howto = loadImage("hairyhumanhowto.jpg");              // Loads in the image of the how-to splash screen.                     
  gameboard = loadImage("hairyhuman_frame.jpg");        // Loads in the image of the gameboard.
                                                       
  r = 0;                                              //<
  g = 0;                                             //< Sets the color integers to black.
  b = 0;                                            //<
                                                   
  facenumber = 0;                                 // Initializes the facenumber variable to 0, the default face.
                                                 
  face1 = loadImage("face1.jpg");               // Loads in the image of the first face. (free 'bald man' clip art)
  face2 = loadImage("face2.jpg");              // Loads in the image of the second face. (free 'presidential' clip art)
  face3 = loadImage("face3.jpg");             // Loads in the image of the third face. (free 'monkey' clip art)
                                             
  for (int i = 0; i < 10000; i++) {         //<
    hairXpos[i] = random(140, 580);        //< Randomizes the initial x position of each hair.
  }                                       //<
                                         
  for (int i = 0; i < 10000; i++) {     //<
    hairYpos[i] = random(585, 645);    //< Randomizes the initial y position of each hair.
    isBeingMoved[i] = false;          //< Sets each boolean in the boolean array to false. (not moving)
  }                                  //<
}                                   //


                              // draw() \\
/* The draw() function continuously executes the lines of code within its block until 
   the program is stopped or noLoop() is called. Called automatically and isn't ever
   called explicity. */
   
void draw() {                                                               //
  background(255);                                                         // Sets the background to white on every call.
                                                                          
  if (gameState == 0) {                                                  //< Checks if the game state is 0 (splash screen).
    image(howto, 0, 0);                                                 //< Sets the image to the splash screen / how-to.
  }                                                                    //<
  
  
  
  if (gameState == 1) {                                             //< Checks if the game state is 1 (gameboard)
    image(gameboard, 12, -6);                                      //< Sets the image to the game board.
    noCursor();                                                   //< Hides the cursor from view.
                                                                 
    fill(209, 158, 27);                                         //< Fills the box  that encapsulates all of the different clickable hair colors with color.
    rect(190, 650, 350, 45);                                   //< Creates the box that encapsulates all of the different clickable hair colors.
                                                              
    noStroke();                                              // Removes the stroke to prevent the color of the box outline from changing w/ hair color.
    fill(240, 158, 27);                                     //< Fills the ORANGE hair color box.
    rect(200, 660, 25, 25);                                //< Creates the ORANGE hair color box.
    fill(0);                                              //< Fills the BLACK hair color box.
    rect(250, 660, 25, 25);                              //< Creates the BLACK hair color box.
    fill(209, 209, 17);                                 //< Fills the YELLOW hair color box.
    rect(300, 660, 25, 25);                            //< Creates the YELLOW hair color box.
    fill(144, 3, 3);                                  //< Fills the RED hair color box.
    rect(350, 660, 25, 25);                          //< Creates the RED hair color box.
    fill(85, 65, 9);                                //< Fills the BROWN hair color box.
    rect(400, 660, 25, 25);                        //< Creates the BROWN hair color box.
    fill(237, 240, 239);                          //< Fills the GRAY hair color box.
    rect(450, 660, 25, 25);                      //< Creates the GRAY hair color box.
    fill(216, 21, 227);                         //< Fills the PINK hair color box.
    rect(500, 660, 25, 25);                    //< Creates the PINK hair color box.
                                              
    if  (facenumber == 0) {                  // Checks to see if the face number is 0. (the first)
      image(face1, 140, 90);                // If so, sets the face image to 0. (the first)
    }                                      //
    
    if (facenumber == 1) {               // Checks to see if the face number is 1. (the second)
      image(face2, 140, 90);            // If so, sets the face image to 1. (the second)
    }                                  //
    
    if (facenumber == 2) {           // Checks to see if the face number is 2. (the last)
      image(face3, 140, 90);        // If so, sets the face image to 2. (the last)
    }                              //
    
    if (facenumber > 2) {        // Checks to see if the face number exceeds 2.
      facenumber = 0;           // If so, resets the face number to 0.
    }                          //
    
    if (facenumber < 0) {    // Checks to see if the face number preceeds 0.
      facenumber = 2;       // If so, resets the face number to 2.
    }                      //
                              
    strokeWeight(2);     // Sets the stroke weight (line width) to 2.
    stroke(r, g, b);    // Sets the stroke (color) to the rgb variables - which make black.
                                                                                     
    for (int i = 0; i < 10000; i += 2) {                                            //< Cycles through every other hair starting with 0.
      line(hairXpos[i], hairYpos[i], (hairXpos[i] + 5), (hairYpos[i] + 5));        //< Creates the hair.
    }                                                                             //<
                                                                                 
    for (int i = 1; i < 10000; i += 2) {                                        //< Cycles through every other hair starting with 1.
      line(hairXpos[i], hairYpos[i], (hairXpos[i] - 5), (hairYpos[i] + 5));    //< Creates the hair.
    }                                                                         //<
                                                                             
    for (int i = 0; i < 10000; i++) {                                       //< Cycles through every hair.
      if (isBeingMoved[i] == true) {                                       //< Checks to see if the hair is being moved.
        hairXpos[i] = mouseX + random(-12, 12);                           //< If so, set the hairs' X position randomly in a 12 pixel radius. 
        hairYpos[i] = mouseY + random(-12, 12);                          //< If so, set the hairs' Y position randomly in a 12 pixel radius.
      }                                                                 //< (this creates a wavy-hair effect)
    }                                                                  //<
    image(wand, mouseX, mouseY - wand.height);                        // Sets the image of the wand to the cursor's position.
  }                                                                  //
  
  
  
  if (gameState == 2) {                                              //< Checks if the game state is 2 (inverse gameboard)
    image(gameboard, 12, -6);                                       //< Sets the image to the game board.
    filter(INVERT);                                                // Inverts all of the colors in the background.
    noCursor();                                                   //< Hides the cursor from view.
                                                                 
    fill(209, 158, 27);                                         //< Fills the box  that encapsulates all of the different clickable hair colors with color.
    rect(190, 650, 350, 45);                                   //< Creates the box that encapsulates all of the different clickable hair colors.
                                                              
    noStroke();                                              // Removes the stroke to prevent the color of the box outline from changing w/ hair color.
    fill(240, 158, 27);                                     //< Fills the ORANGE hair color box.
    rect(200, 660, 25, 25);                                //< Creates the ORANGE hair color box.
    fill(0);                                              //< Fills the BLACK hair color box.
    rect(250, 660, 25, 25);                              //< Creates the BLACK hair color box.
    fill(209, 209, 17);                                 //< Fills the YELLOW hair color box.
    rect(300, 660, 25, 25);                            //< Creates the YELLOW hair color box.
    fill(144, 3, 3);                                  //< Fills the RED hair color box.
    rect(350, 660, 25, 25);                          //< Creates the RED hair color box.
    fill(85, 65, 9);                                //< Fills the BROWN hair color box.
    rect(400, 660, 25, 25);                        //< Creates the BROWN hair color box.
    fill(237, 240, 239);                          //< Fills the GRAY hair color box.
    rect(450, 660, 25, 25);                      //< Creates the GRAY hair color box.
    fill(216, 21, 227);                         //< Fills the PINK hair color box.
    rect(500, 660, 25, 25);                    //< Creates the PINK hair color box.
                                              
    if  (facenumber == 0) {                  // Checks to see if the face number is 0. (the first)
      image(face1, 140, 90);                // If so, sets the face image to 0. (the first)
    }                                      //
    
    if (facenumber == 1) {               // Checks to see if the face number is 1. (the second)
      image(face2, 140, 90);            // If so, sets the face image to 1. (the second)
    }                                  //
    
    if (facenumber == 2) {           // Checks to see if the face number is 2. (the last)
      image(face3, 140, 90);        // If so, sets the face image to 2. (the last)
    }                              //
    
    if (facenumber > 2) {        // Checks to see if the face number exceeds 2.
      facenumber = 0;           // If so, resets the face number to 0.
    }                          //
    
    if (facenumber < 0) {    // Checks to see if the face number preceeds 0.
      facenumber = 2;       // If so, resets the face number to 2.
    }                      //
                              
    strokeWeight(2);     // Sets the stroke weight (line width) to 2.
    stroke(r, g, b);    // Sets the stroke (color) to the rgb variables - which make black.
                                                                                     
    for (int i = 0; i < 10000; i += 2) {                                            //< Cycles through every other hair starting with 0.
      line(hairXpos[i], hairYpos[i], (hairXpos[i] + 5), (hairYpos[i] + 5));        //< Creates the hair.
    }                                                                             //<
                                                                                 
    for (int i = 1; i < 10000; i += 2) {                                        //< Cycles through every other hair starting with 1.
      line(hairXpos[i], hairYpos[i], (hairXpos[i] - 5), (hairYpos[i] + 5));    //< Creates the hair.
    }                                                                         //<
                                                                             
    for (int i = 0; i < 10000; i++) {                                       //< Cycles through every hair.
      if (isBeingMoved[i] == true) {                                       //< Checks to see if the hair is being moved.
        hairXpos[i] = mouseX + random(-12, 12);                           //< If so, set the hairs' X position randomly in a 12 pixel radius. 
        hairYpos[i] = mouseY + random(-12, 12);                          //< If so, set the hairs' Y position randomly in a 12 pixel radius.
      }                                                                 //< (this creates a wavy-hair effect)
    }                                                                  //<
    
    image(wand, mouseX, mouseY - wand.height);                       // Sets the image of the wand to the cursor's position.
  }                                                                 //
}                                                                  //

        
                       // mousePressed() \\
/* The mousePressed() function is called once after every time a mouse button is pressed.
   The mouseButton variable can be used to determine which button has been pressed.
   Mouse and keyboard events only work when a program has draw(). Without draw, the code
   is only run once and then stops listening for events.*/

void mousePressed() {                                            // 
  for (int i = 0; i < 10000; i++) {                             //< Cycles through all of the hairs.
    if (dist(mouseX, mouseY, hairXpos[i], hairYpos[i]) < 8) {  //< Checks to see if any of the hairs are within 8 pixels of the wand.
      isBeingMoved[i] = true;                                 //< If so, sets those hairs to true. (moving)
    }                                                        //<
  }                                                         //<
}                                                          //


                        // mouseReleased() \\
/* The mouseReleased() function is called every time a mouse button is released.
   Mouse and keyboard events only work whenever a program has a draw() method, without
   a draw() method, the code only runs one time and then stops listening for events. */

void mouseReleased() {                                           //
  for (int i = 0; i < 10000; i++) {                             //< Cycles through all of the boolean hairs.
    isBeingMoved[i] = false;                                   //< Sets all of them to false. (not moving)
  }                                                           //< 
  
  clicks++;                                                 // Counts the number of times the mouse is clicked on the window.
  print("Mouse clicks: " + clicks + "\n");                 // Prints the number of mouse clicks to the console everytime one is appended.
}                                                         //


                        // mouseClicked() \\
/* The mouseClicked() function is called after a mouse button has been pressed
   and then released. Mouse and keyboard events only work whenever a program
   has draw(). Without draw(), the code is only run once and then stops listening
   for events. */

void mouseClicked() {
  if (mouseX >= 200 && mouseX <= 225 && mouseY >= 660 && mouseY <= 685) {   //< Check if the mouse clicks the ORANGE box.
    r = 240;                                                               //<
    g = 158;                                                              //< If so, turns the hairs ORANGE.
    b = 27;                                                              //<
  }                                                                     //<
  
  if (mouseX >= 250 && mouseX <= 275 && mouseY >= 660 && mouseY <= 685) {   //< Check if the mouse clicks the BLACK box.
    r = 0;                                                                 //<
    g = 0;                                                                //< If so, turn the hairs BLACK.
    b = 0;                                                               //<
  }                                                                     //<
  
  if (mouseX >= 300 && mouseX <= 325 && mouseY >= 660 && mouseY <= 685) {   //< Check if the mouse clicks the YELLOW box.
    r = 209;                                                               //<
    g = 209;                                                              //< If so, turn the hairs YELLOW.
    b = 17;                                                              //<
  }                                                                     //<
  
  if (mouseX >= 350 && mouseX <= 375 && mouseY >= 660 && mouseY <= 685) {   //< Check if the mouse clicks the RED box.
    r = 144;                                                               //<
    g = 3;                                                                //< If so, turn the hairs RED.
    b = 3;                                                               //<
  }                                                                     //<
  
  if (mouseX >= 400 && mouseX <= 425 && mouseY >= 660 && mouseY <= 685) {   //< Check if the mouse clicks the BROWN box.
    r = 85;                                                                //<
    g = 65;                                                               //< If so, turn the hairs BROWN.
    b = 9;                                                               //<
  }                                                                     //<
  
  if (mouseX >= 450 && mouseX <= 475 && mouseY >= 660 && mouseY <= 685) {   //< Check if the mouse clicks the GRAY box.
    r = 237;                                                               //<
    g = 240;                                                              //< If so, turn the hairs GRAY.
    b = 239;                                                             //<
  }                                                                     //<
  
  if (mouseX >= 500 && mouseX <= 525 && mouseY >= 660 && mouseY <= 685) {   //< Check if the mouse clicks the PINK box.
    r = 216;                                                               //<
    g = 21;                                                               //< If so, turn the hairs PINK.
    b = 227;                                                             //<
  }                                                                     //<
}


                           // keyPressed() \\
/* The keyPressed() function is called once every time a key is pressed. The key
   that was pressed is then stored in the key variable. Mouse and keyboard events
   only work whenever a program has a draw() method, without a draw() method, the
   code only runs once time and then stops listening for events. */

void keyPressed(KeyEvent e) {                     //
  if (key == ENTER) {                            // Check if the key pressed is enter.
    setup();                                    // If so, run setup(). (restarts the game)
    gameState = 1;                             // Also change the gamestate to 1. (the splash-screen how to)
  }                                           //
  
  if (key == RETURN) {                      //< Check if the key pressed is return.
    setup();                               //< If so, run setup(). (restarts the game)
    gameState = 1;                        //< Also change the gamestate to 1. (the splash-screen how to)
  }                                      //<
  
  if (key == 32) {                     // Check if the key pressed is space.
    gameState++;                      // If so, go forward one gamestate. (from how-to splash screen into the game)
    if (gameState > 1) {             // Check if the gamestate is greater than 1.
      gameState = 0;                // If so, go back to the how-to splash screen.
    }                              //
  }                               //
  
  if (keyCode == RIGHT) {       //< Check if the key pressed is the right arrow.
    facenumber += 1;           //< If so, go forward one face.
  }                           //<
  
  if (keyCode == LEFT) {    // Check if the key pressed is the left arrow.
    facenumber -= 1;       // If so, go back one face.
  }                       //
  
  if (key == 112) {                                                          // Check if the key pressed is Shift + 'p' (Capital P).
    String screenshot = "myHairyHuman" + int(random(1, 1000)) + ".jpg";     // Generate a random screenshot name.
    save("C:/Users/mayberryr/Downloads/" + screenshot);                    // If so, save a .jpg image of the display window. (screenshot)
    print("Screenshot taken! Saving as: " + screenshot);                  // Print confirmation of screenshot.
  }                                                                      //
  
  if (e.isControlDown() && e.getKeyCode() == 65) {                     //< Secret Konami Code = Control + 'a'
    gameState = 2;                                                    //< Switches gameState to 2, inverts colors from 1.
    print("Correct code combo detected: Inverting...\n"              //< Verification message is printed out to the console that the colors have been inverted.
            + "Press Control + 'b' to undo.\n");                    //< Additional message printed out that tells you how to undo the invert.
  }                                                                //<
  
  if (e.isControlDown() && e.getKeyCode() == 66) {               // Konami Code to undo the Secret Konami Code = Control + 'b'
    gameState = 1;                                              // Switches gameState back to 1, undoing the inverted colors from 2.
    print("Correct code combo detected: Un-Inverting...\n");   // Verification message is printed out to the console that the colors have been un-inverted.
  }                                                           //
}                                                            //