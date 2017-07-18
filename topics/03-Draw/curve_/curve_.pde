/* Demonstrate primitive shapes
 * Spencer Mathews, 5/2017
 * Note: strangely curve() not actually covered in Ch 3
 *
 * #shapes #etc
 */

void setup() {
  size(500, 500);

  //noLoop();  // use noLoop() when there is no animation
}

void draw() {
  background(128);
  
  float x1 = 200;
  float y1 = 250;
  
  float x2 = 200;
  float y2 = 250;
  
  float x3 = 300;
  float y3 = 250;
  
  float x4 = 300;
  float y4 = 250;
  
  curve(x1, y1, x2, y2, x3, y3, x4, y4);


  ellipse(x1, y1, 5, 5);
  ellipse(x2, y2, 5, 5);
  ellipse(x3, y3, 5, 5);
  ellipse(x4, y4, 5, 5);

}