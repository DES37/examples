//GOAL: random position, radius, color and alpha

float xPosition; //cicle position
float yPosition;

float circleRa; //circle radius

float circleR; //circle color in RGB mode
float circleG;
float circleB;

float circleAlpha; //cicle alpha

void setup() {
  size(640, 360);

  //declare initial values
  xPosition=random(100, width-100); //don't start off screen.
  yPosition=random(100, height-100);//don't start off screen.

}

void draw() {
  background(50); //clears the background each time the circle is drawn.

  circleRa=random(100);
  circleAlpha=random(255);
  circleR=random(255);
  circleG=random(255);
  circleB=random(255);
  //xPosition=random(640); //totally random x position
  //yPosition=random(360); //totally random y position

  fill(circleR, circleG, circleB, circleAlpha);//fill(rgb, alpha)
  noStroke(); //no stroke.
  ellipse(xPosition, yPosition, circleRa, circleRa); //draw circle's x and y position randomly on screen, with random diameter.

  //ANIMATION: circles randomly positions about the position of the original circle.
  xPosition=xPosition+random(-100, 100);
  yPosition=yPosition+random(-100, 100);
  
  if (xPosition > width || xPosition<0) {
    xPosition=width/2;
  }
  
   if (yPosition > height || yPosition<0) {
    yPosition=height/2;
  }
}