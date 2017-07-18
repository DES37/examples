/* Investigating stokeWeight()
 *
 * mouseX ~ strokeWeight
 * mouseY ~ diameter of circle
 *
 * note: Renderers handle stroke differently and some don't allow zero weight
 *
 * author: Spencer Mathews
 * date: 5/2016
 */

void setup() {
  size(500,500);
}

void draw() {
  background(128);
  fill(0,0,255);

  stroke(255,0,0);
  strokeWeight(mouseX);
  // circle with dynamic strokeWeight
  ellipse(width/2, height/2, mouseY, mouseY);
  
  stroke(0);
  strokeWeight(1);
  noFill();
  // same circle buth 
  ellipse(width/2, height/2, mouseY, mouseY);
  
  line(width/2+mouseY/2,height/2, width/2+mouseY/2+mouseX/2, height/2);
  println(mouseY/(mouseX+.000001));
  
  strokeWeight(mouseX);
  line(width/2, 0, width/2, height);
}