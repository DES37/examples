// Spencer Mathews, April 2016
// Demonstrate the color data type
// colors are 32 bits of information ordered as AAAAAAAARRRRRRRRGGGGGGGGBBBBBBBB
// #color

void setup() {
  size(400, 400);
  noLoop();  // use noLoop() when there is no animation
}

void draw() {
  background(0);

  color c;

  c = color(255, 0, 0);
  fill(c);
  ellipse(100, 100, 200, 200);
  println(hex(c), red(c), green(c), blue(c), alpha(c));

  // weird! if c is a color with alpha then specifying alpha here does nothing!
  c = color(255, 0, 0, 204);
  // when you do this it is applying the new alpha to the rgba values in c!
  // this is true if you do color(c, alpha) or fill(c,alpha)
  c = color(c, 204);
  fill(c, 204);
  ellipse(100, 300, 200, 200);
  println(hex(c), red(c), green(c), blue(c), alpha(c));

  // web color notation (opaque only)
  c = #FF0000;
  fill(c, 204);
  ellipse(300, 300, 200, 200);
  println(hex(c), red(c), green(c), blue(c), alpha(c));

  // web notation plus alpha using color()
  c = color(#FF0000, 204);
  fill(c);
  ellipse(300, 100, 200, 200);
  println(hex(c), red(c), green(c), blue(c), alpha(c));

  // hexadecimal notation
  c = 0xCCFF0000;
  fill(c);
  ellipse(300, 100, 200, 200);
  println(hex(c), red(c), green(c), blue(c), alpha(c));
}