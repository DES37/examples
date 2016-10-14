// Spencer Mathews, April 2016
// Demonstrate nested for loops
// #loops

void setup() {
  size(500, 500);
  noLoop();  // use noLoop() when there is no animation
}

void draw() {
  background(0);

  float s = 10;
  float dx = 10;
  float dy = 10;

  for (float x=0; x<height; x+=dx)
  {
    for (float y=0; y<height; y+=dy)
    {
      rect(x, y, s, s);
    }
  }
}