/* Spencer Mathews
 * 
 * Map image pixels to 2D (
 * Set cellsize. Color is set through 
 * modified from image_3d
 * derived from: Learning Processing Example 15-15: 2D image mapped to 3D
 *
 * started: 5/2016
 */

PImage img;       // The source image
int cellcount; // Number of cells into which width is divided
float cell_w, cell_h;   // Cell dimensions

void setup() {
  size(720, 486);
  img = loadImage("sO08GvE-4.jpg"); // Load the image
}

void draw() {
  background(255);

  cellcount = int(map(mouseX, 0, width, 2, width));
  cell_w = width/cellcount;
  cell_h = height/floor(height/cell_w);
  println(cellcount, cell_w, cell_h);


  img.loadPixels();


  // Begin loop for columns
  for (int i = 0; i+cell_w/2 < width; i+=cell_w ) {
    // Begin loop for rows
    for (int j = 0; j+cell_h/2 < height; j+=cell_h ) {
      float x = i + cell_w/2; // x position
      float y = j + cell_h/2; // y position
      int loc = int(x + y*width);           // Pixel array location
      color c = img.pixels[loc];       // Grab the color

something is weird!!

      // Translate to the location, set fill and stroke, and draw the rect
      pushMatrix();
      translate(x, y); 
      fill(c);
      noStroke();
      rectMode(CENTER);
      rect(0, 0, cell_w, cell_h);
      popMatrix();
    }
  }

  //// Begin loop for columns
  //for (int i = 0; i < cols; i++ ) {
  //  // Begin loop for rows
  //  for (int j = 0; j < rows; j++ ) {
  //    int x = i*cellsize + cellsize/2; // x position
  //    int y = j*cellsize + cellsize/2; // y position
  //    int loc = x + y*width;           // Pixel array location
  //    color c = img.pixels[loc];       // Grab the color
  //    // Map brightness to a z position as a function of mouseX
  //    //float z = map(brightness(img.pixels[loc]), 0, 255, 0, mouseX);
  //    // Translate to the location, set fill and stroke, and draw the rect
  //    pushMatrix();
  //    translate(x, y); 
  //    fill(c);
  //    noStroke();
  //    rectMode(CENTER);
  //    rect(0, 0, cellsize, cellsize);
  //    popMatrix();
  //  }
  //}
}