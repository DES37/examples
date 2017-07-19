/* Cycling through arrays with a pointer
 *
 * reference: https://processing.org/tutorials/arrays/
 *
 * author: Spencer Mathews
 * date: 5/2016
 * status: incomplete
 */

//this was totally slapped together, should improve and reference
// see shiffman's array tutorial

int n = 200;
// assume x and y are same length
float[] x = new float[n];
float[] y = new float[n];;
int index = 0;

void setup() {
  size(500, 500);
  // skip initialization of x and y since they default to zeros
  fill(255, 128);
}

void draw() {
  background(0);
  
  x[index] = mouseX;
  y[index] = mouseY;
  
  // advance index cycling through array
  index = (index + 1) % n;
  
  // cycle through starting at the oldest position
  for (int i = 0; i < n; i++) {
    // compute actual array index
    int pos = (index + i) % n;
    // set radius based on i
    //float r = (n - i) / 2;
    float r = 20;
    fill(255, i);
    ellipse(x[pos], y[pos], r, r);
  }
  
  surface.setTitle(int(frameRate) + " fps");
}