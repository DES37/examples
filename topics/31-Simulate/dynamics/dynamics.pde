/*
 *
 * References:
 * http://www.algosome.com/articles/lorenz-attractor-programming-code.html
 * http://introcs.cs.princeton.edu/java/94diffeq/
 *
 */

Lorenz l = new Lorenz();

void setup() {
}

void draw() {
}

class Lorenz {
  float t = 0.1;
  float sigma = 10;  // a
  float rho = 28;  // b
  float beta = 8.0/3.0;  // c
  float x=0;
  float y=0;
  float z=0;

  void setParams(float sigma, float rho, float beta) {
  }

  void update() {

    // a very simple and silly simulation
    float xt = x + t * sigma * (y - x);
    float yt = y + t * (x * (rho - z) - y);
    float zt = z + t * (x * y - beta * z);
  }
}