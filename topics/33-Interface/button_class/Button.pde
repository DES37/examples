class Button {

  float x;
  float y;
  float d;
  color c;

  float over;

  Button(float x, float y, float d) {
    this.x = x;
    this.y = y;
    this.d = d;
    c = color(0);
  }

  /* Update value of over */
  void update() {
  }

  void display() {
    stroke(255);
    fill(c);
    ellipse(x, y, d, d);
  }

  void onClick() {
    if (dist(x, y, mouseX, mouseY) < d/2) {
      c = color(255);
      println("clicked");
    }
  }
}