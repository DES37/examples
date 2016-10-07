//OLD METHOD -----------------------------------

//float x=0;
//float y=0;
//float xspeed=5;
//float yspeed=2.3;

//void setup () {
//  size (320, 240);
//}

//void draw() {
//  background (255);
//  stroke(0);
//  fill(127);
//  ellipse(x, y, 32, 32); //draw a ball very frame.

//  x=x+xspeed; //every frame, advance the circle's position.
//  y=y+yspeed;

//  if (x>width||x<0) { //every frame of the animation, we have to check to see if it has hit the edge.
//    xspeed=xspeed*-1;
//  }
//  if (y>height||y<0) {
//    yspeed=yspeed*-1;
//  }
//}

// METHOD -----------------------------------

float x=0;
float y=0;
float xspeed=5;
float yspeed=2.3;

void setup () {
  size (320, 240);
}

void draw() {
  background (255);
  displayBall(); //call the display function
  moveBall(); //call the move ball function
  checkEdges(); // call the check edge function
}
void displayBall() {   //NEW display function defined that draws a ball very frame.
  stroke(0);
  fill(127);
  ellipse(x, y, 32, 32);
}

void moveBall() {  //NEW move ball function defined that advances the circle's position.
  x=x+xspeed; 
  y=y+yspeed;
}

void checkEdges() {  //NEW check edge function defined
  if (x>width||x<0) { 
    xspeed=xspeed*-1;
  }
  if (y>height||y<0) {
    yspeed=yspeed*-1;
  }
}