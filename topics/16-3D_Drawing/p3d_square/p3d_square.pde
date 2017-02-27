/* Spencer Mathews, 11/2016
 *
 * 3D rendering of a fun window ornament
 */

// contours in 3d?
// NOW ADD SOME THICKNESS!

// review camera, and how up axis is oriented wrt positive/negative and if y is a special case?
// default parameters 0,1,0 maintain the convention of -y being up!
// but what about x?

void setup() {
  size(500, 500, P3D);
}
void draw() {
  background(0);
  lights();
  // map mouse range to get exaggerated change in perspective
  camera(map(mouseX, 0, width, -width, 2*width), map(mouseY, 0, height, -height, 2*height), (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  // can switch direction for more natural interaction by width-mouseX, height-mouseY

  hollowSquares(width/2, height/2, 0, 400, 10);
}

// could make hollowSquare recursive, or iterterative like this
// may want to take an n parameter which is the number of squares to have, and compute s from that, might make the center piece more consistent and better looking 
// and think of other fun ways to parameterize, such as number of times to 
void hollowSquares(float x, float y, float z, float d, float s) {
  translate(x, y, z);
  
  float r = 0;
  float dr = PI/(floor(d/(2*s)-1));  // compute so small one is in same plane as first
  while (d>=2*s) {
    hollowSquare(0, 0, 0, d, s);
    rotateY(dr);
    d = d-2*s;
  }
}

/*
 *
 */
void hollowSquare(float x, float y, float z, float d, float s) {
  float r = d/2;

  noStroke();
  beginShape();
  // Exterior part of shape, clockwise winding (required?)
  vertex(-r, -r);
  vertex(r, -r);
  vertex(r, r);
  vertex(-r, r);
  // Interior part of shape, counter-clockwise winding (opposed of exterior!)
  beginContour();
  vertex(-(r-s), -(r-s));
  vertex(-(r-s), r-s);
  vertex(r-s, r-s);
  vertex(r-s, -(r-s));
  endContour();
  endShape(CLOSE);
}