void setup() {
  size(1000, 800);
  background(255);
  //fullScreen();
}

void draw() {
  for (float x=60; x<950; x+=10) {
    for (float y=60; y<750; y+=10) {
      point(x, y);
    }
  }

  for (float i=150; i<width-50; i+=100) {
    fill(255, 0, 0);
    noStroke();
    for (float j=150; j<height-50; j+=100) {
      ellipse(i, j, 1, 1);
    }
  }

  noFill();
  stroke(150);
  rect(50, 50, 900, 700);
  
  saveFrame("graph.tif");
  
}