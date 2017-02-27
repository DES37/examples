/* Spencer Mathews, October 2016
 *
 * A naive approach at linked spinning things
 * with concepts bordering on l-systems
 */

float theta=PI/100;  // 
PVector v;
float minMag = 10;

void setup() {
  size(500, 500);
  v = new PVector(0, height/4);
}

void draw() {
  background(255);
  
  // center the coordinate system
  translate(width/2, height/2);
  
  recursiveVector(v);
  
  v.rotate(theta);  // one way to rotate a vector around in 2D
}

/*
 *
 */
void recursiveVector(PVector v) {
  
  fill(255, 0, 0);
  line(0, 0, v.x, v.y);
  //ellipse(v.x, v.y, 10, 10);
  
  // reposition coordinate system at end of v
  translate(v.x, v.y);
  rotate(v.heading());
  // an alterinative way to do the same
  //rotate(v.heading());
  //translate(v.mag(), 0);
    
  // resursive call with stop condition
  if (v.mag() > minMag) {
    recursiveVector(v.copy().setMag(v.mag()/2));
  }
}