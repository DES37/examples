PImage img;  // Declare variable "a" of type PImage

void setup() {
  size(1500, 1000);
  // The image file must be in the data folder of the current sketch 
  // to load successfully
  img = loadImage("testpic.jpg");  // Load the image into the program  
}

void draw() {
  // Displays the image at its actual size at point (0,0)
  stroke(0);
  noFill();
  ellipse(displayWidth/2, displayHeight/2, 200,200);
  text( "Click here to load image!", displayWidth/2-80, displayHeight/2);
}

  void mouseClicked() {
    if (dist(mouseX, mouseY,displayWidth/2, displayHeight/2) <50) {
  image(img, 0, 0);
    }
  }

