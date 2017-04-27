/* Spencer Mathews
 *
 * Example of using blendMode with colors (normally used for image processing)
 *
 * derived from Examples/Topics/Image Processing/Blending
 */



//blend test

color red;
color green;
color blue;
// BLEND, ADD, SUBTRACT, DARKEST, LIGHTEST, 
// DIFFERENCE, EXCLUSION, MULTIPLY, SCREEN, REPLACE
int[] blend_mode = { BLEND, ADD, SUBTRACT, DARKEST, LIGHTEST, 
  DIFFERENCE, EXCLUSION, MULTIPLY, SCREEN, REPLACE };

void setup() {
  size(300, 1000);
  //colorMode(HSB, 255, 100, 100);
  red = color(255, 0, 0);
  green = color(0, 255, 0);
  blue=color(0, 0, 255);
}

void draw() {

  //background(0);
  fill(0);
  rect(0, 0, width/2, height);
  fill(255);
  rect(width/2, 0, width, height);
  noStroke();

  float d = height/10;

  fill(red, 50);
  // BLEND, ADD, SUBTRACT, DARKEST, LIGHTEST
  // DIFFERENCE, EXCLUSION, MULTIPLE, SCREEN, REPLACE
  blendMode(BLEND);

  for (int j=0; j<=height-d; j+=d) {
    ellipse(width/2, j+d/2, d, d);
    println(j);
  }

  float j = d/2;
  int b = 0;
  float x;
  fill(green, 50);
  while (j<=height-d/2) {
    blendMode(blend_mode[b++ % blend_mode.length]);
    ellipse(width/2-d/2, j, d, d);
    ellipse(width/2+d/2, j, d, d);
    j = j+d;
  }

  //fill(red, 50);
  //blendMode(BLEND);
  //ellipse(width/2-d/4, d/2, d, d);
  //fill(red, 50);
  //blendMode(ADD);
  //ellipse(width/2+d/4, d/2, d, d);
}