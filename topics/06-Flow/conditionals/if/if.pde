// Spencer Mathews, April 2016
// Demonstrate if() conditional
// #conditionals #if

void setup() {
  size(500, 500);
  noLoop();  // use noLoop() when there is no animation
}

void draw() {
  background(0);

  float x = height/2;
  float y = width/2;
  float s = 10;
  float dx = 10;
  float dy = 10;

  for (float i=0; i<height; i+=dx)
  {
    for (float j=0; j<height; j+=dy)
    {
      rect(i, j, s, s);
    }
  }
}