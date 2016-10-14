/* SM, May 2016
 *
 *
 * Derived from https://processing.org/examples/constrain.html
 */
 
 
float mx;
float my;
float easing = 0.05;
int radius = 24;
int edge = 100;
int inner = edge + radius;

void setup() {
  size(640, 360);
  //noStroke(); 
  ellipseMode(RADIUS);
  rectMode(CORNERS);
}

void draw() { 
  background(51);
  
  //if (abs(mouseX - mx) > 0.1) {
    mx = mx + (mouseX - mx) * easing;
  //}
  //if (abs(mouseY - my) > 0.1) {
    my = my + (mouseY- my) * easing;
  //}
  
  mx = constrain(mx, inner, width - inner);
  my = constrain(my, inner, height - inner);
  fill(76);
  rect(edge, edge, width-edge, height-edge);
  ellipse ( width/2, height/2, edge, edge);
  fill(255);  
  ellipse(mx, my, radius, radius);
  
}