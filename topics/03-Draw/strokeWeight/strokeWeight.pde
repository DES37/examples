/* SM, May 2016
 * Investigating stokeWeight
 *
 * 
 * 
 * Note: Renderers handle stroke differently and some don't allow zero weight 
 */

void setup() {
  size(500,500);
}

void draw() {
  background(128);
  stroke(255,0,0);
  fill(0,0,255);
  strokeWeight(mouseX);
  ellipse(width/2, height/2, mouseY, mouseY);
  strokeWeight(3);
  stroke(0);
  ellipse(width/2, height/2, mouseY, mouseY);
  line(width/2+mouseY/2,height/2, width/2+mouseY/2+mouseX/2, height/2);
  println(mouseY/(mouseX+.000001));
  
  strokeWeight(mouseX);
  line(width/2, 0, width/2, height);
  
  int tx = 0;
  int ty = 0;
  text("Hello",tx, ty);
}