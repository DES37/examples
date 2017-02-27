
/*
 * beginShape() creates irregular polygon with no mode parameter, or specity
 * POINTS, LINES, TRIANGLES, TRIANGLE_FAN, TRIANGLE_STRIP, QUADS, QUAD_STRIP
 *
 * see https://processing.org/tutorials/pshape/
 */


PShape rectangle;

PVector center;

void setup() {
  size(500, 500, P2D);
  center = new PVector(width/2, height/2);

  // note: createShape
  rectangle = createShape(RECT, 0, 0, 100, 50);
}

void draw() {
  background(0);
  
  shape(rectangle);
}