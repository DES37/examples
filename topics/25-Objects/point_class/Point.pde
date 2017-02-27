/*
 *
 */

class Point extends PVector {

  // Fields x, y, z are inherited
  float r;  // radius for selection
  color c;
  float w;

  Point(float x, float y) {
    // Run PVector constructor
    super(x, y);
    r = 5;
    c = color(0);
    w = 1;
  }

  boolean isOver() {
    // Get distance to mouse
    // Alt use this.dist() but then must construct PVector from mouseXY
    if (PApplet.dist(x, y, float(mouseX), float(mouseY)) < r) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    strokeWeight(r*2);
    if (isOver()) {
      //strokeWeight(r*4);
      c = color(255, 0, 0);
    } else {
      //strokeWeight(r*2);  // set diameter of point to reflect selection radius
      c = color(0);
    }
    stroke(c);
    point(x, y);
  }
}