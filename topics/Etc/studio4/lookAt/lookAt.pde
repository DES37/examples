/* Spencer Mathews, October 2016
 *
 * Following mouse using several techniques
 * 
 * More math is required to enforce precise circular bounds.
 * Some methods are only approximate.
 * Not all properly handle when mouse is within range.
 * 
 * #mouse #math
 */

void setup() {
  size(500, 500);
}

void draw() {
  background(0);

  lookAt(width/3, height/2, 25);
  lookAt(2*width/3, height/2, 25);
}

/* Ways to follow mouse coordinates
 *
 * need x and y parameters at minimum
 * d (diameter) parameter is used to compute outer diameter and range for convenience
 */
void lookAt(float x, float y, float d) {

  fill(255);
  ellipse(x, y, d*4, d*4);  // draw outer circle

  // Precise bounds using constrain. Angle to mouse is considered
  // when computing range. Properly handles mouse in outer circle.
  //float theta = atan2(mouseY-y, mouseX-x);
  //float rangeX = abs(cos(theta)*d/2);
  //float rangeY = abs(sin(theta)*d/2);
  //float dx = constrain(mouseX, x-rangeX, x+rangeX);
  //float dy = constrain(mouseY, y-rangeY, y+rangeY);

  // Rotate according to angle. Allows circular motion only
  // because we compute the point along the line from x,y to mouseX, mouseY
  // that is distance d/2 from x,y.
  //float theta = atan2(mouseY-y, mouseX-x);
  //float dx = x+cos(theta)*d/2;
  //float dy = y+sin(theta)*d/2;

  // Square bounds using constrain. Mouse is not precisely followed,
  // but just constrained about x,y by some range.
  //float range = d;
  //float dx = constrain(mouseX, x-range, x+range);
  //float dy = constrain(mouseY, y-range, y+range);

  // Square bounds using map. Mouse is not actually followed,
  // but offset from center as mouse position is to display window
  // to give the illusion of following.
  float range = d;
  float dx = x+map(mouseX, 0, width, -range, range);
  float dy = y+map(mouseY, 0, height, -range, range);

  fill(0);
  ellipse(dx, dy, d, d);  // draw inner circle that moves
}