/* Spencer Mathews
 * started: 5/2016 
 * 
 *
 * Modified from: image_static and pvector
 */


PImage img;

// possibly better performance with ArrayList?
// or maybe store as 2d array so we can search
PVector[] points;
int numPoints;

int resolution = 10;

void setup() {

  size(720, 486, FX2D);  // P2D
  img = loadImage("sO08GvE-4.jpg");  // Note: createImage() creates blank PImage
  //colorMode(HSB);

  points = new PVector[img.width*img.height];
  for (int i=0; i<points.length; i++) {
    points[i] = new PVector();
  }
}

void draw() {
  
  resolution = int(map(mouseX, 0, width, 1, 50));
  loadPixels(); 
  // Since we are going to access the image's pixels too  
  img.loadPixels();
  numPoints = 0;
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int loc = x + y*width;

      float v = brightness(img.pixels[loc]);

      // stochastic threshold, set to black or white
      v = v > random(255) ? 255 : 0;

      // put black pixels in array
      // should compute some density!
      if (x % resolution == 0 && y % resolution == 0 && v>0) {
        points[numPoints].set(x, y);
        numPoints++;
      }
      // Set the display pixel to the image pixel
      pixels[loc] =  color(v, 0, 0);
    }
  }
  println("\n");
  //updatePixels();

  background(0);
  noStroke();
  fill(255);
  for (int i=0; i<numPoints; i++) {
    ellipse(points[i].x, points[i].y, resolution, resolution);
  }
  
  // now here I sould create network
  // consider an edge detection algorithm here, too!!!
}