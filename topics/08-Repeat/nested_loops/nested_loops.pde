/* Demonstrate nested for loops
 *
 * author: Spencer Mathews
 * date: 4/2016
 * tags: #loops
 */

void setup() {
  size(500, 500);
  noLoop();  // use noLoop() when there is no animation
}

void draw() {
  background(0);

  float dx = 10;
  float dy = 10;
  float w = dx;
  float h = dy;

  for (float x=0; x<height; x+=dx)
  {
    for (float y=0; y<height; y+=dy)
    {
      rect(x, y, w, h);
    }
  }
}