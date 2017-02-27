/* Spencer Mathews
 *
 * Play with coordinate transformations.
 * PVector is nice, but what about homogeneous coordinates?
 * affine transformations?
 *
 * Note: width and height (in PApplet) are int, so be careful with computations, should use float literals!
 *
 * started: 7/2016
 */

int numPoints = 100;
PVector[] points;
PVector p;
int scale = 200;

void setup() {
  size(500, 500, P3D);

  points = new PVector[numPoints];

  // initialize points array
  for (int i=0; i<points.length; i++) {
    //points[i] = new PVector(); 
    points[i] = PVector.random2D().mult(random(0,scale));
    p=points[i];
    println(p.x, p.y);
  }
}

void draw() {
  
  // center the origin
  translate(width/2.0, height/2.0);

  // display points
  for (PVector p : points) {
    ellipse(p.x, p.y, 2, 2);
  }
}