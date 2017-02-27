/* Spencer Mathews
 * 
 * Play with images and pixels
 *
 * derived from https://processing.org/examples/pointillism.html
 * started: 5/2016 
 */

PImage img;
int smallPoint, largePoint;

void setup() {
  //size(2880,1944);
  //img = loadImage("sO08GvE.jpg");
  //size(1440,972);
  //img = loadImage("sO08GvE-2.jpg");
  size(720,486);
  img = loadImage("sO08GvE-4.jpg");

  smallPoint = 4;
  largePoint = 40;
  //imageMode(CENTER);
  noStroke();
  background(255);
}

void draw() { 
  float pointillize = map(mouseX, 0, width, smallPoint, largePoint);
  int x = int(random(img.width));
  int y = int(random(img.height));
  color pix = img.get(x, y);
  fill(pix, 128);
  ellipse(x, y, pointillize, pointillize);
}