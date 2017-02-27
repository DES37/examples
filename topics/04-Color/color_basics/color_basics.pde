/*  Spencer Mathews

  Explore color data type and how to retrieve current stroke and fill colors.
  
  - colors are 32 bits of information ordered as AAAAAAAARRRRRRRRGGGGGGGGBBBBBBBB
 
  PGraphics fields (- indicates read-only)
  backgroundColor
  colorMode/A/X/Y/Z
  
  -ellipseMode
  -fill
  -fillColor
  -imageMode
  -rectMode
  -shapeMode
  smooth
  -stroke
  -strokeCap
  -strokeColor
  -strokeJoin
  -strokeWeight
  -textAlign
  -textAligny
  -textFont
  -textLeading
  -textMode
  -textSize
  -tint
  -tintColor
*/

void setup() {
}

void draw() {
  color strokeColor = g.strokeColor;
  color fillColor = g.fillColor;
  color backgroundColor = g.backgroundColor;


  color c = fillColor;
  println(c, red(c), green(c), blue(c), hue(c), saturation(c), brightness(c));
}