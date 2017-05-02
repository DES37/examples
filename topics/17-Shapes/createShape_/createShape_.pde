/*
 * best practice is to createShape about the origin and translate
 *
 * ref: https://processing.org/tutorials/pshape/
 *
 * author: Spencer Mathews
 * status: incomplete
 */

PShape vertexShape;
PShape ellipseShape;
PShape rectShape;
PShape arcShape;
PShape triangleShape;
PShape quadShape;
PShape lineShape;

/* 3D Shapes */
//PShape sphereShape;
//PShape boxShape;

PShape groupShape;

void setup() {
  size(500, 500);
  float d = 50;
  ellipseShape = createShape(ELLIPSE, 0, 0, d, d);
  rectShape = createShape(RECT, 0, 0, d, d);
  arcShape = createShape(ARC, 0, 0, d, d, 0, HALF_PI);
  triangleShape = createShape(TRIANGLE, 0, 0, 10, 10, -10, 10);
  quadShape = createShape(QUAD, d, d, -d, d, -d, -d, d, -d);
  lineShape = createShape(LINE, -d, 0, d, 0);

  //sphereShape = createShape(SPHERE,0,0, d, d);
  //boxShape = createShape(BOX);
}
void draw() {
  shape(ellipseShape, 100, 100);
  shape(rectShape, 100, 100);
  shape(arcShape, 100, 100);
  shape(triangleShape, 100, 100);
  shape(quadShape, 100, 100);
  shape(lineShape, 100, 100);

  //shape(sphereShape, 100,100);
  //shape(boxShape, 100,100);
}