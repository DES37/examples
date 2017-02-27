/* Spencer Mathews
 *
 * finish!
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

    // draw basic shape
  beginShape();
  vertex(0, 0);
  vertex(width/2, 0);
  vertex(width/2, height/2);
  vertex(0, height/2);
  endShape();

  beginShape();  // irregular polygon with no mode parameter
  // vertex(), curveVertex(), bezierVertex()
  endShape();
  beginShape(POINTS);
  endShape();
  beginShape(LINES);
  endShape();
  beginShape(TRIANGLES);
  vertex(center.x, center.y);
  //for (int i=0; i<10; i+=PI/10) {
    vertex(center.x+100, center.y);
    vertex(center.x, center.y+100);
  //}
  endShape();
  beginShape(TRIANGLE_FAN);
  endShape();
  beginShape(TRIANGLE_STRIP);
  endShape();
  beginShape(QUADS);
  endShape();
  beginShape(QUAD_STRIP);
  endShape();

}