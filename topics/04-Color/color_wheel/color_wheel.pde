/* Spencer Mathews
 * Playing with color wheel
 * 
 */


void setup() {
  size(500, 500);
  colorMode(HSB, 255, 100, 100, 1.0);
  strokeCap(SQUARE);
}

void draw() {

  int radius = 100;
  int spacing = 2;
  
  translate(width/2, height/2);
  strokeWeight(3);
  for (int i=0; i<360; i+=spacing) {
    stroke(i, radius, radius);
    line(0, 0, width/2, 0);
    rotate(radians(spacing));
  }

  // draw black circle
  stroke(0);
  strokeWeight(1);
  noFill();
  ellipse(0, 0, width, height);
  
  surface.setTitle(int(frameRate) + " fps");
}