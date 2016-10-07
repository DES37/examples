

void setup () {
  size (600, 400);
}

void draw() {
  background(0);
  flower();
}

void flower() {
  fill(255, 0, 0);
  noStroke();
  ellipse(93, 100, 20, 20);
  ellipse(80, 80, 20, 20);
  ellipse(69, 100, 20, 20);
  stroke(0, 255, 0);
  line (80, 110, 80, 180);
}