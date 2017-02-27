/* Spencer Mathews
 *
 * Use get() to retrieve the color of a pixel on the display canvase
 *
 * #PImage #get
 *
 * started: 7/2016
 */

PImage img;       // The source image

void setup() {
  size(720, 486);
  img = loadImage("sO08GvE-4.jpg"); // Load the image
}

void draw() {

  // display image
  image(img, 0, 0);

  // save mouse position to variables
  int x = mouseX;
  int y = mouseY;

  // get color under mouse and draw crosshair lines
  color c = get(mouseX, mouseY);
  stroke(c);
  line(x, 0, x, height);
  line(0, y, width, y);

  // display color using its inverse
  color inverse = color(255-red(c), 255-green(c), 255-blue(c));  // this is the recommended foolproof way to invert a color
  fill(inverse);
  text(hex(c), 0, height);
  println(hex(c));
}