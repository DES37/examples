/* SM, May 2016
 * Playing with the Golden Ratio
 *
 * 
 */

float phi = (1+sqrt(5))/2;  // 1.618033988749894848204586834365638117720

void setup() {
  size(809, 500);
}

void draw() {
  background(255,0,0);

  drawGoldenRectangle(0, 0, height);
}


void drawGoldenRectangle(float x, float y, float s) {
  float w=0;
  if (w<0) w=0;
  strokeWeight(w);
  float o=0;
  rect(x, y, o+x+s*phi, o+y+s);
  //rect(x, y, s, s);
  //rect(x+s, y, o+x+s*phi, y+s);
}