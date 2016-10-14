void setup() {
  size(500, 500);
}
void draw() {
  background(255);
  int x, y;
  x = width/2;
  y = height/2;
  ellipse(x, y, width, height);
  ellipse(x, y, width/2, height/2);
  line(x, y, mouseX, mouseY);
  println(dist(0, 0, 1, 1));
}