/* Array class
 * 
 * length
 * append(), shorten(), expand() - these make a copy, i.e. return array object
 *
 * author: Spencer Mathews
 * date: 4/2017
 * status: incomplete
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