void setup () {
  size (600, 400);
}

void draw() {
  background(0);
  flower(100, 100); //call flower
  flower(200, 100); //call a second flower - reusability!
}

void flower(float x, float y) { //define flower
  fill(255, 0, 0);
  noStroke();
  ellipse(x, y, 20, 20);//use x and y to define the three ellipse's relative position to each other.
  ellipse(x+13, y+20, 20, 20);
  ellipse(x-11, y+20, 20, 20);
  stroke(0, 255, 0);
  line (x, y+30, x, y+100);
}