/* Spencer Mathews
 * 
 * Explore 3d
 * box and sphere are basic 3d shapes, no positional arg so much translate
 * box - specify x, y, z dimensions
 * sphere - specify radius
 * started: 5/2016 
 */

int count=3;

void setup() {
  size(600,600, P3D);
}

void draw() {
  background(255);
  int z = mouseY; //height/2 - mouseY;
  println(z);
  text(z, 50, 50);

  noFill();
  translate(0, height/2, z);
  for(int i=0; i<count; i++) {
    translate(width/(count+1), 0, 0);
    box(10);  // specify radius
  }
}