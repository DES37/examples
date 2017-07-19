/* Array basics
 * 
 * reference:
 *   https://processing.org/tutorials/arrays/
 *   https://processing.org/examples/array.html
 *
 * author: Spencer Mathews
 * date: 5/2016
 * status: incomplete
 */

// think about this example, perhaps try color

// declare array variable
float[] x;

void setup() {
  size(500, 500);

  // allocate space in memory for array using "new" keyword
  x = new float[10];

  // initialize array elements
  for (int i = 0; i < x.length; i++) {
    x[i] = i;
  }

  noLoop();
}

void draw() {
  float dx = width/x.length;
  for (int i = 0; i < x.length; i++) {
    rect(i*dx, 0, dx, x[i]*height/max(x));
  }

  println(max(x));

  println(x.length);  // length of array is stored in "length" property
  println(x);  // println() outputs array if it's the only argument, note print() will not
}