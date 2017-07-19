/* 
 *
 * Spencer Mathews
 */


Button b;

void setup() {
  size(500,500);
  b = new Button(width/2, height/2, 50);
}
void draw() {
  background(0);
  float f = width;
  b.display();
}

void mousePressed(){
}

void mouseReleased(){
}

void mouseClicked(){
  b.onClick();
}