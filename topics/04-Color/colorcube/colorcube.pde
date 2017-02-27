/**
 Spencer Mathews
 Want to make a color cube and spin it.
 
 Performance notes:
 see https://youtu.be/NZG3g0NRR4I
 
 ellipse is inefficient, point is faster
 smooth() slows things a lot!
 stroke slows things down, too
 
 */

float theta=0;
float step=PI/180;

float color_step=5;

void setup() {
  //size(500, 500, P2D);
  size(500, 500, FX2D);
  frameRate(30);
  noSmooth();
  strokeWeight(color_step);
  //stroke();
  //strokeWeight()
  //fill
}

void draw() {

  background(0);

  translate(width/2, height/2);
  rotate(theta);
  theta+=step;

  drawCube(0, 0);

  println(frameRate);

  //if(frameCount%30==0)
  frame.setTitle(int(frameRate) + " fps");
}

void drawCube(float x, float y) {

  for (int r=0; r<256; r+=color_step) {
    for (int g=0; g<256; g+=color_step) {
      //for(int b=0; b<256; b++)
      //{
      stroke(r, g, 0, 255);
      point(x+r, y+g);
      //}
    }
  }
}