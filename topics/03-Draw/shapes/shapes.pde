/* Demonstrate primitive shapes
 * Spencer Mathews, April 2016
 * 
 * #shapes
 */

void setup() {
  size(500, 500);
  //background(0);
  noLoop();  // use noLoop() when there is no animation
}

void draw() {
  rect(25, 25, 50, 50);
  ellipse(150, 150, 50, 50);
  point(250, 250);  //
}