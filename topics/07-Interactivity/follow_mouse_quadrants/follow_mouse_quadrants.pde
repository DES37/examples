// Spencer Mathews, May 2016
// Simple mouse interaction which follows mouse position.

float w, h;

void setup() {
  size(500, 500);
  rectMode(CENTER);
  w = width/20;
  h = width/20;
}
void draw() {
  background(255);

  //float zoom = 3;
  //float w = width/zoom;
  //float h = height/zoom;

  drawBox(width/2, height/2);
  

}

void drawBox(float x, float y) {
 
  float dy, dx;
  float offset = 5;
  
  rect(x, y, w, h);
  
  if(mouseX<x) {
    dx = -offset;
  } else {
    dx = offset;
  }
  
  if(mouseY<y) {
    dy = -offset;
  } else {
    dy = offset;
  }
  
  rect(x, y, x+dx, y+dy);
}