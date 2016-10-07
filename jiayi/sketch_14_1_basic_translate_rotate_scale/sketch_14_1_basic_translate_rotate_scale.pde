void setup() {
  size(500, 500);
  background(0);
  stroke(250);
  fill(255);
}

void draw() {

  translate(100, 100); //move the origin from (0,0) to (10,10)
  //translate (mouseX,mouseY);
  rotate (PI/4); //rotate the rectangle 45 degrees clockwise
  //float rad = radians(45);
  //rotate(rad);
  scale (1.5); //scale up 1.5 times
  rect(0, 0, 100, 50);
}