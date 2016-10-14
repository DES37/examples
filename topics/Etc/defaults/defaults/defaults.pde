/*
Spencer Mathews
10/2015

Illustrate defaults by giving them explicitly
*/

color c;

void setup() {
  
  // Environment
  size(100,100,JAVA2D);  // or fullScreen(); sets "width" and "height" variables; renderers: JAVA2D (default), P2D, P3D, PDF
  frameRate(60);
  smooth(3);  // 2, 3, 4, 8, or noSmooth(); P2D and P3D default to 2
  
  // Rendering
  blendMode(BLEND);  // BLEND, ADD, SUBTRACT, DARKEST, LIGHTEST, DIFFERENCE, EXCLUSION, MULTIPLY, SCREEN, REPLACE
  
  // Color:Setting
    // HOW DO I KNOW THIS IS THE DEFAULT BACKGROUND?
  background(204,204,204,255);  // background(204,255);
  colorMode(RGB,255,255,255,255);
  fill(255,50);  // guess white
  stroke(0);  // guess black
  
  // Shape:Attributes
  strokeWeight(1);
  strokeCap(ROUND);  // 
  strokeJoin(MITER);  // MITER, BEVEL, ROUND
  rectMode(CORNER);  // CORNER, CORNERS, CENTER, RADIUS
  ellipseMode(CENTER);  // CENTER, RADIUS, CORNER, CORNERS
}

void draw() {
  
  ellipse(49,49,100,100);
  
  //c=get(0,0);
  //println(red(c),blue(c),green(c),alpha(c));
  
  println("width = " + width);
  println("height = " + height);
  println("frameCount = " + frameCount);
  println("frameRate = " + frameRate);
  println("focused = " + focused + "\n");
}

// pull out settings as much as accessor functions will allow
void printEnvironment() {
 
}
