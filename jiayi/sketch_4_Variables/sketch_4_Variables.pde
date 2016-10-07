int circleX;
//int circleX=50;

void setup() {
  size(640, 360);
  circleX=50;
}

void draw() {
  background(50);

  fill(255);
  ellipse(circleX, 180, 24, 24); //draw circle's x position according to the circleX value.
  //This sets foundation for CREATING ANIMATION!
}