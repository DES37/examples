/* Spencer Mathews, October 2016
 *
 * IS FINISHED!
 * Adaptation of https://processing.org/examples/arctangent.html
 * which removes the class to simplify the example
 */

void setup() {
  size(640, 360);
  noStroke();
}

void draw() {
  background(102);

  displayEye(250, 16, 120);
  displayEye(164, 185, 80);  
  displayEye(420, 230, 220);
}

/*
 * A more exact conversion of the original sketch would have involved 
 * having mx and my parameters, but violating encapsulation of functions
 * is less of a faux pas than for classes.
 */
void displayEye(int x, int y, int size) {
  float angle = atan2(mouseY-y, mouseX-x);

  pushMatrix();
  translate(x, y);
  fill(255);
  ellipse(0, 0, size, size);
  rotate(angle);
  fill(153, 204, 0);
  ellipse(size/4, 0, size/2, size/2);
  popMatrix();
}