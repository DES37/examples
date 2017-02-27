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
      float r = 255-red(img.pixels[loc]);
      float g = 255-green(img.pixels[loc]);
      float b = 255-blue(img.pixels[loc]);

      // Image Processing would go here
      // If we were to change the RGB values, we would do it here, 
      // before setting the pixel in the display window.

      // Set the display pixel to the image pixel
      float a = 255-frameCount%255;
      pixels[loc] =  color(r, g, b, a);
    }
  }
  updatePixels();
}

void draw_orig() { 

  //imageMode(CORNER);  // CORNER is default imageMode
  //image(img, 0, 0);
  //imageMode(CENTER);
  //image(img, width/2, height/2 );

  // get() is easy, but pixels[] is faster
  //tmp = get();  //call get(x, y) to get single pixel or get(x, y, w, h) for block
  //image(tmp, 0, 0);

  loadPixels();
  img.loadPixels();
  //pixels[i] = 

  println(img.width, img.height);
  //img.loadPixels();
  //println(img.width, img.height);
  //pixels = img.pixels;
  //img.updatePixels();


  for (int j=0; j<height/2; j++) {
    for (int i=0; i<width/2; i++) {
      int loc = i + j*width;
      println(loc);
      pixels[loc] = color(255, 0, 0, frameCount%255); // pixels[loc];
    }
  }
  updatePixels();
}