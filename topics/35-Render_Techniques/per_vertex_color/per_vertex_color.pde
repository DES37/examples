/* Illustrate per-vertex stroke() and fill() of P2D and P3D renderers
 *
 * modified from:
 * https://amnonp5.wordpress.com/2012/01/28/25-life-saving-tips-for-processing/
 * 20. per-vertex color fills within a beginShape-endShape
 * Processing’s P2D, P3D and OPENGL render modes allow for individual fill colors per vertex 
 * in a beginShape-endShape. This allows you to easily create very smooth gradients.
 *
 * ref: https://processing.org/reference/beginShape_.html
 *
 * author: Spencer Mathews
 * date : 5/2017
 * tags: #color #tricks
 * status: complete
 */

void setup() {
  size(500, 500, P2D);
}

void draw() {
  background(0);

  // per-vertex fill
  noStroke();
  beginShape();
  fill(255, 0, 0);
  vertex(100, 100);
  fill(0, 255, 0);
  vertex(400, 100);
  fill(0, 0, 255);
  vertex(mouseX, mouseY);
  endShape(CLOSE);

  // per-vertex stroke
  noFill();
  beginShape();
  stroke(255, 0, 0);
  vertex(100, 400);
  stroke(0, 255, 0);
  vertex(400, 400);
  stroke(0, 0, 255);
  vertex(mouseX, mouseY);
  endShape(CLOSE);
}