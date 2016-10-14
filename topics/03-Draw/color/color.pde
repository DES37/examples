// Spencer Mathews, April 2016
// Demonstrate basic use of color
// #color

void setup() {
  size(400, 400);
  noLoop();  // use noLoop() when there is no animation
}

void draw() {
  background(255);

  fill(128);
  ellipse(100, 100, 200, 200);
  fill(255, 0, 0);
  ellipse(300, 100, 200, 200);
  fill(128, 64);
  ellipse(100, 300, 200, 200);
  fill(255, 0, 0, 64);
  ellipse(300, 300, 200, 200);
}