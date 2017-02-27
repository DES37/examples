/* Spencer Mathews
 *
 * Example of using blendMode with colors (normally used for image processing)
 *
 * derived from Examples/Topics/Image Processing/Blending
 */


PShape rectangle;

PVector center;

void setup() {
  size(500, 500);
  center = new PVector(width/2, height/2);

  rectangle = createShape(RECT, 0, 0, 100, 50);
}

void draw() {
  background(0);
  
  fill(138);

  shape(rectangle);


}