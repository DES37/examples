
/* Spencer Mathews, 11/2016
 *
 * Illustrate how to mirror/flip shapes using scale(), e.g. scale(-1.0,1.0)
 *
 * FIGURE THIS OUT STILL! figure out the algebra may need to scale and rotate!
 */



void setup() {
  size(500, 500);
  colorMode(HSB, 360, 100, 100, 1.0);
}
void draw() {
  background(0, 0, 99);  // white in HSB according to color selector, other sources say 0,0,100
  translate(width/2.0, height/2.0);

  stroke(0, 0, 0);  // black
  //scale(1,1);
  drawThing();

  stroke(0, 99, 99);  // red
  pushMatrix();
  scale(-1, 1);
  drawThing();
  popMatrix();

  stroke(119, 99, 99);  // green
  pushMatrix();
  scale(1, -1);
  drawThing();
  popMatrix();

  stroke(239, 99, 99);  // blue
  pushMatrix();
  scale(-1, -1);
  drawThing();
  popMatrix();
}

void drawThing() {
  float theta = radians(3);
  // draw in the +x/+y quadrant in increments of theta
  for (float i=0; i<radians(90)/theta; i++) {
    // i*theta gives the current angle (in radians) so scale that to give reasonable line length
    float len = map(i*theta, 0, radians(90), 0, height/2);
    // set stroke color assuming that theta stays below radians(90)
    //stroke(map(i*theta, 0, HALF_PI, 0, 360), 100, 100);
    strokeWeight(2);
    line(0, 0, len, 0);
    rotate(theta);
  }
}