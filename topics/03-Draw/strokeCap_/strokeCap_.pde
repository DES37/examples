/* Demonstrate use of strokeCap()
 *
 * mouseX ~ strokeWeight
 *
 * Default strokeCap seems to be ROUND
 *
 * reference: https://processing.org/reference/strokeCap_.html
 * 
 * author: Spencer Mathews
 */

void setup() {
  size(500, 500);
}

void draw() {
  background(0);
  
  float x1 = 100;
  float x2 = 400;

  stroke(255, 255, 255);
  strokeWeight(mouseX);

  line(x1, 100, x2, 100);

  strokeCap(ROUND);
  line(x1, 200, x2, 200);

  strokeCap(SQUARE);
  line(x1, 300, x2, 300);

  strokeCap(PROJECT);
  line(x1, 400, x2, 400);
  
  stroke(255, 0, 0, 128);
  strokeWeight(1);
  // vertical lines to mark line ends
  line(x1, 0, x1, height);
  line(x2, 0, x2, height);
  // vertical lines 
  line(x1-mouseX/2, 0, x1-mouseX/2, height);
  line(x2+mouseX/2, 0, x2+mouseX/2, height);
  line(0, 100+mouseX/2, width, 100+mouseX/2);
  line(0, 100-mouseX/2, width, 100-mouseX/2);
}