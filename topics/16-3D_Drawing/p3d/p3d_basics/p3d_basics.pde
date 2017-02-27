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

  size(500,500, P3D);
  
}

void draw() {
  background(255);
  noFill();
  translate(0, height/2, 0);
  for(int i=0; i<1; i++) {
    translate(width/(count+1), 0, 0);
    box(50);  // specify radius
  }
  translate(0, height/3, 0);
  sphere(50);
  
}