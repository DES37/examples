/* Spencer Mathews
 * 
 * 3d sphere
 * sphere - specify radius, no positional arg so much translate
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
  text(z, 50, 50, 0);

  noFill();
  translate(0, height/2, z);
  for(int i=0; i<count; i++) {
    translate(width/(count+1), 0, 0);
    sphere(10);  // specify radius
  }
}