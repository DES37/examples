// 20. per-vertex color fills within a beginShape-endShape
// Processing’s P2D, P3D and OPENGL render modes allow for individual fill colors per vertex 
// in a beginShape-endShape. This allows you to easily create very smooth gradients.
// from https://amnonp5.wordpress.com/2012/01/28/25-life-saving-tips-for-processing/
//
// #color

void setup() {
  size(500,500,P2D);
  noStroke();
  smooth();
}
 
void draw() {
  background(0);
  beginShape();
  fill(255,0,0);
  vertex(100,100);
  fill(0,255,0);
  vertex(400,100);
  fill(0,0,255);
  vertex(mouseX,mouseY);
  endShape();
}