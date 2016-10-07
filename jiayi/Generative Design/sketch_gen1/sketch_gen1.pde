//Generative Circles by points
float x, y;
float oX, oY;
float r=50, theta;

void setup() {
  size(600, 600);
  background(0);
  //fullScreen();
  strokeWeight(0.1);


  oX=width/2;
  oY=height/2;
}

void draw() {


  if (oX>width) {
    for (int i=0; i<20; i++) {
      oX=oX-oX*i;
    }
  }

  for (theta = 0; theta < 2* PI; theta += 0.01) {
    x = oX + cos(theta)*r;
    y = oY + sin(theta)*r;
    point(x, y);
  }

  oX = oX +random(-2, 2);
  oY = oY +random(-5, 5);
  r=r+random(-2, 2);
  float alpha=random(-50, 50);
    stroke(255, alpha);


  if (r<10) {
    alpha=20;
    r=50;
  }
}