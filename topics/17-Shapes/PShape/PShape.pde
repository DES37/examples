/*
 * beginShape() creates irregular polygon with no mode parameter, or specity
 * POINTS, LINES, TRIANGLES, TRIANGLE_FAN, TRIANGLE_STRIP, QUADS, QUAD_STRIP
 *
 * see https://processing.org/tutorials/pshape/
 *
 * #PShape #createShape #beginShape
 */
 
 be careful since should probably not name file same as class!

PShape rectangle;

PVector center;

void setup() {
  size(500, 500, P2D);
  center = new PVector(width/2, height/2);

  rectangle = createShape(RECT, 0, 0, 100, 50);
}

void draw() {
  background(0);

    // draw basic shape
  beginShape();
  vertex(0, 0);
  vertex(width/2, 0);
  vertex(width/2, height/2);
  vertex(0, height/2);
  endShape();


  translate(mouseX, mouseY);
  shape(rectangle);
}