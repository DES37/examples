float x=50; //x position
float d=20;  //diameter
float r=0;  //red channel
float g=0;  //green channel
float b=255;  //blue channel


void setup() {
  size(640, 360);
}

void draw() {
  background(50);
  float y=height/2;  //y position, to use the pre-defined valuable "height", it has to appear after size.

  noStroke();
  fill(r, g, b);
  r=r+10;
  g=g+2;
  b=abs(b-5);


  ellipse(x, y, d, d); //draw circle's x position according to the circleX value.
  x=x+5;
  d=d+1;
}