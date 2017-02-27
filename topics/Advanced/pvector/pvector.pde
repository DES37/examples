/* Spencer Mathews
 *
 *
 * started: 8/2016
 */


PVector p;

void setup() {

  size(500, 500);
  p = new PVector(100,0);

  //println(p.x, p.y);
}


void draw() {
  background(0);
  stroke(255);

  // center the origin
  translate(width/2, height/2);

  line(0,0, p.x, p.y);
  ellipse(p.x, p.y, 10, 10);
  println(degrees(p.heading()));
  text(p.heading(), p.x, p.y); 
  p.y = p.y+.1;
}