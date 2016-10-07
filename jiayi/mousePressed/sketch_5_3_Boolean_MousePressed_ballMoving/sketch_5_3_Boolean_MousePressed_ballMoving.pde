float x=100;
//Here, a function of mousePressed is used to set this boolean variable.
boolean ballMoving=false;//When the program is initially sketched, the ball is not moving, because my variable ballmoving is set to false.

void setup () {
  size(400, 300);
}

void draw() {
  background(0);
  fill(255);
  ellipse(x, 150, 24, 24);

  if (ballMoving) {
    x=x+2;
  }
}

void mousePressed() {
  ballMoving=!ballMoving;  //flipping the boolean state
}

 