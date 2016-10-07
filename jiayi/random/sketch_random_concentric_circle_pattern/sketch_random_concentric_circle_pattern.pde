void setup () {
  size (800, 800); 
  background (0);
  ellipseMode(CENTER);
  noFill();
  stroke(0);
  strokeWeight(1);
  noLoop();
}

void draw () {

  for (float i=0; i<10; i++) {
    float x=50;
    x=x+x*i;
    for (float j=0; j<10; j++) {
      float y=50;
      y=y+y*j;
      for (float k=0; k<5; k++) {
        float ir=10;
        float spacing=10;
        float r;

        float rr=random(0, 255);
        float g=random(0, 255);
        float b=random(0, 255);

        stroke(rr, g, b);

        r=ir+spacing*k;
        ellipse (x+random(0, 10), y+random(0, 10), r, r);
      }
    }
  }
}