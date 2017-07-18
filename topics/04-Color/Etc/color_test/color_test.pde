/* Experiment to text numerical bounds of color ranges
 * Conclusions:
 *   RGB:
 *     
 * author: Spencer Mathews
 * date: 11/2016
 * status: incomplete
 */

color c;
color c1;
color c2;

int i=256;
float j=256;

void setup() {
  noLoop();
  //frameRate(10);
}

void draw() {

  //test();
  testGray();
  //testRGB();

  //if (color(128) == color(128, 128, 128)) {
  //  println("color(x) == color(x,x,x)");
  //}
}

void printColor(color c) {
  println(c, hex(c1), red(c), green(c), blue(c), alpha(c), hue(c), saturation(c), brightness(c));
}

// get PGraphics fields
// RGB=1, HSB=3
// note: ARGB=2 and ALPHA=4 seem only useful for specifying the format of a PImage, along with RGB
void printColorMode() {
  println(g.colorMode, g.colorModeX, g.colorModeY, g.colorModeZ, g.colorModeA);
}

void test() {
  println(i);

  colorMode(RGB, 25, 25, 25, 25);

  c = color(i);
  printColor(c);
  //i++;
  println(red(c));
  fill(c);
  rect(0, 0, width/2, height);

  c = color(j);
  //j++;
  println(red(c));
  fill(c);
  rect(width/2, 0, width/2, height);
}

/* conclusion: when setting color(gray) you must should use int argument!
 with int args values are clamped to bounds [0,255]
 but with float args values are constrained to bounds [0,255]
 */
void testGray() {
  colorMode(RGB, 255);  // setting max as a single parameter applies to all rgba channels 
  printColorMode();

  println("\nGray:");
  for (float r=-2; r<260; r+=.5) {
    c1 = color(r);
    c2 = color(int(r));
    if (c1 == c2) {
      print("== ");
    } else {
      print("!= ");
    }
    println(r, int(r));
    println(c1, hex(c1), red(c1));
    println(c2, hex(c2), red(c2));
  }
}


/* conclusion: when setting color(v1, v2, v3) can give int or float
 values are constrained to bounds [0,255], i.e. -1==0, 256==255
 */
void testRGB() {

  println("(", g.colorModeX, g.colorModeY, g.colorModeZ, g.colorModeA, ")");

  colorMode(RGB, 255, 255, 255, 255);

  println("\nRgb:");
  for (float r=0; r<257; r++) {
    c1 = color(r, 0, 0);
    c2 = color(r-1, 0, 0);
    if (c1 == c2) {
      println(r, hex(c1), red(c1), red(c2));
    }
  }

  println("\nrgbA:");
  for (float a=0; a<257; a++) {
    c1 = color(a, 0, 0);
    c2 = color(a-1, 0, 0);
    if (c1 == c2) {
      println(a, hex(c1), alpha(c1), alpha(c2));
    }
  }
}


void testHSB() {

  colorMode(HSB, 360, 100, 100, 1);

  print ("\nHsb: ");
  for (int h=0; h<362; h++) {
    c1 = color(h, 100, 100);
    c2 = color(h-1, 100, 100);
    if (c1 == c2) {
      print(h, "");
    }
    //println(h, c1, hex(c1));
  }

  print ("\nhSb: ");
  for (int s=0; s<102; s++) {
    c1 = color(0, s, 100);
    c2 = color(0, s-1, 100);
    if (c1 == c2) {
      print(s, "");
    }
    //println(s, c1, hex(c1));
  }

  print ("\nhsB: ");
  for (int b=0; b<102; b++) {
    c1 = color(0, 100, b);
    c2 = color(0, 100, b-1);
    if (c1 == c2) {
      print(b, "");
    }
    //println(b, c1, hex(c1));
  }
}

// incomplete, try to understand how to reconcile 8-bits per RGB channel with arbitrary ranges for RGB and HSB
void detailsHSB() {
  // 360./255. = 1.41176...
  // 360./256. = 1.406
  //print ("\nstuff: ");
  float step = 360./256.;
  for (float h=0; h<370; h+=step) {
    c1 = color(h, 100, 100);
    c2 = color(h-step, 100, 100);
    //if (c1 != c2) {
    //  println("YODSFDSFDS");
    //}

    //println(h, c1, hex(c1), hue(c1));

    //c1 = color(h-step/10., 100, 100);
    //println(h, c1, hex(c1), red(c1), green(c1), blue(c1), alpha(c1), hue(c1), saturation(c1), brightness(c1));
    //c1 = color(h+step/10., 100, 100);
    //println(h, c1, hex(c1), red(c1), green(c1), blue(c1), alpha(c1), hue(c1), saturation(c1), brightness(c1));
  }
}