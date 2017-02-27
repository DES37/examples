/* Spencer Mathews
 * 
 * Array basics
 *
 * length
 * append(), shorten(), expand() - these make a copy, i.e. return array object
 *
 * started: 5/2016 
 */


float[] x, y;

void setup() {
  size(500, 500);
  x = new float[10];
  noLoop();
}

void draw() {
  println(x.length);

  y = shorten(x);
 
  y = expand(y);

  y = append(x, 0);
  
  println(y);
  println(x);
}