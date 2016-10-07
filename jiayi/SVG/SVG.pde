PShape circleShape;
float x=0, y=0;
float size;
float change;
float angle=0;

void setup() {
  size(800, 800);
  background(255);
  frameRate(12);
  circleShape=loadShape("organic_circle.svg");
}

void draw() {
  if (mouseX != 0 || mouseY != 0) {
    
    circleShape.disableStyle();
    fill(200, 200, 0, map(mouseX, 0, width, 0, 0));
    stroke(150);
    strokeWeight(0.1);
    
    translate(mouseX, mouseY);
    rotate(angle);
    angle+=random(0, 0.02);
    
    shape(circleShape, mouseX-400, mouseY-400, 400+size, 400+size);
    change=random(-10, 10);
    size+=change;
  }
}