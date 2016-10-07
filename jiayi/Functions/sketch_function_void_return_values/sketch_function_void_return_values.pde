/*Jack gets paid for lease of his circular land.
Enter an r to see $ amount. */

float r=200;

void setup () {
  size(500, 500);
  noLoop();
}

void draw() {
  land(width/2, height/2);
  text("Pay Jack: $" + area(), 100, 100);
}

void land(float xLocation, float yLocation) {
  noStroke();
  fill(0, 200, 0);
  ellipse (xLocation, yLocation, r, r);
}

float area() {
  float calculateArea=2*PI*r;
  return calculateArea;
}