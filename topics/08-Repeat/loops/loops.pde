/* Demonstrate basic use of while() and for() loops
 *
 * Both types of loops are equivalent, but they have different syntax
 * and imply different purposes. Use a for() loop for counting, and use
 * a while() loop for controlling the loop with more general conditions.
 *
 * author: Spencer Mathews
 * date: 4/2016
 * tags: #loops
 * status: complete
 */

void setup() {
  size(500, 300);
  stroke(255);
  fill(0);
  noLoop();  // use noLoop() when there is no animation
}

void draw() {
  background(0);

  float s = 100;
  float dx = 100;

  // while loop
  float x = 0;
  while (x<width) {
    rect(x, 0, s, s);
    x+=dx;
  }

  // equivalent for loop
  // note that y variable here corresponds to x variable in the while loop
  for (float y=0; y<width; y+=dx) {
    rect(y, height*1/3, s, s);
  }

  // equivalent for loop using counting 
  for (float i=0; i<width/dx; i+=1) {
    float y = i*dx;
    rect(y, height*2/3, s, s);
  }
}