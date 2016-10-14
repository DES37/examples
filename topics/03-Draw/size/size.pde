float zoom = 1;

void setup() {
  size(500, 500);
}

void draw() {
  background(255);

  stroke(0);
  strokeWeight(1);
  fill(255);
  scale(zoom);
  rectMode(CORNER);  // default
  rect(0, 0, width/zoom, height/2/zoom);
  rectMode(CORNERS);
  rect(0, height/2, width, height);
}