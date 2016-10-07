//Basic Random Circle

void setup() {
  size(640, 360);
}

void draw() {
  float x=random(0, width);
  float y=random(0, height);

  ellipse(x, y, 100, 100);
}