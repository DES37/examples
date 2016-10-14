// Spencer Mathews, May 2016
// Simple mouse interaction which follows mouse position.

void setup() {
  size(500, 500);
  rectMode(CENTER);  // CENTER mode makes placement easier
  stroke(255);
  fill(0);
}

void draw() {
  background(0);

  drawEye(width/2, width/2, 80, 80, 10, 10);
  drawEye(width/8, width/8, 40, 40, 20, 20);
}


/**
 * Draw an "eye" which follows the mouse position
 *
 * @param x     center of outer rect x position
 * @param y     center of outer rect y position
 * @param w1    width of outer rect
 * @param h1    height of outer rect
 * @param w2    width of eye
 * @param h2    height of eye
 */
void drawEye(float x, float y, float w1, float h1, float w2, float h2) {
  pushMatrix();

  translate(x, y);
  rect(0, 0, w1, h1);

  // map mouse's location relative to canvas onto position within fixed box
  // note range is restricted to keep proper boundaries
  // note that the eye is not technically "following" the mouse but is a good approximation
  float i = map(mouseX, 0, width-1, -w1/2 + w2/2, w1/2 - w2/2);
  float j = map(mouseY, 0, height-1, -h1/2 + h2/2, h1/2 - h2/2);
  rect(i, j, w2, h2);

  popMatrix();
}