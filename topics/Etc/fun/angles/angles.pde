/* Spencer Mathews
 * 9/2016
 *
 * Color by angle from mouse at some distance
 * 
 * Notes: Navigate by mouse position and using the up/down arrows
 * consider using HSB and color
 *
 * modified from https://processing.org/examples/array2d.html
 *
 */

float[][] angles;
float angle;

PVector vpixel, vmouse;  // vectors pointing from pixel
float elevation;  // effective elevation of mouse in 3d

void setup() {
  size(640, 360, FX2D);

  angles = new float[width][height];
  
  vpixel = new PVector();
  vmouse = new PVector();
  elevation = 0;
}

void draw() {
  background(0);

  if (keyPressed) {
    if (key == CODED) {
      if (keyCode == UP) {
        elevation++;
      } else if (keyCode ==DOWN) {
        elevation--;
      }
    }
  }

  spacedAngles(5);
  //pixelAngles();
  println(elevation);
}

/*
 * Color each pixel based on angle wrt mouse, using points
 */
void spacedAngles(float spacer) {
  // This embedded loop skips over values in the arrays based on
  // the spacer variable, so there are more values in the array
  // than are drawn here. Change the value of the spacer variable
  // to change the density of the points
  for (int y = 0; y < height; y += spacer) {
    for (int x = 0; x < width; x += spacer) {
      // compute angle of vector between mouse 3d and pixel
      vmouse.set(mouseX-x, mouseY-y, elevation);  // vector from pixel to mouse 
      vpixel.set(mouseX-x, mouseY-y, 0);  // vector pixel to mouse coordinates projected onto plane
      angle = PVector.angleBetween(vmouse, vpixel);
      angles[x][y] = angle/HALF_PI * 255;  // scale

      stroke(angles[x][y]);  // set stroke by distance
      strokeWeight(spacer/2);
      point(x + spacer/2, y + spacer/2);
    }
  }
}

/*
 * Color each pixel based on angle wrt mouse, using pixels[]
 */
void pixelAngles() {
  loadPixels();
  // Loop through every pixel column
  for (int x = 0; x < width; x++ ) {
    // Loop through every pixel row
    for (int y = 0; y < height; y++ ) {
      // compute angle of vector between mouse 3d and pixel
      vmouse.set(mouseX-x, mouseY-y, elevation);  // vector from pixel to mouse 
      vpixel.set(mouseX-x, mouseY-y, 0);  // vector pixel to mouse coordinates projected onto plane
      angle = PVector.angleBetween(vmouse, vpixel);

      int loc = x + y * width;
      pixels[loc] = color(angle/HALF_PI * 255);  // scale
    }
  }
  updatePixels();
}