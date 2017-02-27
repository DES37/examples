/* Spencer Mathews
 * started: 5/2016 
 * 
 * Play with images and pixels
 */


PImage img;
PImage tmp;

float resolution = 10;

void setup() {
  //size(2880,1944);
  //img = loadImage("sO08GvE.jpg");
  //size(1440,972);
  //img = loadImage("sO08GvE-2.jpg");
  size(720, 486);
  img = loadImage("sO08GvE-4.jpg");  // Note: createImage() creates blank PImage

  //noStroke();
  //background(255);
  //noLoop();
  
  
  
}


void draw() {
  loadPixels(); 
  // Since we are going to access the image's pixels too  
  img.loadPixels(); 
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int loc = x + y*width;

      // The functions red(), green(), and blue() pull out the 3 color components from a pixel.
      float r = red(img.pixels[loc]);
      float g = green(img.pixels[loc]);
      float b = blue(img.pixels[loc]);
      
      // get HSB
      float h = hue(img.pixels[loc]);
      float s = saturation(img.pixels[loc]);
      float v = brightness(img.pixels[loc]);
      
      // Image Processing would go here
      // If we were to change the RGB values, we would do it here, 
      // before setting the pixel in the display window.
      
      if(x + y < 10) println(r, g, b);
      
      r = r > random(255) ? 255 : 0;
      g = g > random(255) ? 255 : 0;
      b = b > random(255) ? 255 : 0;

      if(x + y < 10) println(h, s, v);
      
      // Set the display pixel to the image pixel
      pixels[loc] =  color(r, g, b);
    }
  }
  println("\n");
  updatePixels();
}