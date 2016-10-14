// Spencer Mathews, May 2016
// Animating with loops
// #loops #animation

float bounds=0;
float speed=1;

void setup() {
  size(500, 200);
}

void draw() {
  background(0);
  stroke(255);

  int x = 0;
  while (x<bounds) {
    line(x, 0, x, height);
    x+=1;
  }
  
  bounds+=speed;
}