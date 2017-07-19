/* Demonstrate nested for loops which increment by one
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

  float s = 20;

  for (float i=0; i<height; i++)
  {
    for (float j=0; j<height; j++)
    {
      if ( (i+j)%2 == 0 ) {
        fill(0);
      } else {
        fill(255);
      }
      rect(i*s, j*s, s, s);
    }
  }
}