/* SM, May 2016
 *
 *
 * 
 */


float mx;
float my;

int radius = 20;
int edge = 100;
int inner = edge + radius;

void setup() {
  size(500, 500);
  //noStroke(); 
  ellipseMode(RADIUS);
  rectMode(CORNERS);
}

void draw() { 
  background(51);

  mx = mx + (mouseX - mx);

  my = my + (mouseY- my);


  //mx = constrain(mx, inner, width - inner);
  //my = constrain(my, inner, height - inner);
  fill(76);
  ellipse ( width/2, height/2, radius*3, radius*3);
  fill(255);  
  ellipse(mx, my, radius, radius);
}