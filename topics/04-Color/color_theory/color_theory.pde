// SM
// Primary colors: red, yellow, blue
// Secondary colors: 

//work on this!

void setup() {
  size(600, 600);
  colorMode(RGB, 255, 255, 255, 255);
  strokeWeight(5);
}

void draw() {

  int div = 3;
  float dw = width/div;
  float dh = height;

  println(div, dw, dh);

  float r, g, b;

  fill(255, 0, 0);
  rect(0, 0, dw, dh);
  fill(0, 255, 0);
  rect(0+200, 0, dw, dh);
  fill(0, 0, 255);
  rect(0, 0, 3*dw-1, dh-1);
}

/*
drawRect(float x, float y, float w, float h) {
 rect(x, y, w, h);
 }
 */