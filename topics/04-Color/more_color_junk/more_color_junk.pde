/* Spencer Mathews, 11/2016
 *
 * Iterate over color space
 *
 * Incomplete
 */

void setup() {
  size(500, 500);
  colorMode(HSB, 360, 100, 100);
}
void draw() {
  background(0);

  //hueLines();
  hueRects();
  //saturationRects();
}

void hueLines() {
  // iterate over all 360 HSB hues
  for (int i=0; i<360; i++) {
    // think about whether or not it makes sense to user int or float division in computing x
    float x = i*width/360.0;  // compute proper x position

    // lay down lines to fill the space
    stroke(i, 100, 100);
    for (int j=0; j<width/360.0; j++) {
      line(x+j, 0, x+j, height);
    }
  }
}

// need to fix rect width to scale properly with arbitrary width
void hueRects() {
  // iterate over all 360 HSB hues
  for (int i=0; i<360; i++) {
    // think about whether or not it makes sense to user int or float division in computing x
    float x = i*width/360.0;  // compute proper x position
    float w = x-(i+1)*width/360.0;

    noStroke();
    fill(i, 100, 100);
    //rect(x, 0, width/360.0, height);
    rect(x, 0, w, height);
  }
}

void saturationRects() {
  // iterate over all 360 HSB hues
  for (int i=0; i<360; i++) {
    // think about whether or not it makes sense to user int or float division in computing x
    float x = i*width/360.0;  // compute proper x position

    // iterate over saturations
    for (int j=0; j<100; j++) {
      float y = j*height/100.0;  // compute proper y position
      //println(y);

      noStroke();
      fill(i, j, 100);
      
      // ceil is a hack, not perfect, improve sometime
      rect(x, y, ceil(width/360.0), height/100.0);
    }
  }
}