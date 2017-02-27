/* Spencer Mathews
 * 
 * started: 2016 
 */

float x;
float y;
float r;

void setup() {
  size(400,400);
  x = width/2;
  y = width/2;
  r = width/4;
}

void draw() {
  background(0);
  ellipse(x, y, r, r);
  x+=2*random(-1,1);
  y+=2*random(-1,1);
}