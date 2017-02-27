/* Spencer Mathews
 * 
 * Using text() function
 * text color is set using fill() (default=255)
 * 
 * Note: char between single quotes, Strings between double 
 *
 * started: 5/2016 
 */

int margin = 5;

void setup() {
  size(500,500);
}

void draw() {
  background(0);
  //fill(255);
  text(mouseX + ", " + mouseY, 0+margin, height-margin);  // note: single quotes will not work!
}