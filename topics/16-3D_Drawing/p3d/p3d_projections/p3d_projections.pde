/* Spencer Mathews
 * 
 * Using 3D projections
 * perspective()
 * ortho()
 * camera()
 *
 * The default values are: 
 * float cameraZ=(height/2.0) / tan(PI*60.0/360.0);
 * perspective(PI/3.0, width/height, cameraZ/10.0, cameraZ*10.0);
 *
 * started: 5/2016 
 */

int count=3;

void setup() {
  size(600, 600, P3D);
}

void draw() {
  background(255);

  if (mousePressed) {
    //default: ortho(-width/2, width/2, -height/2, height/2);
    ortho(0, width, 0, height);
  } else {
    // default perspective
    float fov = PI/3;
    float cameraZ = (height/2.0) / tan(fov/2.0);
    perspective(fov, float(width)/float(height), cameraZ/10.0, cameraZ*10.0);
  }
  
  printProjection();
  printCamera();

  int z = mouseY; //height/2 - mouseY;
  text(z, 50, 50);

  noFill();
  translate(0, height/2, z);
  for (int i=0; i<count; i++) {
    translate(width/(count+1), 0, 0);
    box(10);  // specify radius
  }
}