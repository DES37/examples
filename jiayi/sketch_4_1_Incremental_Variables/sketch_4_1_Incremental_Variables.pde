float circleX;
//int circleX=50;

void setup() {
  size(640, 360);
  circleX=50;
}

void draw() {
  background(50);

  fill(255);
  ellipse(circleX, 180, 24, 24); //draw circle's x position according to the circleX value.
  //CREATING very slow ANIMATION
  circleX=circleX+0.33; //the x position is going to advance by 1 pixels every three draws.
  //circleX=circleX+0.25; //the x position is going to advance by 1 pixels every four draws.
  //circleX=circleX+0.1; //the x position is going to advance by 1 pixels every ten draws.

}