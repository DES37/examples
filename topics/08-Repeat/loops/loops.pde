// Spencer Mathews, April 2016
// Demonstrate basic use of while() and for() loops

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
  float dy = 20;
  
  // a while loop
  float i=0;
  while (i<width) {
    ellipse(i, y, s, s);
    i+=dx;
  }

  // a for loop which is roughly equivalent
  // note the
  for (float j=0; j<height; j+=dy)
  {
    rect(y, j, s, s);
  }
}