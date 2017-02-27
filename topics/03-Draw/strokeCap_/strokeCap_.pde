/* Spencer Mathews
 *
 * Demonstrate use of strokeCap
 */

// correct docs! default seems to be project! they are wrong!
//https://processing.org/reference/strokeCap_.html

void setup() {
  size(500, 500);
}

void draw() {
  background(0);

  stroke(255);
  strokeWeight(50);

  line(100, 100, 400, 100);

  strokeCap(ROUND);
  line(100, 200, 400, 200);

  strokeCap(SQUARE);
  line(100, 300, 400, 300);

  strokeCap(PROJECT);
  line(100, 400, 400, 400);

  // example from https://processing.org/reference/strokeCap_.html
  //strokeWeight(12.0);
  //line(20, 10, 80, 10);
  //strokeCap(ROUND);
  //line(20, 30, 80, 30);
  //strokeCap(SQUARE);
  //line(20, 50, 80, 50);
  //strokeCap(PROJECT);
  //line(20, 70, 80, 70);
}