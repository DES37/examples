/* Simple mouse interaction which follows mouse position.
 *
 * Spencer Mathews, May 2016
 */

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

  float x = width/2;
  float y = height/2;

  float dy, dx;
  float offset = 5;

  rect(x, y, w, h);

  if (mouseX<x) {
    dx = -offset;
  } else {
    dx = offset;
  }

  if (mouseY<y) {
    dy = -offset;
  } else {
    dy = offset;
  }

  rect(x, y, x+dx, y+dy);
}