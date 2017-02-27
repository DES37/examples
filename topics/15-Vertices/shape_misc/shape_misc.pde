/* Spencer Mathews
 *
 * see https://www.processing.org/tutorials/curves/
 */

void setup() {
  size(400, 400);

  cursor(HAND);
}

void draw() {
  translate(33, 50);
  curve(0, 100, 0, 0, 50, 0, 50, 100);

  translate(100, 0);
  beginShape();
  curveVertex(0, 100);
  curveVertex(0, 0);
  curveVertex(50, 0);
  curveVertex(50, 100);
  endShape();

  translate(100, 0);
  // curveVertex requires at least 4 points, first and last control points typically repeated
  beginShape();
  curveVertex(0, 0);
  curveVertex(0, 0);
  curveVertex(25, 50);
  curveVertex(50, 0);
  curveVertex(50, 0);
  endShape();

  translate(-200, 100);
  //bezier(x1, y1, cpx1, cpy1, cpx2, cpy2, x2, y2);
  bezier(0, 0, 0, 100, 50, 100, 50, 0);

  translate(100, 0);
  beginShape();
  vertex(0, 0);
  bezierVertex(0, 100, 50, 100, 50, 0);
  endShape();
  //do more here! beziercurve, etc
}