/* Spencer Mathews
 * 
 * Using filter() function.
 * There are a number of predefined kinds of filters
 * THRESHOLD, GRAY, OPAQUE, INVERT, POSTERIZE, BLUR, ERODE, or DILATE
 * each has their own parameters.
 * Alternatively, a PShader can be applied.
 * 
 * see:
 * https://processing.org/reference/filter_.html
 * https://processing.org/tutorials/pixels/
 *
 * started: 7/2016 
 */


work on this!

PImage img;

void setup() {
  size(720, 486);
  img = loadImage("sO08GvE-4.jpg");  // Note: createImage() creates blank PImage
}

void draw() {

  img.loadPixels();

  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int loc = x + y*width;

      // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
      float r = red(255-img.pixels[loc]);
      float g = green(255-img.pixels[loc]);
      float b = blue(255-img.pixels[loc]);

      // Image Processing would go here
      // If we were to change the RGB values, we would do it here, 
      // before setting the pixel in the display window.

      // Set the display pixel to the image pixel
      float a = 255-frameCount%255;
      pixels[loc] =  color(r, g, b, a);
    }
  }
  img.updatePixels();


  image(img, 0, 0);

  //filter(THRESHOLD);
  filter(THRESHOLD, 0.5);
  //filter(THRESHOLD, map(mouseX, 0, width-1, 0, 1));

  //filter(GRAY);
  //filter(OPAQUE);
  //filter(INVERT);
  //filter(POSTERIZE); 
  //filter(BLUR);
  //filter(ERODE); 
  //filter(DILATE);
}